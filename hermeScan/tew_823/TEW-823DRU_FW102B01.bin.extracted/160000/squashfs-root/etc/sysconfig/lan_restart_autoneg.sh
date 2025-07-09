#!/bin/sh

# Restart Lan port auto Negotiate
ethreg -p 0 0x0=0x1200 > /dev/null 2>&1
ethreg -p 1 0x0=0x1200 > /dev/null 2>&1
ethreg -p 2 0x0=0x1200 > /dev/null 2>&1
ethreg -p 3 0x0=0x1200 > /dev/null 2>&1


