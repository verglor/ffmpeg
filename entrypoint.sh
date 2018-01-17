#!/bin/sh

path=${INPUT_PATH}
mask=${INPUT_REGEX:-"\.(mkv|mp4|avi|ts|flv|mov|m4v|mpg|mpeg|wmv|asf|rmvb)$"}
video_codec_skip=${INPUT_VIDEO_CODEC_SKIP:-hevc}
ext=${OUTPUT_EXT:-mkv}
nice=${PROCESS_NICE:-10}

cd /input

find "./$path" -type f | egrep -i "$mask" | sort | cut -c 3- | while read input
do

    video_codec=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$input")

    echo
    echo "================================================================================"
    echo ">>> $input [$video_codec]"
    echo "================================================================================"

    if [ "$video_codec" == "$video_codec_skip" ]; then
        echo "    *** Video codec is already $video_codec_skip ***"
    else
        output="/output/${input%.*}.$ext"
        mkdir -p "$(dirname "$output")"
        nice -n $nice ffmpeg -n -hide_banner -v info -i "$input" "$@" "$output" < /dev/null || true
    fi

    echo "--------------------------------------------------------------------------------"
    echo

done
