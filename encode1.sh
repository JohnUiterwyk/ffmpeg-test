#!/bin/bash          
rm -f output.mp4
width=1280
height=720
ffmpeg 				\
-i vid01.mp4 \
-i vid02.mp4 \
-i vid03.mp4 \
-i vid04.mp4 \
-filter_complex "	\
		movie=vid01.mp4, scale=iw*min($width/iw\,$height/ih):ih*min($width/iw\,$height/ih), pad=$width:$height:($width-iw*min($width/iw\,$height/ih))/2:($height-ih*min($width/iw\,$height/ih))/2 [v1] ;\
		amovie=vid01.mp4 [a1] ;\
		movie=vid02.mp4, scale=iw*min($width/iw\,$height/ih):ih*min($width/iw\,$height/ih), pad=$width:$height:($width-iw*min($width/iw\,$height/ih))/2:($height-ih*min($width/iw\,$height/ih))/2 [v2] ;\
		amovie=vid02.mp4 [a2] ;\
		movie=vid03.mp4,  scale=iw*min($width/iw\,$height/ih):ih*min($width/iw\,$height/ih), pad=$width:$height:($width-iw*min($width/iw\,$height/ih))/2:($height-ih*min($width/iw\,$height/ih))/2 [v3] ;\
		amovie=vid03.mp4 [a3] ;\
		movie=vid04.mp4,  scale=iw*min($width/iw\,$height/ih):ih*min($width/iw\,$height/ih), pad=$width:$height:($width-iw*min($width/iw\,$height/ih))/2:($height-ih*min($width/iw\,$height/ih))/2 [v4] ;\
		amovie=vid04.mp4 [a4] ;\
		[v1] [v2] [v3] [v4] concat=n=4 [outv] ;\
		[a1] [a2] [a3] [a4] concat=n=4:v=0:a=1 [outa]\
	"	\
  -map '[outv]' -map '[outa]' output.mp4