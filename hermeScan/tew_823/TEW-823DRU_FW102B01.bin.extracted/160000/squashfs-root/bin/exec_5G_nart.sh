#!/bin/sh
cd /tmp;
chmod +x nart.out
mkdir nart5G
mv *.so nart5G
mv nart.out nart5G
mv *.eeprom nart5G

insmod /lib/modules/2.6.31/net/acfg_mod.ko
insmod /lib/modules/2.6.31/net/adf.ko
insmod /lib/modules/2.6.31/net/asf.ko
insmod /lib/modules/2.6.31/net/ath_hal.ko
insmod /lib/modules/2.6.31/net/ath_rate_atheros.ko
insmod /lib/modules/2.6.31/net/ath_spectral.ko maxholdintvl=5000 nfrssi=1 nobeacons=0
insmod /lib/modules/2.6.31/net/ath_dfs.ko
insmod /lib/modules/2.6.31/net/ath_dev.ko
insmod /lib/modules/2.6.31/net/umac.ko testmode=1 ahbskip=1
insmod /lib/modules/2.6.31/net/wlan_me.ko
insmod /lib/modules/2.6.31/net/ath_pktlog.ko

export LD_LIBRARY_PATH=/tmp/nart5G:$LD_LIBRARY_PATH
sleep 1
cd;
/tmp/nart5G/nart.out -instance 1 -port 2391 &
echo "1" > /tmp/calibration_ready5G.txt
