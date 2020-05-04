#!/bin/bash

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
    sudo liquidctl -d 1 set fan speed 30 30  35 30  40 50  45 60  50 100
    sudo liquidctl -d 1 set pump speed 30 50  35 50  40 60  45 70  50 100
    sudo liquidctl -d 2 set fan2 speed 30
    sudo liquidctl -d 2 set fan3 speed 30

  elif [[ $1 == "performance" ]]; then
    echo "setting fan curve to performance"
    sudo liquidctl -d 1 set fan speed 30 40  35 45  37 80  42 90  45 100
    sudo liquidctl -d 1 set pump speed 30 70  35 70  40 80  45 100  50 100
    sudo liquidctl -d 2 set fan2 speed 45
    sudo liquidctl -d 2 set fan3 speed 45

  elif [[ $1 == "liquid" ]]; then
    # get liquid temperature
    liq_temp="$(sudo liquidctl -d 1 status | grep Liquid)"
    echo "${liq_temp}"

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
