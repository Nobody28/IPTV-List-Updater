#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Asia IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# Asya Convert
#rm /tmp/asya.* > /dev/null
#rm /tmp/userbouquet.asya.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/asya.m3u -O /tmp/asya.m3u > /dev/null
if [ -f /tmp/asya.m3u ] ; 
	then
		sed "1,1d" /tmp/asya.m3u > /tmp/asya.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/asya.0 > /tmp/asya.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/asya.00 > /tmp/asya.000
		echo '#NAME IPTV Asien by Nobody28 (TV)' > /tmp/asya.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Asische Kanäle' >> /tmp/asya.1
		echo '#DESCRIPTION --- Asien by Nobody28 ---' >> /tmp/asya.1
		cat /tmp/asya.000 >> /tmp/asya.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/asya.1 > /tmp/asya.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/asya.2 > /tmp/asya.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/asya.3 > /tmp/asya.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/asya.4 > /tmp/asya.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/asya.5 > /tmp/asya.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/asya.6 > /tmp/asya.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/asya.7 > /tmp/asya.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/asya.8 > /tmp/userbouquet.asya.tv
		cp /tmp/userbouquet.asya.tv /etc/enigma2/userbouquet.asya.tv > /dev/null
		rm /tmp/asya.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.asya.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.asya.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.asya.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
