#!/bin/bash

# Default DPI for 1080p
DPI=96

# Check if argument is provided
if [ -z "$1" ]
then
    echo "Please provide a point value as an argument."
    exit 1
fi

# Calculate px from pt
PT=$1
PX=$(echo "$PT * $DPI / 72" | bc)

echo "${PT}pt = ${PX}px (copied to clipboard)"
echo "${PX}px" | pbcopy
