#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE
echo 'Updating America IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# Amerika Convert
#rm /tmp/amerika.* > /dev/null
#rm /tmp/userbouquet.amerika.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/amerika.m3u -O /tmp/amerika.m3u > /dev/null
if [ -f /tmp/amerika.m3u ] ; 
	then
		sed "1,1d" /tmp/amerika.m3u > /tmp/amerika.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/amerika.0 > /tmp/amerika.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/amerika.00 > /tmp/amerika.000
		echo '#NAME IPTV Amerika by Nobody28 (TV)' > /tmp/amerika.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Amerika Kanäle' >> /tmp/amerika.1
		echo '#DESCRIPTION --- Amerika by Nobody28 ---' >> /tmp/amerika.1
		cat /tmp/amerika.000 >> /tmp/amerika.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/amerika.1 > /tmp/amerika.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/amerika.2 > /tmp/amerika.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/amerika.3 > /tmp/amerika.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/amerika.4 > /tmp/amerika.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/amerika.5 > /tmp/amerika.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/amerika.6 > /tmp/amerika.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/amerika.7 > /tmp/amerika.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/amerika.8 > /tmp/userbouquet.amerika.tv
		cp /tmp/userbouquet.amerika.tv /etc/enigma2/userbouquet.amerika.tv > /dev/null
		rm /tmp/amerika.* > /dev/null
		echo $LINE
		echo 'Download Complete'
		
		if grep -qs 'userbouquet.amerika.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo $LINE
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.amerika.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.amerika.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
