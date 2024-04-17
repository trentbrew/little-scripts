#!/bin/bash

# Find the line with the existing alias
existing_alias=$(grep -n "^alias $1=" ~/.zshrc | cut -d : -f 1)

# If an existing alias was found, remove it
if [ ! -z "$existing_alias" ]; then
  sed -i.bak "${existing_alias}d" ~/.zshrc
fi

# Add the new alias
echo "alias $1=\"$2\"" >>~/.zshrc
echo "alias \`$1\` saved in ~/.zshrc"
echo "reset zsh to apply changes"
