#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Turkey IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# turki Convert
#rm /tmp/turki.* > /dev/null
#rm /tmp/userbouquet.turki.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/turki.m3u -O /tmp/turki.m3u > /dev/null
if [ -f /tmp/turki.m3u ] ; 
	then
		sed "1,1d" /tmp/turki.m3u > /tmp/turki.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/turki.0 > /tmp/turki.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/turki.00 > /tmp/turki.000
		echo '#NAME IPTV Türkisch by Nobody28 (TV)' > /tmp/turki.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Türkische Kanäle' >> /tmp/turki.1
		echo '#DESCRIPTION --- Türkisch by Nobody28 ---' >> /tmp/turki.1
		cat /tmp/turki.000 >> /tmp/turki.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/turki.1 > /tmp/turki.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/turki.2 > /tmp/turki.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/turki.3 > /tmp/turki.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/turki.4 > /tmp/turki.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/turki.5 > /tmp/turki.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/turki.6 > /tmp/turki.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/turki.7 > /tmp/turki.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/turki.8 > /tmp/userbouquet.turki.tv
		cp /tmp/userbouquet.turki.tv /etc/enigma2/userbouquet.turki.tv > /dev/null
		rm /tmp/turki.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.turki.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.turki.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.turki.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
