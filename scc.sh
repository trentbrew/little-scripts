#!/bin/bash

# Get the current working directory
cwd=$(pwd)

# Check if a shortcut exists for the current directory
shortcut=$(grep "alias \\.*=\"cd $cwd\"" ~/.zshrc)

if [ -n "$shortcut" ]; then
  echo "Yes, shortcut is: $(echo $shortcut | cut -d' ' -f 2)"
else
  echo "No shortcut exists for $cwd"
fi
