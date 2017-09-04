#!/bin/bash
# layout file for an undocked laptop
xrandr --output eDP1 --off 
xrandr --output DP1-1 --off 
xrandr --output DP1-2 --off
xrandr --output eDP1 --auto --primary
