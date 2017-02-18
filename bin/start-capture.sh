#!/bin/bash

FR=24
OUTPUT_DIR="capture-$TS"

##################

capture_slides() {
  local output_dir=$1
  ffmpeg \
    -hide_banner -nostats -loglevel warning \
    -f x11grab -r ${FR} -s hd1080 -i :0.0+1920,0 \
    -vcodec libx264 \
    -preset ultrafast \
    $output_dir/slides.mkv > $output_dir/slides.log 2>&1
}

capture_terminal() {
  local output_dir=$1
  ffmpeg \
    -hide_banner -nostats -loglevel warning \
    -f x11grab -r ${FR} -s hd1080 -i :0.0+0,0 \
    -vcodec libx264 \
    -preset ultrafast \
    $output_dir/terminal.mkv > $output_dir/terminal.log 2>&1
}

capture_webcam() {
  local output_dir=$1
  ffmpeg \
    -hide_banner -nostats -loglevel warning \
    -f pulse -i default \
    -f v4l2 -framerate ${FR} -input_format h264 -video_size hd1080 -i /dev/video0 \
    -c copy \
    $output_dir/webcam.mkv > $output_dir/webcam.log 2>&1
}

TS=`date +%Y-%m-%d-%H%M`

mkdir -p $OUTPUT_DIR

echo "starting run at $TS"

echo "capturing slides"
capture_slides $OUTPUT_DIR &
echo "slides done"

echo "capturing terminal"
capture_terminal $OUTPUT_DIR &
echo "terminal done"

echo "capturing webcam"
capture_webcam $OUTPUT_DIR &
echo "webcam done"

for job in `jobs -p`; do
  wait $job
done

echo "done"

