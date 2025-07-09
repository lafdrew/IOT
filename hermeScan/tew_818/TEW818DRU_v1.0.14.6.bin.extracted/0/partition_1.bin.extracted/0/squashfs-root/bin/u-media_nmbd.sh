#
# This script is created by U-Media Salim.
# This is for execute to U-Media NetBIOS name query reponder for Predefined URL function.
#
#							- 2010/09/08 -
#
#	Date			Who				Description
#	--------------------------------------------------------------------------------------
#	2013/3/25	Dias Kuo			Porting from revision 3413 of Ralink SDK 3.4. Modified for new WUMC710.
#

#!/bin/sh

killall -KILL um_nmbd > /dev/null 2>&1

CONF="/tmp/u-media_nmbd.conf"
nbios_name=`nvram get DeviceURL`

ETHIF=br0
lanip=`ifconfig br0 | grep "inet addr:" | awk '{print $2}' | sed 's/addr://g'`

echo "$nbios_name" > $CONF
echo "$lanip" >> $CONF

um_nmbd $CONF > /dev/null 2>&1
