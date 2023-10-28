#!/bin/bash

echo "";
echo -e "${BLUE}🎥 fetching video... ${NC}";
echo "";
cd ~/Movies/Saved && clear && youtube-dl -f --rm-cache-dir mp4 $1;
echo "";
echo "mp4 downloaded successfully!";
echo "";
