#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating FilmOn IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

#filmon  Convert
#rm /tmp/filmon.* > /dev/null
#rm /tmp/userbouquet.filmon.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/filmon.m3u -O /tmp/filmon.m3u > /dev/null
if [ -f /tmp/filmon.m3u ] ; 
	then
		sed "1,1d" /tmp/filmon.m3u > /tmp/filmon.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/filmon.0 > /tmp/filmon.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/filmon.00 > /tmp/filmon.000
		echo '#NAME IPTV Filmon by Nobody28 (TV)' > /tmp/filmon.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Filmon Kanaele' >> /tmp/filmon.1
		echo '#DESCRIPTION --- Filmon by Nobody28 ---' >> /tmp/filmon.1
		cat /tmp/filmon.000 >> /tmp/filmon.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/filmon.1 > /tmp/filmon.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/filmon.2 > /tmp/filmon.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/filmon.3 > /tmp/filmon.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/filmon.4 > /tmp/filmon.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/filmon.5 > /tmp/filmon.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/filmon.6 > /tmp/filmon.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/filmon.7 > /tmp/filmon.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/filmon.8 > /tmp/userbouquet.filmon.tv
		cp /tmp/userbouquet.filmon.tv /etc/enigma2/userbouquet.filmon.tv > /dev/null
		rm /tmp/filmon.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.filmon.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.filmon.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.filmon.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
