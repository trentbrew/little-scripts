#!/bin/bash

# Check if an alias already exists and remove it
existing_alias=$(grep -n "^alias $1=" ~/.zshrc | cut -d : -f 1)
if [ ! -z "$existing_alias" ]; then
  sed -i.bak "${existing_alias}d" ~/.zshrc
fi

# Add the new alias
echo "alias :$1=\"cd $(pwd) && c .\"" >>~/.zshrc
echo "alias :$1 created: cd $(pwd) && c"
