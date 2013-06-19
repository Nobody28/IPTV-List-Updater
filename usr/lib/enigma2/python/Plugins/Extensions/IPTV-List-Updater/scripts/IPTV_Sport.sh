#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Sport IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# spor Convert
#rm /tmp/spor.* > /dev/null
#rm /tmp/userbouquet.spor.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/spor.m3u -O /tmp/spor.m3u > /dev/null
if [ -f /tmp/spor.m3u ] ; 
	then
		sed "1,1d" /tmp/spor.m3u > /tmp/spor.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/spor.0 > /tmp/spor.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/spor.00 > /tmp/spor.000
		echo '#NAME IPTV Sport by Nobody28 (TV)' > /tmp/spor.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Sport Kanäle' >> /tmp/spor.1
		echo '#DESCRIPTION --- Sport by Nobody28 ---' >> /tmp/spor.1
		cat /tmp/spor.000 >> /tmp/spor.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/spor.1 > /tmp/spor.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/spor.2 > /tmp/spor.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/spor.3 > /tmp/spor.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/spor.4 > /tmp/spor.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/spor.5 > /tmp/spor.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/spor.6 > /tmp/spor.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/spor.7 > /tmp/spor.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/spor.8 > /tmp/userbouquet.spor.tv
		cp /tmp/userbouquet.spor.tv /etc/enigma2/userbouquet.spor.tv > /dev/null
		rm /tmp/spor.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.spor.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.spor.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.spor.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
