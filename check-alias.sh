#!/bin/bash

# Check if the alias or function exists in ~/.zshrc
alias_or_function=$(grep -E "^alias $1=|^function $1\(\)" ~/.zshrc)

if [ -z "$alias_or_function" ]; then
  # If not found, look for similar names
  similar=$(grep -E "^alias .*|^function .*" ~/.zshrc | grep -i "$1" | head -n 1)
  if [ -z "$similar" ]; then
    echo "That alias or function doesn't exist."
  else
    # Extract the potential match name for a clearer suggestion
    match=$(echo "$similar" | awk '{print $2}' | sed 's/(//' | sed 's/=//')
    echo "That alias or function doesn't exist. Did you mean '$match'?"
  fi
else
  # Display the found alias or function
  echo "Found: $alias_or_function"
fi
