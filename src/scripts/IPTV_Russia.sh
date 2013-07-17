#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Russia IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# rus Convert
#rm /tmp/rus.* > /dev/null
#rm /tmp/userbouquet.rus.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/rus.m3u -O /tmp/rus.m3u > /dev/null
if [ -f /tmp/rus.m3u ] ; 
	then
		sed "1,1d" /tmp/rus.m3u > /tmp/rus.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/rus.0 > /tmp/rus.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/rus.00 > /tmp/rus.000
		echo '#NAME IPTV Russisch by Nobody28 (TV)' > /tmp/rus.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Russische Kanäle' >> /tmp/rus.1
		echo '#DESCRIPTION --- Russisch by Nobody28 ---' >> /tmp/rus.1
		cat /tmp/rus.000 >> /tmp/rus.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/rus.1 > /tmp/rus.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/rus.2 > /tmp/rus.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/rus.3 > /tmp/rus.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/rus.4 > /tmp/rus.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/rus.5 > /tmp/rus.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/rus.6 > /tmp/rus.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/rus.7 > /tmp/rus.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/rus.8 > /tmp/userbouquet.rus.tv
		cp /tmp/userbouquet.rus.tv /etc/enigma2/userbouquet.rus.tv > /dev/null
		rm /tmp/rus.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.rus.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.rus.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.rus.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi