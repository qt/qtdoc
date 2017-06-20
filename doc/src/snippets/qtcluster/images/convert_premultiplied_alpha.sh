#!/bin/bash

while read -r line || [[ -n "$line" ]]; do
   echo "Text: $line";
   convert $line -write mpr:temp -background black -alpha Remove mpr:temp -compose Copy_Opacity -composite ../images-premultiplied-alpha/$line
done < "$1"
