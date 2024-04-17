#!/bin/bash

set -o noclobber
echo "$1=\"$2\"" >>~/.zshrc
echo "global variable \`\$$1\` set to \`$2\`"
echo "reset zsh to apply changes"
