#!/bin/bash

# Get the line for the primary display
line=$(xrandr --query | grep " primary ")

# Extract WxH+X+Y
if [[ $line =~ ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+) ]]; then
    echo "${BASH_REMATCH[3]} ${BASH_REMATCH[4]}"
else
    echo "0 0"
fi
