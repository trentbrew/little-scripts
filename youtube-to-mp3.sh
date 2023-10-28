#!/bin/bash

echo "";
echo -e "${BLUE}🎧 fetching audio... ${NC}";
echo "";
cd ~/Music/My\ Music/Saved;
clear;
youtube-dl -x --rm-cache-dir --audio-format mp3 $1;
echo "";
echo "mp3 downloaded successfully!";
echo "";
