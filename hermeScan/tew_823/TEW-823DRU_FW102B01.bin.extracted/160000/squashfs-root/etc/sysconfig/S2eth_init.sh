#!/bin/sh
#########################
# 1) insert module
# 2) up interface
# 3) set vlan
# 4) set lan / wan mac
# 5) set bridge
# 6) set up lan ip
#########################
echo "begin $0"

fun_nvram_get(){
	if [ "$1" != "" ]; then
		ret=`nvram get $1`
	fi
	echo "$ret"
}

hnat_status(){
	ret=$(fun_nvram_get "hnat_enable")
	echo "$ret"
}

get_lan_mac(){
	mac_lan=`artblock_cmd get lan_mac`
	if [ "$mac_lan" = "" ]; then
		mac_lan=$(fun_nvram_get "lan_mac")
		if [ "$mac_lan" = "" ]; then
			mac_lan="00:03:7f:EE:EE:EE"
		fi
	else
		nvram set lan_mac=$mac_lan
	fi
	echo "$mac_lan"
}

get_wan_mac(){
	mac_wan=$(fun_nvram_get "mac_clone_addr")
	if [ "$mac_wan" = "" ]; then
		mac_wan=`artblock_cmd get wan_mac`
		if [ "$mac_wan" = "" ]; then
			mac_wan=$(fun_nvram_get "wan_mac")
			if [ "$wan_mac" = "" ]; then
				mac_wan="00:03:7f:EE:EE:EF"
			fi
		else
			nvram set wan_mac=$mac_wan
		fi
	fi
	echo "$mac_wan"
}


hnat_enable=$(hnat_status)
# default value
[ -z "$hnat_enable" ] && hnat_enable=0
lan_mac="$(get_lan_mac)"
# default value
[ -z "$lan_mac" ] && lan_mac="00:03:7F:EE:EE:EE"
wan_mac=$(get_wan_mac)
# default value
[ -z "$wan_mac" ] && wan_mac="00:03:7F:EE:EE:EF"
lan_eth=$(fun_nvram_get "lan_eth")
# default value
[ -z "$lan_eth" ] && lan_eth="eth1.1"
wan_eth=$(fun_nvram_get "wan_eth")
# default value
[ -z "$wan_eth" ] && wan_eth="eth1.2"
lan_bridge=$(fun_nvram_get "lan_bridge")
# default value
[ -z "$lan_bridge" ] && lan_bridge="br0"
lan_ipaddr=$(fun_nvram_get "lan_ipaddr")
# default value
[ -z "$lan_ipaddr" ] && lan_ipaddr="192.168.0.1"
lan_netmask=$(fun_nvram_get "lan_netmask")
# default value
[ -z "$lan_netmask" ] && lan_netmask="255.255.255.0"

######################
# Main proceed flow  #
######################
# 1) insert module
if [ "$hnat_enable" = "0" ]; then
	echo "Inserting switch driver - HNAT NOT enable ..."
	insmod /lib/modules/2.6.31/net/athrs_gmac.ko enable_l3_offload=0
else
	echo "Inserting switch driver - HNAT enable ..."
	insmod /lib/modules/2.6.31/net/athrs_gmac.ko enable_l3_offload=1
fi

# 2) up interface
ifconfig eth0 up
ifconfig eth1 up

# 3) set vlan
vconfig add eth1 1
vconfig add eth1 2

# 4) set lan / wan mac
ifconfig $lan_eth hw ether $lan_mac
ifconfig $wan_eth hw ether $wan_mac

ifconfig $lan_eth up
ifconfig $wan_eth up

# 5) set bridge
# 6) set up lan ip
if [ "$lan_bridge" != "" ]; then
	brctl addbr $lan_bridge
	brctl stp $lan_bridge off
	brctl setfd $lan_bridge 0
	brctl addif $lan_bridge $lan_eth
	ifconfig $lan_bridge $lan_ipaddr netmask $lan_netmask
	ifconfig $lan_bridge up
	brctl addif $lan_bridge $lan_eth
else
	ifconfig $lan_eth $lan_ipaddr netmask $lan_netmask
	ifconfig $lan_eth up
fi

# 7) misc
# avoid eth0 send out DAD packet
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
# always disable ipv6 forward at startup time for support 6204bis G-3
echo 1 > /proc/sys/net/ipv6/disable_forward

echo "end $0"
