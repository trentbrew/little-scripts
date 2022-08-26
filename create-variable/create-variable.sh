#!/bin/bash

set -o noclobber
echo "$1=\"$2\"" >> ~/.zshrc
echo "${BLUE}variable saved in ~/.zsh${NC}"