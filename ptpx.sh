#!/bin/bash

# Default DPI for 1080p
DPI=96

# Parse command line arguments
while getopts ":d:" opt; do
  case ${opt} in
    d )
      # Get the dimensions
      dimensions=$OPTARG
      # Split the dimensions into width and height
      IFS='x' read -ra SIZE <<< "$dimensions"
      # Calculate the DPI (assuming a 21.5" monitor)
      DPI=$(echo "sqrt(${SIZE[0]}^2 + ${SIZE[1]}^2) / 21.5" | bc)
      ;;
    \? )
      echo "Invalid option: -$OPTARG" 1>&2
      exit 1
      ;;
    : )
      echo "Option -$OPTARG requires an argument." 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

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
