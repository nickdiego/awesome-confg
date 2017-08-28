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
run udiskie --use-udisks2
run google-chrome-stable --no-startup-window
run dropbox
run conky
#run unclutter -idle 2
