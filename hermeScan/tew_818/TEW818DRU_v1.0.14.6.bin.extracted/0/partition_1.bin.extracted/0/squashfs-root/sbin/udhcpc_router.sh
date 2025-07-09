#!/bin/sh

WAIT_TIMER=0
MAX_WAIT_TIME=2
DHCP_STATUS_FILE="/var/dhcp_status"
WPS_DHCP_IP_FILE="/var/wps_dhcp_ip"
PPP_CONNECTION_FILE="/tmp/ppp/link.ppp0"
LAN_IP_ADDR=`nvram get lan_ipaddr`

if test -n "$broadcast"; then
	BROADCAST="broadcast $broadcast"
	echo "Broadcast=$BROADCAST"
fi
	
if test -n "$subnet"; then
	NETMASK="netmask $subnet"
	echo "Netmask=$NETMASK"
fi

interface="vlan2"

WAN_TYPE=`nvram get wan_proto`
WAN_IFNAME=`nvram get wan0_ifname`
L2TP_IPADDR=`nvram get wan_l2tp_ipaddr`
PPTP_SERVER=`nvram get wan0_pptp_server_name`
L2TP_SERVER=`nvram get wan0_l2tp_server_name`
if [ $WAN_TYPE == "pptp" -o $WAN_TYPE == "l2tp" ]; then
	interface="$WAN_IFNAME"
fi

case "$1" in
	deconfig)
		echo "DHCPC deconfig..."
		echo 0 > $DHCP_STATUS_FILE

		echo "Del default route (deconfig)..."
		route del default gateway $LAN_IP_ADDR dev $interface

		echo "Add default route..."
		route add default gateway $LAN_IP_ADDR dev $interface

		echo "set IP to 0.0.0.0"
		ifconfig $interface 0.0.0.0
	;;

	renew|bound)
		echo "DHCPC renew/bound..."
		echo 1 > $DHCP_STATUS_FILE

		echo "Del default route (renew/bound)..."
		route del default gateway $LAN_IP_ADDR dev $interface

		#for GUI redirecting webpage to the new IP
		echo $ip > $WPS_DHCP_IP_FILE
		echo "$ip $subnet" > "/var/tmp_dhcp_ip_mask"

		if [ ! -e $PPP_CONNECTION_FILE ]; then
			# restart dns server after bound lan ip
			rm /tmp/resolv.conf
			touch /tmp/resolv.conf
			for i in $dns ; do
				echo "dns = $i ..........."
				echo adding dns $i
				echo nameserver $i >> /tmp/resolv.conf
			done
		fi

		#write DHCP IP after GUI has been deleted WPS tmp file
		if [ -e $WPS_DHCP_IP_FILE ]; then
			#echo "Exist $WPS_DHCP_IP_FILE file"
			while [ "$WAIT_TIMER" -le "$MAX_WAIT_TIME" ]
			do
				sleep 1
				
				if [ ! -e $WPS_DHCP_IP_FILE ]; then
					echo "GUI is already. interface=$interface, IP=$ip"
					ifconfig $interface $ip $BROADCAST $NETMASK
					break
				fi
				
				WAIT_TIMER=`expr $WAIT_TIMER + 1`
				echo "ip=$ip, $WAIT_TIMER"
			done
		fi

		if [ -e $WPS_DHCP_IP_FILE ]; then
			echo "Got IP. interface=$interface, IP=$ip"
			ifconfig $interface $ip $BROADCAST $NETMASK

			if [ $WAN_TYPE == "l2tp" ] || [ $WAN_TYPE == "pptp" ]; then
				for i in $dns ; do
					echo "Add dns route for ppp connection..."
					echo "dns=$i  gateway=$router"
					route add -host $i gateway $router dev vlan2
				done
			fi

			#Tom.Hung 2013-4-10, support L2TP DHCP mode
			if [ $WAN_TYPE == "l2tp" ]; then
				echo "Add route to l2tp server..."
				route add -host $L2TP_SERVER gateway $router dev vlan2
				sed "s/$L2TP_IPADDR/$ip/" /tmp/l2tp/openl2tpd.conf > /tmp/l2tp/openl2tpd_dhcp.conf
				openl2tpd -f -u 1701 -c /tmp/l2tp/openl2tpd_dhcp.conf &
			fi
			#Tom.Hung 2013-4-10 end
			#Tom.Hung 2013-4-11, PPTP DHCP mode dial up
			if [ $WAN_TYPE == "pptp" ]; then
				echo "Add route to pptp server..."
				route add -host $PPTP_SERVER gateway $router dev vlan2
				pppd_exist=`ps | grep pppd | grep -v grep`
				if [ "x$pppd_exist" == "x" ]; then
					pppd
				fi
			fi
			#Tom.Hung 2013-4-11 end

			rm -rf $WPS_DHCP_IP_FILE
		fi

		rm -rf $DHCP_STATUS_FILE
	;;
esac
