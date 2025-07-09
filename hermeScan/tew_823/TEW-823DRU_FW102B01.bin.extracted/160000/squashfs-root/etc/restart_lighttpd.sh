#!/bin/sh
killall lighttpd
sleep 1
cli services lighttpd restartup &
rm /tmp/lighttpd.tmp
