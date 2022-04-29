#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1