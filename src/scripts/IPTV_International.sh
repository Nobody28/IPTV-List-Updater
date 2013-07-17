#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating International IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# int Convert
#rm /tmp/int.* > /dev/null
#rm /tmp/userbouquet.int.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/int.m3u -O /tmp/int.m3u > /dev/null
if [ -f /tmp/int.m3u ] ; 
	then
		sed "1,1d" /tmp/int.m3u > /tmp/int.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/int.0 > /tmp/int.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/int.00 > /tmp/int.000
		echo '#NAME IPTV International by Nobody28 (TV)' > /tmp/int.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Internationale Kanäle' >> /tmp/int.1
		echo '#DESCRIPTION --- International by Nobody28 ---' >> /tmp/int.1
		cat /tmp/int.000 >> /tmp/int.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/int.1 > /tmp/int.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/int.2 > /tmp/int.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/int.3 > /tmp/int.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/int.4 > /tmp/int.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/int.5 > /tmp/int.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/int.6 > /tmp/int.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/int.7 > /tmp/int.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/int.8 > /tmp/userbouquet.int.tv
		cp /tmp/userbouquet.int.tv /etc/enigma2/userbouquet.int.tv > /dev/null
		rm /tmp/int.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.int.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.int.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.int.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
