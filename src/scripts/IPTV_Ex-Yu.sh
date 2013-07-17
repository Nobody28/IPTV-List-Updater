#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Ex-Yu IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# ex-yug  Convert
#rm /tmp/ex-yug.* > /dev/null
#rm /tmp/userbouquet.ex-yug.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/ex-yug.m3u -O /tmp/ex-yug.m3u > /dev/null
if [ -f /tmp/ex-yug.m3u ] ; 
	then
		sed "1,1d" /tmp/ex-yug.m3u > /tmp/ex-yug.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/ex-yug.0 > /tmp/ex-yug.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/ex-yug.00 > /tmp/ex-yug.000
		echo '#NAME IPTV Ex Yugoslavien by Nobody28 (TV)' > /tmp/ex-yug.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Ex Yugoslavien Kanaele' >> /tmp/ex-yug.1
		echo '#DESCRIPTION --- Ex Yugoslavien by Nobody28 ---' >> /tmp/ex-yug.1
		cat /tmp/ex-yug.000 >> /tmp/ex-yug.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/ex-yug.1 > /tmp/ex-yug.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/ex-yug.2 > /tmp/ex-yug.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/ex-yug.3 > /tmp/ex-yug.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/ex-yug.4 > /tmp/ex-yug.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/ex-yug.5 > /tmp/ex-yug.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/ex-yug.6 > /tmp/ex-yug.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/ex-yug.7 > /tmp/ex-yug.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/ex-yug.8 > /tmp/userbouquet.ex-yug.tv
		cp /tmp/userbouquet.ex-yug.tv /etc/enigma2/userbouquet.ex-yug.tv > /dev/null
		rm /tmp/ex-yug.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.ex-yug.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.ex-yug.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.ex-yug.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
