#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Greek IPTV Bouquets'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

#greek  Convert
#rm /tmp/greek.* > /dev/null
#rm /tmp/userbouquet.greek.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/greek.m3u -O /tmp/greek.m3u > /dev/null
if [ -f /tmp/greek.m3u ] ; 
	then
		sed "1,1d" /tmp/greek.m3u > /tmp/greek.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/greek.0 > /tmp/greek.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/greek.00 > /tmp/greek.000
		echo '#NAME IPTV Griechisch by Nobody28 (TV)' > /tmp/greek.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Griechische Kanaele' >> /tmp/greek.1
		echo '#DESCRIPTION ---Griechisch by Nobody28 ---' >> /tmp/greek.1
		cat /tmp/greek.000 >> /tmp/greek.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/greek.1 > /tmp/greek.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/greek.2 > /tmp/greek.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/greek.3 > /tmp/greek.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/greek.4 > /tmp/greek.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/greek.5 > /tmp/greek.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/greek.6 > /tmp/greek.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/greek.7 > /tmp/greek.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/greek.8 > /tmp/userbouquet.greek.tv
		cp /tmp/userbouquet.greek.tv /etc/enigma2/userbouquet.greek.tv > /dev/null
		rm /tmp/greek.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.greek.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.greek.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.greek.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
