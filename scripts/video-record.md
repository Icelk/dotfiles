# Example to record video from device /dev/video0 to a mp4

ffmpeg -f v4l2 -framerate 30 -video_size 1280x720 -i /dev/video0 output.mp4
