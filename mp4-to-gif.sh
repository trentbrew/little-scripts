#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./convert_mp4_to_gif.sh <input_file.mp4>"
  exit 1
fi

filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"

if [ "$extension" != "mp4" ]; then
  echo "Please provide an MP4 file."
  exit 1
fi

ffmpeg -i "$1" -vf "fps=10,scale=320:-1:flags=lanczos" "${filename}.gif"
echo "Conversion complete. The GIF is saved as ${filename}.gif"
