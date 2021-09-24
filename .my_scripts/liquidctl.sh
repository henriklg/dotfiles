#!/usr/bin/env bash

# GitHub repo: https://github.com/jonasmalacofilho/liquidctl
# (running v1.2.0 - latest version is 1.3.3)
function fans() {
  # no arguments
  if [[ $# -eq 0 ]]; then
    echo "Give a percentage between 0 and 100 or profile name."

  # 1 argument
  elif [[ $1 == "silent" ]]; then
    echo "setting fan curve to silent"
    # [temperature percentage]
    sudo liquidctl -d 1 set fan speed 30 30  35 30  40 50  43 100  50 100
    sudo liquidctl -d 1 set pump speed 30 50  35 50  40 50  43 100  50 100
    sudo liquidctl -d 2 set fan2 speed 30
    sudo liquidctl -d 2 set fan3 speed 30

  elif [[ $1 == "performance" ]]; then
    echo "setting fan curve to performance"
    sudo liquidctl -d 1 set fan speed 30 40  35 40  37 80  41 90  42 100
    sudo liquidctl -d 1 set pump speed 30 70  35 70  40 80  42 100  50 100
    sudo liquidctl -d 2 set fan2 speed 45
    sudo liquidctl -d 2 set fan3 speed 45

  elif [[ $1 == "watch" ]]; then
    # get liquid temperature
    watch -d -n 1 sudo liquidctl -d 1 status
    #liq_temp="$(sudo liquidctl -d 1 status | grep Liquid)"
    #echo "${liq_temp}"

  elif [[ $# -eq 1 ]]; then
    # check if range [0,100]
    if [ $1 -ge 0 ] && [ $1 -le 100 ]; then
      # liquid AIO
      sudo liquidctl -d 1 set fan speed $1
      sudo liquidctl -d 1 set pump speed $1
      # chassis fans - front
      sudo liquidctl -d 2 set fan2 speed $1
      # .. and back
      sudo liquidctl -d 2 set fan3 speed $1
    fi
  fi
}

# 2825D1 blue
# E00FA7 purple
function lights() {
  # No arguments
  if [[ $# -eq 0 ]]; then
    echo "Missing argument."
  
  # 1 argument
  elif [[ $1 == "off" ]]; then
    sudo liquidctl -d 2 set led color off

  elif [[ $1 == "fixed" ]]; then
    sudo liquidctl -d 2 set led color fixed af5a2f
    
  elif [[ $1 == "fading" ]]; then
    sudo liquidctl -d 2 set led color fading E00FA7 2825D1 --speed slower
    sudo liquidctl -d 1 set ring color fading 2825D1 E00FA7
    sudo liquidctl -d 1 set logo color fixed E00FA7
  fi
}
