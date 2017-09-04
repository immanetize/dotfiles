#!/bin/bash
xrandr --output DP1-1 --auto --primary
xrandr --output eDP1 --left-of DP1-1
xrandr --output DP1-2 --auto  --right-of DP1-1
