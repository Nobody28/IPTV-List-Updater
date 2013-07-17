#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Italy IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# Italya (Italienisch) Convert
#rm /tmp/italya.* > /dev/null
#rm /tmp/userbouquet.italian.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/italya.m3u -O /tmp/italya.m3u > /dev/null
if [ -f /tmp/italya.m3u ] ; 
	then
		sed "1,1d" /tmp/italya.m3u > /tmp/italya.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/italya.0 > /tmp/italya.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/italya.00 > /tmp/italya.000
		echo '#NAME IPTV Italienisch by Nobody28 (TV)' > /tmp/italya.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Italienische Kanaele' >> /tmp/italya.1
		echo '#DESCRIPTION --- Italienisch by Nobody28 ---' >> /tmp/italya.1
		cat /tmp/italya.000 >> /tmp/italya.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/italya.1 > /tmp/italya.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/italya.2 > /tmp/italya.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/italya.3 > /tmp/italya.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/italya.4 > /tmp/italya.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/italya.5 > /tmp/italya.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/italya.6 > /tmp/italya.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/italya.7 > /tmp/italya.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/italya.8 > /tmp/userbouquet.italya.tv
		cp /tmp/userbouquet.italya.tv /etc/enigma2/userbouquet.italya.tv > /dev/null
		rm /tmp/italya.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.italya.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.italya.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.italya.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
