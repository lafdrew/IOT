#!/bin/sh
#
# $Id: ddns.sh,v 1.1 2007-09-24 09:34:52 winfred Exp $
#
# usage: ddns.sh
#

srv=`nvram get DDNS_Provider`
ddns=`nvram get DDNS_host_name`
u=`nvram get DDNS_Account`
pw=`nvram get DDNS_Password`
mx=`nvram get DDNS_mx`
backmx=`nvram get DDNS_backmx`

if [ "$srv" = "" -o "$srv" = "none" ]; then
	killall -q inadyn
	exit 0
fi

if [ "$ddns" = "" -o "$u" = "" -o "$pw" = "" ]; then
	killall -q inadyn
	exit 0
fi

#2012-06-12, David Lin, [Merge from user/ of SDK3.6.0.0]
# u-media(rh001)-<David Lin>-<DDNS Update> ([+++])
# 2010-10-13, If wan ip no change, we should not update wan ip to DDNS server again.
wanConnectionMode=`nvram get wan_proto`
if [ "$wanConnectionMode" == "dhcp" -o "$wanConnectionMode" == "static" ]; then
        wanif=`nvram get wandevs`
else
        if [ "$wanConnectionMode" == "pppoe" ]; then
                wanif=`nvram get wan0_pppoe_ifname`
        elif [ "$wanConnectionMode" == "pptp" ]; then
                wanif=`nvram get wan0_pptp_ifname`
        elif [ "$wanConnectionMode" == "l2tp" ]; then
                wanif=`nvram get wan0_l2tp_ifname`
        else
                wanif="ppp0"
        fi
fi

wanIP=`ifconfig $wanif | grep 'inet addr' | awk '{print $2}' | sed -e 's/addr://'`
echo "$wanIP"
if [ "$wanIP" == "" ]; then
	exit 0
fi

if [ ! -e /tmp/DDNS_IP ]; then
	echo "create DDNS_IP!" > /dev/console
	echo "$wanIP" > /tmp/DDNS_IP
else
        wanIP_old=`cat /tmp/DDNS_IP`
	echo "wan_old ip:$wanIP_old, current wan ip:$wanIP" > /dev/console
        if [ "$wanIP_old" == "$wanIP" ]; then
		echo "Wan IP was not change!" > /dev/console
                exit 0
	else
		echo "$wanIP" > /tmp/DDNS_IP
        fi
fi
# u-media(rh001)-<David Lin>-<DDNS Update> ([+++])

killall -q inadyn

# debug
echo "srv=$srv"
echo "ddns=$ddns"
echo "u=$u"
echo "pw=$pw"
echo "mx=$mx"
echo "backmx=$backmx"

if [ "$mx" == "" ]; then
		if [ "$srv" = "dyndns.org" ]; then
			inadyn -u $u -p $pw -a $ddns -m empty -b $backmx --update_period_sec 600 --dyndns_system dyndns@$srv &
		elif [ "$srv" = "freedns.afraid.org" ]; then
			inadyn -u $u -p $pw -a $ddns --update_period_sec 600 --dyndns_system default@$srv &
		elif [ "$srv" = "zoneedit.com" ]; then
			inadyn -u $u -p $pw -a $ddns --update_period_sec 600 --dyndns_system default@$srv &
		elif [ "$srv" = "no-ip.com" ]; then
			inadyn -u $u -p $pw -a $ddns --update_period_sec 600 --dyndns_system default@$srv &
		else
			echo "$0: unknown DDNS provider: $srv"
			exit 1
		fi
else
		if [ "$srv" = "dyndns.org" ]; then
			inadyn -u $u -p $pw -a $ddns -m $mx -b $backmx --update_period_sec 600 --dyndns_system dyndns@$srv &
		elif [ "$srv" = "freedns.afraid.org" ]; then
			inadyn -u $u -p $pw -a $ddns --update_period_sec 600 --dyndns_system default@$srv &
		elif [ "$srv" = "zoneedit.com" ]; then
			inadyn -u $u -p $pw -a $ddns --update_period_sec 600 --dyndns_system default@$srv &
		elif [ "$srv" = "no-ip.com" ]; then
			inadyn -u $u -p $pw -a $ddns --update_period_sec 600 --dyndns_system default@$srv &
		else
			echo "$0: unknown DDNS provider: $srv"
			exit 1
		fi
fi