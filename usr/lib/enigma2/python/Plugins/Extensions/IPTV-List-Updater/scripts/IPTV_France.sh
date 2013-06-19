#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'UpdatingFrance IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# fransa Convert
#rm /tmp/fransa.* > /dev/null
#rm /tmp/userbouquet.fransa.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/fransa.m3u -O /tmp/fransa.m3u > /dev/null
if [ -f /tmp/fransa.m3u ] ; 
	then
		sed "1,1d" /tmp/fransa.m3u > /tmp/fransa.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/fransa.0 > /tmp/fransa.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/fransa.00 > /tmp/fransa.000
		echo '#NAME IPTV Frankreich by Nobody28 (TV)' > /tmp/fransa.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Franzoesische Kanaele' >> /tmp/fransa.1
		echo '#DESCRIPTION --- Frankreich by Nobody28 ---' >> /tmp/fransa.1
		cat /tmp/fransa.000 >> /tmp/fransa.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/fransa.1 > /tmp/fransa.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/fransa.2 > /tmp/fransa.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/fransa.3 > /tmp/fransa.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/fransa.4 > /tmp/fransa.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/fransa.5 > /tmp/fransa.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/fransa.6 > /tmp/fransa.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/fransa.7 > /tmp/fransa.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/fransa.8 > /tmp/userbouquet.fransa.tv
		cp /tmp/userbouquet.fransa.tv /etc/enigma2/userbouquet.fransa.tv > /dev/null
		rm /tmp/fransa.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.fransa.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.fransa.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.fransa.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
