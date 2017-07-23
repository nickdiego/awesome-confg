#!/usr/bin/env bash

function run() {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# Start apps
run compton
run nm-applet
run udiskie --tray --use-udisks2
run dropbox
run chromium --no-startup-window
