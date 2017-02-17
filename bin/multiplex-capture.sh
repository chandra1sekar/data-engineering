#!/bin/bash 

exit 1

[ -f composite.mkv ] && echo "${pwd}/composite.mkv exists" && exit 0

probe_duration() {
  local file_name=$1
  ffprobe -i $file_name -show_entries format=duration -v quiet -of csv="p=0"
}

generate_test_pattern() {
  local duration=$1
  ffmpeg \
    -hide_banner -nostats -loglevel warning \
    -f lavfi -i testsrc=duration=${duration}:size=hd1080:rate=30:decimals=2 \
    testpattern.mkv > testpattern.log 2>&1
}

echo "probing duration"
duration=`probe_duration webcam.mkv`

echo "generating test pattern for $duration seconds"
time generate_test_pattern $duration
echo "testpattern done"


echo "building composite"

#ffmpeg \
	#-i webcam.mkv \
	#-i slides.mkv \
	#-i terminal.mkv \
	#-i testpattern.mkv \
	#-filter_complex "nullsrc=size=1920x1080 [base]; [0:v] setpts=PTS-STARTPTS, scale=960x540 [upperleft]; [1:v] setpts=PTS-STARTPTS, scale=960x540 [upperright]; [2:v] setpts=PTS-STARTPTS, scale=960x540 [lowerleft]; [3:v] setpts=PTS-STARTPTS, scale=960x540 [lowerright]; [base][upperleft] overlay=shortest=1 [tmp1]; [tmp1][upperright] overlay=shortest=1:x=960 [tmp2]; [tmp2][lowerleft] overlay=shortest=1:y=540 [tmp3]; [tmp3][lowerright] overlay=shortest=1:x=960:y=540 " \
	#-c:v libx264 output.mkv

#combine_filter="nullsrc=size=1920x1080 [base]; [0:v] setpts=PTS-STARTPTS, scale=960x540 [upperleft]; [1:v] setpts=PTS-STARTPTS, scale=960x540 [upperright]; [2:v] setpts=PTS-STARTPTS, scale=960x540 [lowerleft]; [3:v] setpts=PTS-STARTPTS, scale=960x540 [lowerright]; [base][upperleft] overlay=shortest=1 [tmp1]; [tmp1][upperright] overlay=shortest=1:x=960 [tmp2]; [tmp2][lowerleft] overlay=shortest=1:y=540 [tmp3]; [tmp3][lowerright] overlay=shortest=1:x=960:y=540 " \

read -r -d '' combine_filter <<'EOS'
  nullsrc=size=1920x1080 [base];
  [0:v] setpts=PTS-STARTPTS, scale=960x540 [upperleft];
  [1:v] setpts=PTS-STARTPTS, scale=960x540 [upperright];
  [2:v] setpts=PTS-STARTPTS, scale=960x540 [lowerleft];
  [3:v] setpts=PTS-STARTPTS, scale=960x540 [lowerright];
  [base][upperleft] overlay=shortest=1 [tmp1];
  [tmp1][upperright] overlay=shortest=1:x=960 [tmp2];
  [tmp2][lowerleft] overlay=shortest=1:y=540 [tmp3];
  [tmp3][lowerright] overlay=shortest=1:x=960:y=540
EOS

time ffmpeg \
  -hide_banner -nostats -loglevel warning \
	-i webcam.mkv \
	-i slides.mkv \
	-i terminal.mkv \
	-i testpattern.mkv \
	-filter_complex "$combine_filter" \
	-c:v libx264 \
	composite.mkv > composite.log 2>&1

echo "done building composite"

echo "done"
