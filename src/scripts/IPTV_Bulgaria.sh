#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Bulgaria IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# bulgar Convert
#rm /tmp/bulgar.* > /dev/null
#rm /tmp/userbouquet.bulgar.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/bulgar.m3u -O /tmp/bulgar.m3u > /dev/null
if [ -f /tmp/bulgar.m3u ] ; 
	then
		sed "1,1d" /tmp/bulgar.m3u > /tmp/bulgar.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/bulgar.0 > /tmp/bulgar.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/bulgar.00 > /tmp/bulgar.000
		echo '#NAME IPTV Bulgarien by Nobody28 (TV)' > /tmp/bulgar.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Bulgarische Kanäle' >> /tmp/bulgar.1
		echo '#DESCRIPTION --- Bulgarisch by Nobody28 ---' >> /tmp/bulgar.1
		cat /tmp/bulgar.000 >> /tmp/bulgar.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/bulgar.1 > /tmp/bulgar.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/bulgar.2 > /tmp/bulgar.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/bulgar.3 > /tmp/bulgar.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/bulgar.4 > /tmp/bulgar.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/bulgar.5 > /tmp/bulgar.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/bulgar.6 > /tmp/bulgar.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/bulgar.7 > /tmp/bulgar.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/bulgar.8 > /tmp/userbouquet.bulgar.tv
		cp /tmp/userbouquet.bulgar.tv /etc/enigma2/userbouquet.bulgar.tv > /dev/null
		rm /tmp/bulgar.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.bulgar.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.bulgar.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.bulgar.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
