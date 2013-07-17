#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Arabia IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# kurdi Convert
#rm /tmp/kurdi.* > /dev/null
#rm /tmp/userbouquet.kurdi.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/kurdi.m3u -O /tmp/kurdi.m3u > /dev/null
if [ -f /tmp/kurdi.m3u ] ; 
	then
		sed "1,1d" /tmp/kurdi.m3u > /tmp/kurdi.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/kurdi.0 > /tmp/kurdi.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/kurdi.00 > /tmp/kurdi.000
		echo '#NAME IPTV Kurdisch by Nobody28 (TV)' > /tmp/kurdi.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Kurdische Kanaele' >> /tmp/kurdi.1
		echo '#DESCRIPTION --- Kurdisch by Nobody28 ---' >> /tmp/kurdi.1
		cat /tmp/kurdi.000 >> /tmp/kurdi.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/kurdi.1 > /tmp/kurdi.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/kurdi.2 > /tmp/kurdi.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/kurdi.3 > /tmp/kurdi.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/kurdi.4 > /tmp/kurdi.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/kurdi.5 > /tmp/kurdi.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/kurdi.6 > /tmp/kurdi.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/kurdi.7 > /tmp/kurdi.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/kurdi.8 > /tmp/userbouquet.kurdi.tv
		cp /tmp/userbouquet.kurdi.tv /etc/enigma2/userbouquet.kurdi.tv > /dev/null
		rm /tmp/kurdi.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.kurdi.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.kurdi.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.kurdi.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi