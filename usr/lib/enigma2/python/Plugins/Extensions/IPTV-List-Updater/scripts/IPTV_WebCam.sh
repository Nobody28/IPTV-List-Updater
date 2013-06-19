#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating WebCam IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# WebCam  Convert
#rm /tmp/webcam.* > /dev/null
#rm /tmp/userbouquet.webcam.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/webcam.m3u -O /tmp/webcam.m3u > /dev/null
if [ -f /tmp/webcam.m3u ] ; 
	then
		sed "1,1d" /tmp/webcam.m3u > /tmp/webcam.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/webcam.0 > /tmp/webcam.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/webcam.00 > /tmp/webcam.000
		echo '#NAME IPTV WebCam by Nobody28 (TV)' > /tmp/webcam.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Deutsche Kanaele' >> /tmp/webcam.1
		echo '#DESCRIPTION --- Deutsch by Nobody28 ---' >> /tmp/webcam.1
		cat /tmp/webcam.000 >> /tmp/webcam.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/webcam.1 > /tmp/webcam.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/webcam.2 > /tmp/webcam.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/webcam.3 > /tmp/webcam.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/webcam.4 > /tmp/webcam.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/webcam.5 > /tmp/webcam.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/webcam.6 > /tmp/webcam.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/webcam.7 > /tmp/webcam.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/webcam.8 > /tmp/userbouquet.webcam.tv
		cp /tmp/userbouquet.webcam.tv /etc/enigma2/userbouquet.webcam.tv > /dev/null
		rm /tmp/webcam.* > /dev/null
		echo $LINE
		echo 'Download Complete'
		if grep -qs 'userbouquet.webcam.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.webcam.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.webcam.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
