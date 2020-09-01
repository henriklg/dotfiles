#!/bin/bash

# used for connecting to bluetooth headset
function bt() {
	if [[ $1 == "con" ]]; then
		echo "Connecting headphones"
		bluetoothctl connect 2C:41:A1:49:82:12 > /dev/null 2>&1
	elif [[ $1 == "dis" ]]; then
		echo "Disconnecting headphones"
		bluetoothctl disconnect 2C:41:A1:49:82:12 > /dev/null 2>&1
	else
		echo "No arguments given. Options are 'con' for connect or 'dis' for disconnect."
	fi
}



