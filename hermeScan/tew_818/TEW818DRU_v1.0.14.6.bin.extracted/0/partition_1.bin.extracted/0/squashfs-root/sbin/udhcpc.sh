#!/bin/sh

WAIT_TIMER=0
MAX_WAIT_TIME=2
DHCP_STATUS_FILE="/var/dhcp_status"
WPS_DHCP_IP_FILE="/var/wps_dhcp_ip"
LAN_IP_ADDR=`nvram get lan_ipaddr`

#set

if test -n "$broadcast"; then
	BROADCAST="broadcast $broadcast"
	echo "Broadcast=$BROADCAST"
fi
	
if test -n "$subnet"; then
	NETMASK="netmask $subnet"
	echo "Netmask=$NETMASK"
fi

interface="br0"

case "$1" in
	deconfig)
		echo "DHCPC deconfig..."
		echo 0 > $DHCP_STATUS_FILE

		echo "Del default route (deconfig)..."
		route del default gateway $LAN_IP_ADDR dev $interface

		echo "Add default route..."
		route add default gateway $LAN_IP_ADDR dev $interface

		#Do not set interface's IP to NULL
		#echo "set IP to 0.0.0.0"
		#ifconfig $interface 0.0.0.0

		if [ ! -e "/var/wps_success" ]; then
			echo "bind $interface to $LAN_IP_ADDR"
			ifconfig $interface $LAN_IP_ADDR
		fi
	;;

	renew|bound)
		echo "DHCPC renew/bound..."
		echo 1 > $DHCP_STATUS_FILE

		echo "Del default route (renew/bound)..."
		route del default gateway $LAN_IP_ADDR dev $interface

		#for GUI redirecting webpage to the new IP
		echo $ip > $WPS_DHCP_IP_FILE
		echo "$ip $subnet" > "/var/tmp_dhcp_ip_mask"

		#write DHCP IP after GUI has been deleted WPS tmp file
		if [ -e $WPS_DHCP_IP_FILE ]; then
			#echo "Exist $WPS_DHCP_IP_FILE file"
			while [ "$WAIT_TIMER" -le "$MAX_WAIT_TIME" ]
			do
				sleep 1
				
				if [ ! -e $WPS_DHCP_IP_FILE ]; then
					echo "GUI is already. interface=$interface, IP=$ip"
					ifconfig $interface $ip $BROADCAST $NETMASK
					nvram set lan_ipaddr=$ip
					nvram set lan_netmask=$subnet
					nvram set lan_gateway=$router
					nvram set ap_dns=$dns
					nvram set ap_wins=$wins
					nvram set ap_domain=$domain
					nvram set ap_lease=$lease
					nvram commit
					break
				fi
				
				WAIT_TIMER=`expr $WAIT_TIMER + 1`
				echo "ip=$ip, $WAIT_TIMER"
			done
		fi

		if [ -e $WPS_DHCP_IP_FILE ]; then
			echo "Got IP. interface=$interface, IP=$ip"
			ifconfig $interface $ip $BROADCAST $NETMASK
			nvram set lan_ipaddr=$ip
			nvram set lan_netmask=$subnet
			nvram set lan_gateway=$router
			nvram set ap_dns=$dns
			nvram set ap_wins=$wins
			nvram set ap_domain=$domain
			nvram set ap_lease=$lease
			nvram commit
			
			# restart dns server after bound lan ip
			rm /tmp/resolv.conf
			touch /tmp/resolv.conf
			for i in $dns ; do			
				echo "dns = $i ..........."
				echo adding dns $i
				echo nameserver $i >> /tmp/resolv.conf
			done
			
			killall -9 dnsmasq
			sleep 1
			usr/sbin/dnsmasq -r /tmp/resolv.conf&

			route add default gateway $router dev $interface
			
			# killall -SIGHUP dnsmasq
				
			rm -rf $WPS_DHCP_IP_FILE
		fi

		rm -rf $DHCP_STATUS_FILE
	;;
esac
