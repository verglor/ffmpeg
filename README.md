# Docker container to batch encode files with ffmpeg

Example of encoding all videos from `/videos` to HEVC+Opus MKV and storing in `/encoded_videos`:

`docker run --rm -c 0 --name=ffmpeg -v /videos:/input -v /encoded_videos:/output verglor/ffmpeg -map 0 -c copy -c:v libx265 -crf 24 -c:a libopus -af aformat=channel_layouts="7.1|5.1|stereo"`

