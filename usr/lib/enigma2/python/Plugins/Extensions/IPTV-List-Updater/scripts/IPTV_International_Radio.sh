#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating int_radio IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# int_radio Convert
#rm /tmp/int_radio.* > /dev/null
#rm /tmp/userbouquet.int_radio.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/int_radio.m3u -O /tmp/int_radio.m3u > /dev/null
if [ -f /tmp/int_radio.m3u ] ; 
	then
		sed "1,1d" /tmp/int_radio.m3u > /tmp/int_radio.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/int_radio.0 > /tmp/int_radio.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/int_radio.00 > /tmp/int_radio.000
		echo '#NAME IPTV International Radio by Nobody28 (TV)' > /tmp/int_radio.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::International Radio Kanäle' >> /tmp/int_radio.1
		echo '#DESCRIPTION --- International Radio by Nobody28 ---' >> /tmp/int_radio.1
		cat /tmp/int_radio.000 >> /tmp/int_radio.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/int_radio.1 > /tmp/int_radio.2
		sed 's/rtmp%3a/#SERVICE 4097:0:2:0:0:0:0:0:0:0:rtmp%3a/' /tmp/int_radio.2 > /tmp/int_radio.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:2:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/int_radio.3 > /tmp/int_radio.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:2:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/int_radio.4 > /tmp/int_radio.5
		sed 's/rtsp%3a/#SERVICE 4097:0:2:0:0:0:0:0:0:0:rtsp%3a/' /tmp/int_radio.5 > /tmp/int_radio.6
		sed 's/mms%3a/#SERVICE 4097:0:2:0:0:0:0:0:0:0:mms%3a/' /tmp/int_radio.6 > /tmp/int_radio.7
		sed 's/mmsh%3a/#SERVICE 4097:0:2:0:0:0:0:0:0:0:mmsh%3a/' /tmp/int_radio.7 > /tmp/int_radio.8
		sed '/#SERVICE 4097:0:2:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:2:0:0:0:0:0:0:0:http%3a/' /tmp/int_radio.8 > /tmp/userbouquet.int_radio.tv
		cp /tmp/userbouquet.int_radio.tv /etc/enigma2/userbouquet.int_radio.tv > /dev/null
		rm /tmp/int_radio.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.int_radio.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.int_radio.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.int_radio.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
