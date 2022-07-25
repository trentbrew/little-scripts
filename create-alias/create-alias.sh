#!/bin/bash

set -o noclobber
echo "alias $1=\"$2\"" >> ~/.zshrc
echo "${BLUE}alias saved in ~/.zsh${NC}"