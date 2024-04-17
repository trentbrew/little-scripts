#!/bin/bash

# Get the last command from history using fc
last_command=$

echo "last command: $last_command"

# Check if the alias already exists
if grep -q "alias $1=" ~/.zshrc; then
  echo "The alias '$1' already exists."
else
  # Add the new alias to .zshrc
  echo "alias $1='$last_command'" >>~/.zshrc
  echo "alias $1 for '$last_command' added to ~/.zshrc"
fi
