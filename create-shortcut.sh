#!/bin/bash

set -o noclobber
echo "alias $1=\"cd $(pwd)\"" >> ~/.zshrc
echo "generated alias $1=\"cd $(pwd)\" in ~/.zshrc"