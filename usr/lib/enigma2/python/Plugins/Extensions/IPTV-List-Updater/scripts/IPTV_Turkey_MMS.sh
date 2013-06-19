#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Turkey MMS IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# turk_mms Convert
#rm /tmp/turk_mms.* > /dev/null
#rm /tmp/userbouquet.turk_mms.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/turk_mms.m3u -O /tmp/turk_mms.m3u > /dev/null
if [ -f /tmp/turk_mms.m3u ] ; 
	then
		sed "1,1d" /tmp/turk_mms.m3u > /tmp/turk_mms.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/turk_mms.0 > /tmp/turk_mms.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/turk_mms.00 > /tmp/turk_mms.000
		echo '#NAME IPTV Türkische mms by Nobody28 (TV)' > /tmp/turk_mms.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::Türkische mms Kanäle' >> /tmp/turk_mms.1
		echo '#DESCRIPTION --- Türkische mms by Nobody28 ---' >> /tmp/turk_mms.1
		cat /tmp/turk_mms.000 >> /tmp/turk_mms.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/turk_mms.1 > /tmp/turk_mms.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/turk_mms.2 > /tmp/turk_mms.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/turk_mms.3 > /tmp/turk_mms.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/turk_mms.4 > /tmp/turk_mms.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/turk_mms.5 > /tmp/turk_mms.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/turk_mms.6 > /tmp/turk_mms.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/turk_mms.7 > /tmp/turk_mms.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/turk_mms.8 > /tmp/userbouquet.turk_mms.tv
		cp /tmp/userbouquet.turk_mms.tv /etc/enigma2/userbouquet.turk_mms.tv > /dev/null
		rm /tmp/turk_mms.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.turk_mms.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.turk_mms.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.turk_mms.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi