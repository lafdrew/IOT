#!/bin/sh

echo "begin S3_s17_igmpsnooping.sh"

echo "S17, enable HW igmp snooping"
ethreg -i eth0 0x624=0x3F3F213F
ethreg -i eth0 0x618=0x50f8002b
ethreg -i eth0 0x214=0x01060606
ethreg -i eth0 0x210=0x06060600


echo "end S3_s17_igmpsnooping.sh"
# The way to disable HW igmp snooping
# ethreg -i eth0 0x624=0x007f7f7f
# ethreg -i eth0 0x618=0x50e8002b
# ethreg -i eth0 0x214=0x00000000
# ethreg -i eth0 0x210=0x00000000

