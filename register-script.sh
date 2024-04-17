#!/bin/bash

script_name="$1.sh"
alias_name="$2"

chmod +x "$script_name"
script_path=$(pwd)/$script_name
echo "alias $alias_name=\"$script_path\"" >>~/.zshrc
echo "alias $alias_name for $script_path added to ~/.zshrc"
echo "reset zsh to apply changes"
