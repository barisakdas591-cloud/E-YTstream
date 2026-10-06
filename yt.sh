#!/bin/bash
VBR="1500k"
FPS="24"
QUAL="superfast"
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"
KEY="x3ad-9s25-g7v6-7pc4-a98y"
VIDEO_SOURCE="./pixel-jeff-mario.gif"
AUDIO_SOURCE="./input.txt"
playlist_position=1
while true; do
    echo "Stream ended. Restarting...."
    pkill -f "ffmpeg"
    sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
    ffmpeg -re -f lavfi -i "movie=filename=$VIDEO_SOURCE:loop=0, setpts=N/FRAME_RATE/TB" -thread_queue_size 512 -f concat -safe 0 -stream_loop -1 -i "$AUDIO_SOURCE" -map 0:v:0 -map 1:a:0 -map_metadata:g 1:g -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR -acodec libmp3lame -ar 44100 -threads 6 -qscale:v 3 -b:a 320k -bufsize 512k -f flv "$YOUTUBE_URL/$KEY"
done
