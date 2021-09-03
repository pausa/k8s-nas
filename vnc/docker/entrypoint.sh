#!/usr/bin/env fish

set -x DISPLAY :1

Xvfb "$DISPLAY" -screen 0 1920x1080x24 &
x11vnc -forever &
startxfce4
