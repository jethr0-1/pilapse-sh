#!/bin/bash
while getopts l:s:o: flag
do
	case "${flag}" in
	    l) l=${OPTARG};;
	    s) s=${OPTARG};;
	    o) o=${OPTARG};;
	esac
done
if [ -z "$l" ] || [ -z "$s" ] || [ -z "$o" ]
then
	echo 'Usage: '$0' -l (length; amount of frames to capture) -s (sleep; seconds to wait between frame) -o (output; output directory, NOT filename)'
	exit 1
fi
for i in $( eval echo {1..$l} )
do
	filename=$i
	while [ ${#filename} -lt 3 ]
	do
		filename=0$filename
	done
	echo 'Frame Number: '$filename
	libcamera-still -o $o$filename.jpg > /dev/null 2>&1
	echo 'Captured, saved to '$o$filename'.jpg. Waiting...'
	sleep $s

done
