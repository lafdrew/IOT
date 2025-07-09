#!/bin/sh
PATH=/usr/sbin:$PATH
PPP_PAP_FILE="/var/etc/pap-secrets"
PPP_CHAP_FILE="/var/etc/chap-secrets"
PPP_CONFIG_OPTION_FILE="/var/etc/options_00"
PPP_CONFIG_OPTION="plugin /lib/pppd/2.4.3/rp-pppoe.so
login
noauth
debug
refuse-eap
noipdefault
defaultroute
passive
lcp-echo-interval 30
lcp-echo-failure 8
usepeerdns
maxfail 3
user \"pppoeusername\"
mtu  1492
mru  1492
:
remotename CAMEO
novj
nopcomp
noaccomp
-am
noccp
"

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
		quick_apply_pppoe_username)
			POE_USERNAME=$VALUE
			;;
    	quick_apply_pppoe_pwd)
			POE_PWD=$VALUE
			;;
    	*)
			err 400 "Incorrect data !"
			;;
	esac
done
IFS=$OLDIFS

# filled in option
echo "$PPP_CONFIG_OPTION" > $PPP_CONFIG_OPTION_FILE
sed -i 's/pppoeusername/'$POE_USERNAME'/g' $PPP_CONFIG_OPTION_FILE

# filled in chap
echo "\"$POE_USERNAME\" \"CAMEO\" \"$POE_PWD\" *" > $PPP_CHAP_FILE
echo "\"CAMEO\" \"$POE_USERNAME\" \"$POE_PWD\" *" >> $PPP_CHAP_FILE

# filled in pap
echo "\"$POE_USERNAME\" * \"$POE_PWD\" *" > $PPP_PAP_FILE


# save posted data
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
lan_ipaddr=$(fun_nvram_get "lan_ipaddr")

# DO we need Flush iptables ...?

killall udhcpc > /dev/null 2>&1
killall wantimer > /dev/null 2>&1
killall redial > /dev/null 2>&1
killall pppd > /dev/null 2>&1

ifconfig $wan_eth 0.0.0.0
ip route del default > /dev/null 2>&1

# dial up
pppd linkname 00 file $PPP_CONFIG_OPTION_FILE unit 0 $wan_eth

# Temporary setup iptable
echo "oob wizard running..." > /tmp/oob_wizard_running
iptables -t nat -A POSTROUTING -s $lan_ipaddr/24 -o ppp0 -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/conf/all/forwarding

# return response
echo "Status: 200 OK"
echo ""
