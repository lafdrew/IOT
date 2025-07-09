#!/bin/sh
# GPL hook script for wan state event

# Usage:
# gpl_wan_state.sh ip_type old_state new_state

# state definition
# 0: Cable linked, wan interface does NOT have IP
# 1: Cable linked, wan interface has IP
# 2: Cable NOT linked, wan has IP
# 3: Cable NOT linked, wan dose NOT have IP

# ip_type
# 1: ipv4
# 2: ipv6

echo "begin gpl_wan_state.sh"
last_wan_state=$1
wan_state=$2

echo "last_wan_state: $last_wan_state"
echo "wan_state: $wan_state"

echo "end gpl_wan_state.sh"

# GPL_MSG="gpl wan state: "
# 
# usage() {
# 	echo ""
# 	echo "Usage: $0 ip_type old_state new_state"
# 	echo ""
# 	exit 3;
# }
# 
# ipv4_state_event() {
# 	echo "$GPL_MSG ipv4 event $1 $2"
# 	case "$1" in
# 		0)
# 			case "$2" in
# 				0)  # do nothing
# 					;;
# 				1)  # no IP -> has IP
# 					;;
# 				2)  # link -> not link
# 					;;
# 				3)  # link -> not link
# 					;;
# 			esac
# 			;;
# 		1)
# 			case "$2" in
# 				0)  # linked, no IP
# 					;;
# 				1)  # do nothing
# 					;;
# 				2)  # link -> not link
# 					;;
# 				3)  # link -> not link
# 					;;
# 			esac
# 			;;
# 		2)
# 			case "$2" in
# 				0)  # linked, no IP
# 					;;
# 				1)  # no IP -> has IP
# 					;;
# 				2)  # do nothing
# 					;;
# 				3)  # link -> not link
# 					;;
# 			esac
# 			;;
# 		3)
# 			case "$2" in
# 				0)  # linked, no IP
# 					;;
# 				1)  # no IP -> has IP
# 					;;
# 				2)  # link -> not link
# 					;;
# 				3)  # do nothing
# 					;;
# 			esac
# 			;;
# 		*)
# 			echo "Usage: $0 ip_type old_state new_state"
# 			exit 3;
# 	esac
# }
# 
# ipv6_state_event() {
# 	echo "$GPL_MSG ipv6 event $1 $2"
# 		case "$1" in
# 		0)
# 			case "$2" in
# 				0)  # do nothing
# 					;;
# 				1)  # no IP -> has IP
# 					;;
# 				2)  # link -> not link
# 					;;
# 				3)  # link -> not link
# 					;;
# 			esac
# 			;;
# 		1)
# 			case "$2" in
# 				0)  # linked, no IP
# 					;;
# 				1)  # do nothing
# 					;;
# 				2)  # link -> not link
# 					;;
# 				3)  # link -> not link
# 					;;
# 			esac
# 			;;
# 		2)
# 			case "$2" in
# 				0)  # linked, no IP
# 					;;
# 				1)  # no IP -> has IP
# 					;;
# 				2)  # do nothing
# 					;;
# 				3)  # link -> not link
# 					;;
# 			esac
# 			;;
# 		3)
# 			case "$2" in
# 				0)  # linked, no IP
# 					;;
# 				1)  # no IP -> has IP
# 					;;
# 				2)  # link -> not link
# 					;;
# 				3)  # do nothing
# 					;;
# 			esac
# 			;;
# 		*)
# 			echo "Usage: $0 ip_type old_state new_state"
# 			exit 3;
# 	esac
# }
# 
# 
# 
# if [ $# != 3 ] ;then
# 	usage
# fi
# 
# 
# case "$1" in
# 	1)	# ipv4 state changes
# 		shift
# 		ipv4_state_event "$@"
# 		;;
# 	2)	# ipv6 state changes
# 		shift
# 		ipv6_state_event "$@"
# 		;;
# 	*)
# 		usage
# 		exit 3;
# 		;;
# esac
# 
# 
# echo "$GPL_MSG changes ..."



