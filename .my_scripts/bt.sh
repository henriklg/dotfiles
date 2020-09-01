#!/bin/bash

# used for connecting to bluetooth headset
function bt() {
  echo "Connecting to headphones"
  bluetoothctl connect 2C:41:A1:49:82:12 &
}



