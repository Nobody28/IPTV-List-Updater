#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Romania IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# romanya Convert
#rm /tmp/romanya.* > /dev/null
#rm /tmp/userbouquet.romanya.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/romanya.m3u -O /tmp/romanya.m3u > /dev/null
if [ -f /tmp/romanya.m3u ] ; 
	then
		sed "1,1d" /tmp/romanya.m3u > /tmp/romanya.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/romanya.0 > /tmp/romanya.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/romanya.00 > /tmp/romanya.000
		echo '#NAME IPTV Rumaenien-Moldavien by Nobody28 (TV)' > /tmp/romanya.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Rumaenische Kanaele' >> /tmp/romanya.1
		echo '#DESCRIPTION --- Rumaenisch-Moldavien by Nobody28 ---' >> /tmp/romanya.1
		cat /tmp/romanya.000 >> /tmp/romanya.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/romanya.1 > /tmp/romanya.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/romanya.2 > /tmp/romanya.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/romanya.3 > /tmp/romanya.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/romanya.4 > /tmp/romanya.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/romanya.5 > /tmp/romanya.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/romanya.6 > /tmp/romanya.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/romanya.7 > /tmp/romanya.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/romanya.8 > /tmp/userbouquet.romanya.tv
		cp /tmp/userbouquet.romanya.tv /etc/enigma2/userbouquet.romanya.tv > /dev/null
		rm /tmp/romanya.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.romanya.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.romanya.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.romanya.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
