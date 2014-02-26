rm -f OUTPUT.mp4
width=1280
height=720
ffmpeg 				\
-i vid01.mp4 \
-i vid02.mp4 \
-i vid03.mp4 \
-i vid04.mp4 \
-filter_complex "	\
		amovie=vid01.mp4 [a1];\
		amovie=vid02.mp4 [a2];\
		amovie=vid03.mp4 [a3];\
		amovie=vid04.mp4 [a4];\
		[a1] [a2] amerge [a5];\
		[a3] [a4] amerge [a6];\
		[a5] [a6] amerge ;\
		nullsrc=size=640x480 [base];	\
		[0:v] setpts=PTS-STARTPTS, scale=320x240 [upperleft];	\
		[1:v] setpts=PTS-STARTPTS, scale=320x240 [upperright];	\
		[2:v] setpts=PTS-STARTPTS, scale=320x240 [lowerleft];	\
		[3:v] setpts=PTS-STARTPTS, scale=320x240 [lowerright];	\
		[base][upperleft] overlay=shortest=1 [tmp1];			\
		[tmp1][upperright] overlay=shortest=1:x=320 [tmp2];		\
		[tmp2][lowerleft] overlay=shortest=1:y=240 [tmp3];		\
		[tmp3][lowerright] overlay=shortest=1:x=320:y=240		\
	"	\
-vcodec h264 		\
-vprofile high 			\
-preset slow 			\
-b:v 500k 				\
-maxrate 500k 			\
-bufsize 10000k 			\
-threads 0 				\
-acodec libfaac 	\
-b:a 128k 				\
-loglevel verbose \
OUTPUT.mp4