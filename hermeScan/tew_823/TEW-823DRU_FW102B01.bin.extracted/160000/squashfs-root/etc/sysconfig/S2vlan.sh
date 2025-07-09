#!/bin/sh
echo "begin $0"
hnat_status(){
	ret=`nvram get hnat_enable`
	echo "$ret"
}

hnat_enable=$(hnat_status)

#if [ "$hnat_enable" = "0" ]; then
#	echo "Inserting switch driver - HNAT NOT enable ..."
#	insmod /lib/modules/2.6.31/net/athrs_gmac.ko enable_l3_offload=0
#else
#	echo "Inserting switch driver - HNAT enable ..."
#	insmod /lib/modules/2.6.31/net/athrs_gmac.ko enable_l3_offload=1
#fi

#insmod /lib/modules/2.6.31/net/athrs_gmac.ko
#echo "Setting vlan ..."
#ethreg -i eth0 0x660=0x0014017e # Port0_Lookup_CTRL
#ethreg -i eth0 0x420=0x00010001 # PORT0_VLAN_CTRL0
#ethreg -i eth0 0x66c=0x0014017d # Port1_Lookup_CTRL
#ethreg -i eth0 0x428=0x00010001 # PORT1_VLAN_CTRL0
#ethreg -i eth0 0x678=0x0014017b # PORT2_LOOKUP_CTRL
#ethreg -i eth0 0x430=0x00010001 # PORT2_VLAN_CTRL0
#ethreg -i eth0 0x684=0x00140177 # PORT3_LOOKUP_CTRL
#ethreg -i eth0 0x438=0x00010001 # PORT3_VLAN_CTRL0
#ethreg -i eth0 0x690=0x0014016f # PORT4_LOOKUP_CTRL
#ethreg -i eth0 0x440=0x00010001 # PORT4_VLAN_CTRL0
#ethreg -i eth0 0x69c=0x0014015f # PORT5_LOOKUP_CTRL
#ethreg -i eth0 0x448=0x00020001 # PORT5_VLAN_CTRL0
#ethreg -i eth0 0x6a8=0x0004013f # PORT6_LOOKUP_CTRL
#ethreg -i eth0 0x450=0x00010001 # PORT6_VLAN_CTRL0
#ethreg -i eth0 0x610=0x001bd560 # Group Ports to VID 1
#ethreg -i eth0 0x614=0x80010002 # Group Ports to VID 1
#ethreg -i eth0 0x610=0x001b7fe0 # Group Ports to VID 2
#ethreg -i eth0 0x614=0x80020002 # Group Ports to VID 2
#ethreg -i eth0 0x424=0x00002040 # PORT0_VLAN_CTRL1
#ethreg -i eth0 0x42c=0x00001040 # PORT1_VLAN_CTRL1
#ethreg -i eth0 0x434=0x00001040 # PORT2_VLAN_CTRL1
#ethreg -i eth0 0x43c=0x00001040 # PORT3_VLAN_CTRL1
#ethreg -i eth0 0x444=0x00001040 # PORT4_VLAN_CTRL1
#ethreg -i eth0 0x44c=0x00001040 # PORT5_VLAN_CTRL1
#ethreg -i eth0 0x454=0x00001040 # PORT6_VLAN_CTRL1
#ethreg -i eth0 0x94=0x0000007e  # PORT6_STATUS
#ethreg -i eth0 0x0c=0x01000000  # PORT6 PAD MODE CTRL


#echo "Setting MODULE_EN"
#if [ "$hnat_enable" = "1" ]; then
#	ethreg -i eth0 0x30=0x80000307
#else
#	ethreg -i eth0 0x30=0x80000303
#fi

echo "end $0"
