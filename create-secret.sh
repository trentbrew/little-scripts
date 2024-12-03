#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 {name} {value}"
  exit 1
fi

# Assign arguments to variables
name=$1
value=$2

# Define the file path
file_path="/Users/trent/.vault/${name}.txt"

# Create a new file with the name provided and write the value to it
echo "${value}" >"${file_path}"

echo "secret created at ${file_path}"
