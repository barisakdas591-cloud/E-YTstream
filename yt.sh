#!/bin/bash
VBR="1500k"
FPS="24"
QUAL="superfast"
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"
KEY="x3ad-9s25-g7v6-7pc4-a98y"
VIDEO_SOURCE="./pixel-jeff-mario.gif"
AUDIO_SOURCE="./çalma listesi.txt"

while true; do
  ffmpeg -re -f lavfi -i "movie=filename=$VIDEO_SOURCE:loop=0,setpts=N/FRAME_RATE/TB" -f concat -safe 0 -i "$AUDIO_SOURCE" -c:v libx264 -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR -c:a aac -b:a 128k -ar 44100 -pix_fmt yuv420p -vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2" -f flv "$YOUTUBE_URL/$KEY"
  echo "Stream ended. Restarting...."
  sleep 1
done
