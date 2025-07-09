#!/bin/sh

# status: 22/14
# internet: 20/19/18(0:HW/1:SW control/blue/orange)
# LAN1
# LAN2
# LAN3
# WiFi 2G: 13
# WiFi 5G: 12(not work)
# USB: 11
# WPS: 15
#
USB_LED=
WIRELESS_LED_1= # 2G
WIRELESS_LED_2= # 5G
STATUS_LED=14
WPS_LED_GPIO=
INTERNET_LED_2=22
INTERNET_LED_1=23
SWITCH_CONTROL=
POWER_LED=19


gpio_led_init() {
	insmod /lib/modules/$(uname -r)/kernel/arch/mips/atheros/ar934x_gpio.ko
	# reset
	echo 17 > /sys/module/ar934x_gpio/parameters/export_int
	# XXX: for sw nat performance, bad way to add here
	echo 0 > /proc/sys/net/netfilter/nf_conntrack_checksum
	reg=`nvram get sys_region`
	# NTT project.
	if [ "$reg" = "NW" ];then
		echo 16 > /sys/module/ar934x_gpio/parameters/export_int
	fi
	for i in $USB_LED $WIRELESS_LED_1 $WIRELESS_LED_2 $STATUS_LED $WPS_LED_GPIO $INTERNET_LED_2 $INTERNET_LED_1 $SWITCH_CONTROL $POWER_LED;do
		echo $i > /sys/class/gpio/export
		echo out > /sys/class/gpio/gpio$i/direction
		echo "init gpio $i"
		echo 0 > /sys/class/gpio/gpio$i/value
		echo 1 > /sys/class/gpio/gpio$i/value
	done
}

gpio_on()
{
	if [ ! -f /sys/class/gpio/gpio$1/value ];then
		echo "gpio on $1 not exist" >&2
		exit
	fi
	echo 0 > /sys/class/gpio/gpio$1/value
}

gpio_off()
{
	if [ ! -f /sys/class/gpio/gpio$1/value ];then
		echo "gpio off $1 not exist" >&2
		exit
	fi
	echo 1 > /sys/class/gpio/gpio$1/value
}

led_internet_sw()
{
	gpio_off $SWITCH_CONTROL
	gpio_off $INTERNET_LED_2
	gpio_off $INTERNET_LED_1
}

led_internet_hw()
{
	gpio_on $SWITCH_CONTROL
	gpio_off $INTERNET_LED_2
	gpio_off $INTERNET_LED_1
}

case $1 in
on)
	gpio_on $2
	;;
off)
	gpio_off $2
	;;
led_internet_hw)
	echo "GPIOs not support $1" >&2
	gpio_on $INTERNET_LED_2
	#led_internet_hw
	;;
led_internet_sw)
	echo "GPIOs not support $1" >&2
	#led_internet_sw
	;;
SWITCH_CONTROL)
	echo "GPIOs not support $1" >&2
	#if [ "$2" = "off" ];then
	#	led_internet_sw
	#else
	#	led_internet_hw
	#fi
	;;
INTERNET_LED)
	if [ "$2" = "off" ];then
		if [ "$3" = "green" ];then
			gpio_off $INTERNET_LED_2
		else
			gpio_off $INTERNET_LED_1
		fi
	else
		if [ "$3" = "green" ];then
			gpio_on $INTERNET_LED_2
		else
			gpio_on $INTERNET_LED_1
		fi
	fi
	;;
start)
	gpio_led_init
	gpio_off $STATUS_LED
	gpio_on $POWER_LED
	;;
*)
	echo "$0 [start] to initial gpio driver at booting"
	echo "$0 [on|off <num>] to control gpio"
	echo "$0 [led_internet_hw|led_internet_sw] to switch internet gpio"
	;;
esac
