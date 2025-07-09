#!/bin/sh

power_orange_LED=14
power_green_LED=19
wan_green_LED=22
wan_orange_LED=23

for i in $power_orange_LED $power_green_LED $wan_green_LED $wan_orange_LED;do
     echo 1 > /sys/class/gpio/gpio$i/value
done

for i in $power_orange_LED $wan_orange_LED;do
    echo 0 > /sys/class/gpio/gpio$i/value
done

