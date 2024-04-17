#!/bin/bash

script_name="$1"
alias_name="$2"

# If no alias name is provided, use the script name without the extension as the alias name
if [ -z "$alias_name" ]; then
  alias_name="${script_name%.*}"
  # Check if the alias name is already taken
  if grep -q "alias $alias_name=" ~/.zshrc; then
    echo "The alias name '$alias_name' is already taken. Please provide a different alias name."
    exit 1
  fi
fi

chmod +x "$script_name"
script_path=$(pwd)/$script_name
echo "alias $alias_name=\"$script_path\"" >>~/.zshrc
echo "alias $alias_name for $script_path added to ~/.zshrc"
