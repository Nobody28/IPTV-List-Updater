#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Music IPTV Bouquets'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# muzik Convert
#rm /tmp/muzik.* > /dev/null
#rm /tmp/userbouquet.muzik.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/muzik.m3u -O /tmp/muzik.m3u > /dev/null
if [ -f /tmp/muzik.m3u ] ; 
	then
		sed "1,1d" /tmp/muzik.m3u > /tmp/muzik.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/muzik.0 > /tmp/muzik.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/muzik.00 > /tmp/muzik.000
		echo '#NAME IPTV Musik by Nobody28 (TV)' > /tmp/muzik.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Musik Kanaele' >> /tmp/muzik.1
		echo '#DESCRIPTION --- Musik by Nobody28 ---' >> /tmp/muzik.1
		cat /tmp/muzik.000 >> /tmp/muzik.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/muzik.1 > /tmp/muzik.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/muzik.2 > /tmp/muzik.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/muzik.3 > /tmp/muzik.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/muzik.4 > /tmp/muzik.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/muzik.5 > /tmp/muzik.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/muzik.6 > /tmp/muzik.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/muzik.7 > /tmp/muzik.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/muzik.8 > /tmp/userbouquet.muzik.tv
		cp /tmp/userbouquet.muzik.tv /etc/enigma2/userbouquet.muzik.tv > /dev/null
		rm /tmp/muzik.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.muzik.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.muzik.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.muzik.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
