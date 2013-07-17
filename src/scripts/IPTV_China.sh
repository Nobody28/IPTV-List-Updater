#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating China IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# china Convert
#rm /tmp/china.* > /dev/null
#rm /tmp/userbouquet.china.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/china.m3u -O /tmp/china.m3u > /dev/null
if [ -f /tmp/china.m3u ] ; 
	then
		sed "1,1d" /tmp/china.m3u > /tmp/china.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/china.0 > /tmp/china.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/china.00 > /tmp/china.000
		echo '#NAME IPTV China by Nobody28 (TV)' > /tmp/china.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::China Kanaele' >> /tmp/china.1
		echo '#DESCRIPTION --- China by Nobody28 ---' >> /tmp/china.1
		cat /tmp/china.000 >> /tmp/china.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/china.1 > /tmp/china.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/china.2 > /tmp/china.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/china.3 > /tmp/china.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/china.4 > /tmp/china.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/china.5 > /tmp/china.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/china.6 > /tmp/china.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/china.7 > /tmp/china.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/china.8 > /tmp/userbouquet.china.tv
		cp /tmp/userbouquet.china.tv /etc/enigma2/userbouquet.china.tv > /dev/null
		rm /tmp/china.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.china.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.china.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.china.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
