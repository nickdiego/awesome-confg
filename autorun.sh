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
run unclutter -idle 2
run udiskie --use-udisks2
run chromium --no-startup-window
run dropbox
