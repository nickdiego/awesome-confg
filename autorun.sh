#!/usr/bin/env bash

function run() {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# Start apps
run compton --config ~/.compton.conf
run nm-applet
run udiskie --use-udisks2
run google-chrome-stable --no-startup-window
run dropbox
#run unclutter -idle 2
