#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 {file_name}"
  exit 1
fi

# Remove file extension and assign to a variable
file_name="${1%.*}"

# Define the file path
file_path="/Users/trent/.vault/${file_name}.txt"

# Check if the file exists
if [ ! -f "${file_path}" ]; then
  echo "File does not exist: ${file_path}"
  exit 1
fi

# Copy the contents of the file to the clipboard
cat "${file_path}" | pbcopy

echo "👍🏾"
