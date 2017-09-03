#!/bin/bash

set -o errexit -o nounset -o pipefail

usage() {
	echo "Usage: $0 <section_number>
    where <section_number> is something like 1.1.2"
}
(( $# != 1 )) && usage && exit 1
section=$1

timestamp=`date +%Y-%m-%d-%H%M`
output_dir="captures/${section}/capture-${timestamp}"
framerate=30

capture_slides() {
  local output_dir=$1
  ~/bin/ffmpeg \
    -hide_banner -nostats -loglevel warning \
    -f x11grab -r $framerate -s hd1080 -i :0.0+1920,0 \
    -vcodec libx264 \
    -preset ultrafast \
    $output_dir/slides.mkv > $output_dir/slides.log 2>&1
  echo "slides done"
}

capture_terminal() {
  local output_dir=$1
  ~/bin/ffmpeg \
    -hide_banner -nostats -loglevel warning \
    -f x11grab -r $framerate -s hd1080 -i :0.0+0,0 \
    -vcodec libx264 \
    -preset ultrafast \
    $output_dir/terminal.mkv > $output_dir/terminal.log 2>&1
  echo "terminal done"
}

capture_audio() {
  local output_dir=$1
  ~/bin/ffmpeg \
    -hide_banner -nostats -loglevel warning \
    -f alsa -i default \
    -c copy -copyts -start_at_zero \
    $output_dir/audio.wav > $output_dir/webcam.log 2>&1
  echo "webcam done"
}

#    -f alsa -i default \
capture_webcam() {
  local output_dir=$1
  ~/bin/ffmpeg \
    -hide_banner -nostats -loglevel warning \
    -f v4l2 -framerate $framerate -input_format h264 -video_size hd1080 -ts mono2abs -i /dev/video0 \
    -c copy -copyts -start_at_zero \
    $output_dir/webcam.mkv > $output_dir/webcam.log 2>&1
  echo "webcam done"
}

#  ~/bin/ffmpeg \
#    -hide_banner -nostats -loglevel warning \
#    -f pulse -i default \
#    -f v4l2 -framerate $framerate -input_format h264 -video_size hd1080 -ts mono2abs -i /dev/video0 \
#    -c copy -copyts \
#    $output_dir/webcam.mkv > $output_dir/webcam.log 2>&1

    #-itsoffset -1.5 -f pulse -i default \
    #-c copy -copyts \
    #-f v4l2 -framerate $framerate -input_format h264 -video_size hd1080 -ts mono2abs -i /dev/video0 \

##################

# Get arguments
#while getopts ':s:' OPT; do
#  case $OPT in
#    s) section=$OPTARG ;;
#    e) env=$OPTARG ;;
#    l) layer=$OPTARG ;;
#    n) nocolour='-no-color' ;;
#    x) xtraopts=$OPTARG ;;
#  esac
#done

echo "starting run for $section at $timestamp"

mkdir -p $output_dir

echo "capturing slides"
capture_slides $output_dir &

echo "capturing terminal"
capture_terminal $output_dir &

echo "capturing webcam"
capture_webcam $output_dir &

echo "capturing audio"
capture_audio $output_dir &

for job in `jobs -p`; do
  wait $job
done

echo "done"

