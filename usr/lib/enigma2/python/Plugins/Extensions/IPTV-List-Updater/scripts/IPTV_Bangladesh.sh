#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Bangladesh IPTV Bouquets'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

#bangladesh  Convert
#rm /tmp/bangladesh.* > /dev/null
#rm /tmp/userbouquet.bangladesh.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/bangladesh.m3u -O /tmp/bangladesh.m3u > /dev/null
if [ -f /tmp/bangladesh.m3u ] ; 
	then
		sed "1,1d" /tmp/bangladesh.m3u > /tmp/bangladesh.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/bangladesh.0 > /tmp/bangladesh.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/bangladesh.00 > /tmp/bangladesh.000
		echo '#NAME IPTV Bangladesh by Nobody28 (TV)' > /tmp/bangladesh.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Bangladesh Kanaele' >> /tmp/bangladesh.1
		echo '#DESCRIPTION ---Bangladesh by Nobody28 ---' >> /tmp/bangladesh.1
		cat /tmp/bangladesh.000 >> /tmp/bangladesh.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/bangladesh.1 > /tmp/bangladesh.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/bangladesh.2 > /tmp/bangladesh.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/bangladesh.3 > /tmp/bangladesh.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/bangladesh.4 > /tmp/bangladesh.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/bangladesh.5 > /tmp/bangladesh.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/bangladesh.6 > /tmp/bangladesh.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/bangladesh.7 > /tmp/bangladesh.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/bangladesh.8 > /tmp/userbouquet.bangladesh.tv
		cp /tmp/userbouquet.bangladesh.tv /etc/enigma2/userbouquet.bangladesh.tv > /dev/null
		rm /tmp/bangladesh.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.bangladesh.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.bangladesh.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.bangladesh.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi



