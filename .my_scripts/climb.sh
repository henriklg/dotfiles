#!/usr/bin/env bash

function climb() {
  if [[ $# -eq 0 ]]; then
    steps=1
  else
    steps=$1
  fi

  count=0
  while [[ $count -lt $steps ]]; do
    cd ..
    let count=count+1
  done
}
