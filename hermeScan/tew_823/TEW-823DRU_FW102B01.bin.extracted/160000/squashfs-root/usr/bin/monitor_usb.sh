#!/bin/sh

SLEEP_TIME=$1
daemon_launched="0"
smb_enable=`nvram get smb_enable`
ftp_enable=`nvram get ftp_enable`
dlna_enable=`nvram get minidlna_enable`
model_number=`nvram get model_number`
lan_mac=`nvram get lan_mac`

if [ "$SLEEP_TIME" = "" ]; then
	SLEEP_TIME=5
fi

#echo show1 $smb_enable $ftp_enable

### Monitor USB storage status ###
while [ 1 ]
do
	usb_dev=`ls '/dev' | grep '^sd'`
	mount_dir=`ls '/tmp/kcode_shared' | grep 'usb_'`
	device=`cat /sys/bus/usb/devices | grep '2-1' `
	### Turn on/off USB LED
#	if [ "$device" != "" ]; then
#		um_gpio set 8 0
#	else
#		um_gpio set 8 1
#	fi

#echo show2 $mount_dir $usb_dev

	if [ "$mount_dir" != "" ]; then
		### Found mounted directory ###
		if [ "$usb_dev" != "" ]; then
			## USB storage exist, launch file sharing daemon if needed...
			if [ "$daemon_launched" = "0" ]; then
				## Daemon is not running, launch it...
				if [ "$ftp_enable" = "1" ]; then
					KC_FTP &
				fi
				if [ "$smb_enable" = "1" ]; then
					killall -9 nmbd
					KC_SMB &
				fi
#				if [ "$dlna_enable" = "1" ]; then
#					cp -f /tmp/etc/minidlna.conf /tmp/etc/dlna.conf
#					for mnt_dev in $mount_dir; do
#						#umount /tmp/kcode_shared/$mnt_dev
#						#rmdir /tmp/kcode_shared/$mnt_dev
#						echo media_dir=/tmp/kcode_shared/$mnt_dev >> /tmp/etc/dlna.conf
#						echo db_dir=/tmp/kcode_shared/$mnt_dev/dlna >> /tmp/etc/dlna.conf
#					done
#					
#					minidlna -f /tmp/etc/dlna.conf
#				
#				fi


			fi
			daemon_launched="1"
		else
			## USB storage does not exist, abnormal situation happen
			## Try to remove file sharing daemon...
			if [ "$daemon_launched" != "0" ]; then
				## Daemon is running, kill it...
				echo "Abnormal situation happen, try to remove SMB & FTP daemon..." > /dev/console
				killall -9 KC_FTP
				killall -9 KC_SMB
				/sbin/nmbd "$model_number" "$lan_mac" &
#				killall -9 minidlna
			fi
			daemon_launched="0"

			## Troubleshooting!! Try to remove unusable directory...
			echo "Try to remove unusable directory..." > /dev/console
			for mnt_dev in $mount_dir; do
				umount /tmp/kcode_shared/$mnt_dev
				rmdir /tmp/kcode_shared/$mnt_dev
			done
		fi
	else
		### No storage ###
		if [ "$daemon_launched" != "0" ]; then
			## Daemon is running, kill it...
			killall -9 KC_FTP
			killall -9 KC_SMB
			/sbin/nmbd "$model_number" "$lan_mac" &
#			killall -9 minidlna
		fi
		daemon_launched="0"
	fi

	sleep $SLEEP_TIME
done
