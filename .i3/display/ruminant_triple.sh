#!/bin/bash
/usr/bin/xrandr --output DP-1 --auto --primary --verbose
/usr/bin/xrandr --output DVI-D-0 --right-of DP-1 --auto --verbose
/usr/bin/xrandr --output DVI-I-1 --left-of DP-1 --auto --verbose
