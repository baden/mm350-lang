#!/bin/bash

DIRS="wav"

mkdir AMR

echo "Converting WAV -> AMR"

listing=""
for dir in $DIRS; do
    listing="$listing $dir/*.wav"
done


echo "listing = $listing"

for item in $listing; do
    target=./AMR/`basename $item .wav`.amr
    echo "Convert $item to $target"
    ffmpeg -i $item -acodec libopencore_amrnb -ab 12.2k -ac 1 -ar 8k -y $target
done



## Upload

echo "For upload to FTP server use some of this:"
echo "scp -P 28192 ./1-3.amr root@eomy.navi.cc:/srv/ftp/"
