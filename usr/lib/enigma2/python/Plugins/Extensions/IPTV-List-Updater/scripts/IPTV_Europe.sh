#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Europe IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# avrupa Convert
#rm /tmp/avrupa.* > /dev/null
#rm /tmp/userbouquet.avrupa.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/avrupa.m3u -O /tmp/avrupa.m3u > /dev/null
if [ -f /tmp/avrupa.m3u ] ; 
	then
		sed "1,1d" /tmp/avrupa.m3u > /tmp/avrupa.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/avrupa.0 > /tmp/avrupa.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/avrupa.00 > /tmp/avrupa.000
		echo '#NAME IPTV Europa by Nobody28 (TV)' > /tmp/avrupa.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Europäische Kanäle' >> /tmp/avrupa.1
		echo '#DESCRIPTION --- Europa by Nobody28 ---' >> /tmp/avrupa.1
		cat /tmp/avrupa.000 >> /tmp/avrupa.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/avrupa.1 > /tmp/avrupa.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/avrupa.2 > /tmp/avrupa.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/avrupa.3 > /tmp/avrupa.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/avrupa.4 > /tmp/avrupa.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/avrupa.5 > /tmp/avrupa.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/avrupa.6 > /tmp/avrupa.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/avrupa.7 > /tmp/avrupa.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/avrupa.8 > /tmp/userbouquet.avrupa.tv
		cp /tmp/userbouquet.avrupa.tv /etc/enigma2/userbouquet.avrupa.tv > /dev/null
		rm /tmp/avrupa.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.avrupa.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.avrupa.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.avrupa.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi


