#!/bin/sh
cd /tmp;
chmod +x nart.out
mkdir nart24G
mv *.so nart24G
mv nart.out nart24G
export LD_LIBRARY_PATH=/tmp/nart24G:$LD_LIBRARY_PATH
# use art-scorpion.ko, not art-scorpion-peacock.ko
insmod /lib/modules/art_ap.ko
sleep 1
cd;
/tmp/nart24G/nart.out -instance 0 -port 2390 &
echo "1" > /tmp/calibration_ready24G.txt
