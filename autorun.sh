#!/usr/bin/env bash

function run() {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# Start apps
run nm-applet
run compton
run plank
run udiskie --use-udisks2
run dropbox
