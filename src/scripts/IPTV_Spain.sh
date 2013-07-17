#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Spain IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# ispanya Convert
#rm /tmp/ispanya.* > /dev/null
#rm /tmp/userbouquet.ispanya.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/ispanya.m3u -O /tmp/ispanya.m3u > /dev/null
if [ -f /tmp/ispanya.m3u ] ; 
	then
		sed "1,1d" /tmp/ispanya.m3u > /tmp/ispanya.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/ispanya.0 > /tmp/ispanya.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/ispanya.00 > /tmp/ispanya.000
		echo '#NAME IPTV Spanisch by Nobody28 (TV)' > /tmp/ispanya.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Spanische Kanäle' >> /tmp/ispanya.1
		echo '#DESCRIPTION --- Spanien by Nobody28 ---' >> /tmp/ispanya.1
		cat /tmp/ispanya.000 >> /tmp/ispanya.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/ispanya.1 > /tmp/ispanya.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/ispanya.2 > /tmp/ispanya.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/ispanya.3 > /tmp/ispanya.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/ispanya.4 > /tmp/ispanya.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/ispanya.5 > /tmp/ispanya.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/ispanya.6 > /tmp/ispanya.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/ispanya.7 > /tmp/ispanya.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/ispanya.8 > /tmp/userbouquet.ispanya.tv
		cp /tmp/userbouquet.ispanya.tv /etc/enigma2/userbouquet.ispanya.tv > /dev/null
		rm /tmp/ispanya.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.ispanya.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.ispanya.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.ispanya.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
