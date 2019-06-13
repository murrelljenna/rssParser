#!/bin/bash

if [ $# -eq 2 ]; then

  SRC="$1"
  DEST="$2"
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

  if [ ! -d "$DEST" ]; then
    mkdir "$DEST"
  fi

  wget -O "$DIR/rss.xml" $SRC
  cat rss.xml | grep -o 'https://.*\.mp3' | grep -v 'teaser' | sort --unique > urls
  wget -i urls -w120 --random-wait
  mv *.mp3 "$DEST/*"

else

  echo "Usage: ./rssparse.sh [<SOURCE URL>] [<destination directory>]"
  
fi
