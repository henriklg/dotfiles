#!/bin/bash

# used for fixing scroll on Lenovo X1Carbon. Can delete now since machine is sold.
function scroll() {
  echo "Fixing two finger scrolling"
  sudo modprobe -r psmouse
  sudo modprobe psmouse
}



