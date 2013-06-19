#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating England IPTV Bouquets'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# ingilizce Convert
#rm /tmp/ingilizce.* > /dev/null
#rm /tmp/userbouquet.ingilizce.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/ingilizce.m3u -O /tmp/ingilizce.m3u > /dev/null
if [ -f /tmp/ingilizce.m3u ] ; 
	then
		sed "1,1d" /tmp/ingilizce.m3u > /tmp/ingilizce.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/ingilizce.0 > /tmp/ingilizce.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/ingilizce.00 > /tmp/ingilizce.000
		echo '#NAME IPTV Englisch by Nobody28 (TV)' > /tmp/ingilizce.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Englische Kanäle' >> /tmp/ingilizce.1
		echo '#DESCRIPTION --- Englische by Nobody28 ---' >> /tmp/ingilizce.1
		cat /tmp/ingilizce.000 >> /tmp/ingilizce.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/ingilizce.1 > /tmp/ingilizce.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/ingilizce.2 > /tmp/ingilizce.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/ingilizce.3 > /tmp/ingilizce.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/ingilizce.4 > /tmp/ingilizce.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/ingilizce.5 > /tmp/ingilizce.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/ingilizce.6 > /tmp/ingilizce.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/ingilizce.7 > /tmp/ingilizce.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/ingilizce.8 > /tmp/userbouquet.ingilizce.tv
		cp /tmp/userbouquet.ingilizce.tv /etc/enigma2/userbouquet.ingilizce.tv > /dev/null
		rm /tmp/ingilizce.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.ingilizce.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.ingilizce.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.ingilizce.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
