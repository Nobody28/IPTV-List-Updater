#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating Adult IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE
cd /tmp

# Adult Convert
#rm /tmp/adult.* > /dev/null
#rm /tmp/userbouquet.adult.tv > /dev/null
wget http://01.gen.tr/simple/turkvod/adult.m3u -O /tmp/adult.m3u > /dev/null
if [ -f /tmp/adult.m3u ] ; 
	then
		sed "1,1d" /tmp/adult.m3u > /tmp/adult.0
		sed 'N;s/\(.*\)\n\(.*\)/\2\n\1/' /tmp/adult.0 > /tmp/adult.00
		sed '/#EXTINF:-1,/!s/:/%3a/g' /tmp/adult.00 > /tmp/adult.000
		echo '#NAME IPTV XXX Adult by Nobody28 (TV)' > /tmp/adult.1
		echo '#SERVICE 1:64:0:0:0:0:0:0:0:0::XXX Adult Kanäle' >> /tmp/adult.1
		echo '#DESCRIPTION --- XXX Adult by Nobody28 ---' >> /tmp/adult.1
		cat /tmp/adult.000 >> /tmp/adult.1
		sed 's/#EXTINF:-1,/#DESCRIPTION: /g' /tmp/adult.1 > /tmp/adult.2
		sed 's/rtmp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmp%3a/' /tmp/adult.2 > /tmp/adult.3
		sed 's/rtmpe%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpe%3a/' /tmp/adult.3 > /tmp/adult.4
		sed 's/rtmpt%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtmpt%3a/' /tmp/adult.4 > /tmp/adult.5
		sed 's/rtsp%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rtsp%3a/' /tmp/adult.5 > /tmp/adult.6
		sed 's/mms%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mms%3a/' /tmp/adult.6 > /tmp/adult.7
		sed 's/mmsh%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:mmsh%3a/' /tmp/adult.7 > /tmp/adult.8
		sed '/#SERVICE 4097:0:1:0:0:0:0:0:0:0:rt/!s/http%3a/#SERVICE 4097:0:1:0:0:0:0:0:0:0:http%3a/' /tmp/adult.8 > /tmp/userbouquet.adult.tv
		cp /tmp/userbouquet.adult.tv /etc/enigma2/userbouquet.adult.tv > /dev/null
		rm /tmp/adult.* > /dev/null
		echo $LINE
		echo 'Download Complete'

		if grep -qs 'userbouquet.adult.tv' cat /etc/enigma2/bouquets.tv  ; then
			echo "Bouquet existiert bereits"
		else 
			echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.adult.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
		fi
		rm /tmp/userbouquet.adult.tv > /dev/null
		echo $LINE
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/end.txt
	else
		cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/download_error.txt
fi
