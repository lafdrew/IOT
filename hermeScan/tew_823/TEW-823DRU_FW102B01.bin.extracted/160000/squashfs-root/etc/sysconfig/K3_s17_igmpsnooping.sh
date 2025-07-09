#!/bin/sh
echo "begin K3_s17_igmpsnooping.sh"
echo "end K3_s17_igmpsnooping.sh"
exit;

# The way to disable HW igmp snooping
ethreg -i eth0 0x624=0x007f7f7f
ethreg -i eth0 0x618=0x50e8002b
ethreg -i eth0 0x214=0x00000000
ethreg -i eth0 0x210=0x00000000

