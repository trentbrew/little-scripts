#!/bin/bash

set -o noclobber
echo "alias $1=\"$2\"" >>~/.zshrc
echo "alias \`$1\` saved in ~/.zshrc"
echo "reset zsh to apply changes"
