##!/bin/sh
# 18.03.2014 testi: added
# 09.04.2014 szudena: fix Player URL
# 25.04.2014 nobody28: fix Bouquetname for Ver. 1.60
# 26.04.2014 nobody28: remove teledunet.cks
# 10.05.2014 testi: fix ID0
# 16.05.2014 testi/szudena: changes id0 to the old format
#Get time_player
#
curl -c "teledunet.cks" "http://www.teledunet.com" > /dev/null 2>&1
id0=`curl -A "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14" -b "teledunet.cks" -e "http://www.teledunet.com" "http://www.teledunet.com/mobile/?con" 2>/dev/null | grep 'var aut='`
id0=`echo $id0 | sed -e "s/var aut='?id0=//g" | sed -e "s/';//g" | sed -e "s/\n//g" | sed -e "s/\.//g" | sed -e "s/E+13/00/g"`
echo $id0
#
#now let`s update the id0 in the channellist
#
if [ -f /etc/enigma2/userbouquet.teledunet.tv ]
	then
	sed -i "s/id0=[0-9]\{14\}\n/id0="$id0/g /etc/enigma2/userbouquet.teledunet.tv
fi
if [ -f /etc/enigma2/userbouquet.ilu_teledunet.tv ]
	then
	sed -i "s/id0=[0-9]\{14\}\n/id0="$id0/g /etc/enigma2/userbouquet.ilu_teledunet.tv
fi
#
#now reload servicelist
wget -q -O - http://127.0.0.1/web/servicelistreload?mode=2 > /dev/null 2>&1
echo "id0 updated "
#
rm -f teledunet.cks
exit 0  
