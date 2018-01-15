#!/bin/sh

path=${INPUT_PATH}
mask=${INPUT_REGEX:-"\.(mkv|mp4|avi|ts|flv)$"}
ext=${OUTPUT_EXT:-mkv}
nice=${PROCESS_NICE:-10}

cd /input

find "./$path" -type f | egrep -i "$mask" | sort | cut -c 3- | while read input
do

    echo
    echo "================================================================================"
    echo ">>> $input"
    echo "================================================================================"

    output="/output/${input%.*}.$ext"
    mkdir -p "$(dirname "$output")"
    nice -n $nice ffmpeg -n -hide_banner -v info -i "$input" "$@" "$output" < /dev/null || true

    echo "--------------------------------------------------------------------------------"
    echo

done
