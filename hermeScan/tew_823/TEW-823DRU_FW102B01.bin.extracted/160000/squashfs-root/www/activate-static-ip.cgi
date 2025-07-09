#!/bin/sh
PATH=/usr/sbin:$PATH

debug() {
    MSG=$1
    echo "Status: 200 OK"
    echo ""
    echo "$MSG"
    exit 0
}

# Return an HTTP error code and message
err() {
    CODE=$1
    MSG="$2"
    echo "Status: $CODE $MSG"
    echo ""
    echo "$MSG"
    exit $CODE
}

fun_nvram_get(){
	if [ "$1" != "" ]; then
		ret=`nvram get $1`
	fi
	echo "$ret"
}

# Decode a url-encoded string
urldecode() {
    sed -e's/%\([0-9A-F][0-9A-F]\)/\\\\\x\1/g' | xargs echo -e
}

# Begin processing
echo "Content-type: text/plain"

if [ "$REQUEST_METHOD" != "POST" ]; then
    err 405 "We only accept POST"
fi

read DATA

echo "$DATA" > /tmp/jimmy.log

if ! echo "$CONTENT_TYPE" | grep "^application/x-www-form-urlencoded" > /dev/null; then
    err 400 "Data must be form-urlencoded"
fi

# validate posted data
OLDIFS=$IFS
IFS='&'
for ITEM in $DATA; do
	KEY=`echo $ITEM | cut -d= -f1 | urldecode`
	VALUE=`echo $ITEM | cut -d= -f2 | urldecode`
	if ! echo "$KEY" | grep "quick_apply_"; then
		err 400 "key $KEY is invalid"
	fi
	case $KEY in
		quick_apply_ip)
			WAN_IP=$VALUE
			;;
		quick_apply_mask)
			WAN_MASK=$VALUE
			;;
		quick_apply_gw)
			WAN_GW=$VALUE
			;;
		quick_apply_dns)
			WAN_DNS=$VALUE
			;;
		*)
			err 400 "Incorrect data !"
			;;
	esac
done
IFS=$OLDIFS

# # save posted data
# OLDIFS=$IFS
# IFS='&'
# for ITEM in $DATA; do
#     KEY=`echo $ITEM | cut -d= -f1 | urldecode`
#     VALUE=`echo $ITEM | cut -d= -f2 | urldecode`
#     #debug "running: nvram set $KEY=$VALUE"
#     nvram set $KEY=$VALUE || err 500 "nvram set $KEY=$VALUE failed with $?"
# done
# IFS=$OLDIFS


wan_eth=$(fun_nvram_get "wan_eth")

# Flush iptables ...?

killall udhcpc > /dev/null 2>&1
killall redial > /dev/null 2>&1
killall pppd > /dev/null 2>&1
killall wantimer > /dev/null 2>&1
ifconfig $wan_eth 0.0.0.0
ifconfig $wan_eth $WAN_IP netmask $WAN_MASK
ip route del default > /dev/null 2>&1
ip route add default via $WAN_GW
echo "nameserver $WAN_DNS" > /etc/resolv.conf


# return response
echo "Status: 200 OK"
echo ""
