#!/bin/sh

killall hostapd

set_none_type()
{
for i in ath0 ath1
do
	cat /var/tmp/WSC_$i.conf|sed 's/wpa=3/wpa=0/g' > /var/tmp/WSC_$i.conf.bak
	hostapd /var/tmp/WSC_$i.conf.bak &
done
}

set_mix_type()
{
for i in ath0 ath1
do
	cat /var/tmp/WSC_$i.conf|sed 's/wpa=0/wpa=3/g' > /var/tmp/WSC_$i.conf.bak
	hostapd /var/tmp/WSC_$i.conf.bak &
done
}


#type : Security Type Mode
#	0 express none security
#	1 express WPA-WPA2
type=$1

killall hostapd

case $type in
	'0')
		echo "None Security"
		set_none_type
		echo "Security : None" > /tmp/wlan_info.txt
		;;
	'1')
		echo "WPA/WPA2 Security"
		set_mix_type
		echo "Security : WPA/WPA2" > /tmp/wlan_info.txt
		;;
	*)
		echo "Nothing to do"
		;;
esac
