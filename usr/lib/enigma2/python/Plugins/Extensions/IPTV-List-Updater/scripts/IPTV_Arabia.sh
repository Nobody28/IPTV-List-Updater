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

# Arap Convert
#rm /tmp/arap.* > /dev/null
#rm /tmp/userbouquet.arap.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/arap.m3u -O /tmp/arap.m3u > /dev/null
if [ -f /tmp/arap.m3u ] ; 
	then
		sed "1,1d" /tmp/arap.m3u > /tmp/arap.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/arap.0 > /tmp/arap.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/arap.00 > /tmp/arap.000
		echo '#NAME IPTV Arabisch by Nobody28 (TV)' > /tmp/arap.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Arabische Kanäle' >> /tmp/arap.1
		echo '#DESCRIPTION --- Arap by Nobody28 ---' >> /tmp/arap.1
		cat /tmp/arap.000 >> /tmp/arap.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/arap.1 > /tmp/arap.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/arap.2 > /tmp/arap.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/arap.3 > /tmp/arap.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/arap.4 > /tmp/arap.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/arap.5 > /tmp/arap.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/arap.6 > /tmp/arap.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/arap.7 > /tmp/arap.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/arap.8 > /tmp/userbouquet.arap.tv
		cp /tmp/userbouquet.arap.tv /etc/enigma2/userbouquet.arap.tv > /dev/null
		rm /tmp/arap.* > /dev/null
		echo $LINE
		echo 'Download Complete'
		
		if grep -qs 'userbouquet.arap.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.arap.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.arap.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi

