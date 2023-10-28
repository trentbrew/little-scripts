#!/bin/bash

set -o noclobber
touch ~/vault/$1.txt
echo $2 >> ~/vault/$1.txt
echo "created key for $1 in ~/vault/$1.txt"
