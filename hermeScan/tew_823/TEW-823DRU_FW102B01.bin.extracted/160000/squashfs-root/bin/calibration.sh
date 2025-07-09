#!/bin/sh
destroy_if()
{
	for k in ath0 ath4
	do
	brctl delif br0 $k
	sleep 1
	ifconfig $k down
	sleep 1
	wlanconfig $k destroy
	sleep 1
	done
}

rm_module()
{
	rmmod ath_mld
	rmmod ath_pktlog
	sleep 1
	rmmod umac
	sleep 1
	rmmod ath_dev
	rmmod ath_dfs
	rmmod ath_spectral
	rmmod ath_rate_atheros
	rmmod ath_hal
	rmmod asf
	sleep 1
	rmmod adf
	sleep 1
}

killall hostapd &
killall udhcpc &
killall wantimer &
killall timer &
killall plcd &

#change to windows client use tftp put upload nart.out, tftpd save this file to /tmp/nart.out
#cd /tmp
#tftp -r nart.out -g 192.168.0.100
chmod 777 /tmp/nart.out

destroy_if

rm_module

echo "1" > /tmp/unload_ready

#mknod /dev/dk0 c 63 0
#cd /tmp;
#export LD_LIBRARY_PATH=/tmp:$LD_LIBRARY_PATH

#insmod /lib/modules/art_ap.ko
#sleep 1
#/tmp/nart.out -instance 0 -port 2390&
#/tmp/nart.out -instance 1 -port 2391&
