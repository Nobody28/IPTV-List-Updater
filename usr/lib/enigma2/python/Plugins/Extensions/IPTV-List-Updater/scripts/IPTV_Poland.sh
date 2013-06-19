#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Poland IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# polonya Convert
#rm /tmp/polonya.* > /dev/null
#rm /tmp/userbouquet.polonya.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/polonya.m3u -O /tmp/polonya.m3u > /dev/null
if [ -f /tmp/polonya.m3u ] ; 
	then
		sed "1,1d" /tmp/polonya.m3u > /tmp/polonya.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/polonya.0 > /tmp/polonya.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/polonya.00 > /tmp/polonya.000
		echo '#NAME IPTV Polnisch by Nobody28 (TV)' > /tmp/polonya.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Polnische Kanäle' >> /tmp/polonya.1
		echo '#DESCRIPTION --- Polnisch by Nobody28 ---' >> /tmp/polonya.1
		cat /tmp/polonya.000 >> /tmp/polonya.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/polonya.1 > /tmp/polonya.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/polonya.2 > /tmp/polonya.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/polonya.3 > /tmp/polonya.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/polonya.4 > /tmp/polonya.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/polonya.5 > /tmp/polonya.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/polonya.6 > /tmp/polonya.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/polonya.7 > /tmp/polonya.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/polonya.8 > /tmp/userbouquet.polonya.tv
		cp /tmp/userbouquet.polonya.tv /etc/enigma2/userbouquet.polonya.tv > /dev/null
		rm /tmp/polonya.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.polonya.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.polonya.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.polonya.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
