#!/bin/bash
cd /usr/bin
#Get time_player

id0=`./wget --header="Referer: http://www.teledunet.com" -O "/tmp/t.html" "http://www.teledunet.com/tv/?channel=teledunet&no_pub" > /dev/null 2>&1`
id0=`sed -n '/^time_player/{s/^time_player=\([0-9.+E]\+\);.*$/\1/p;q}' < '/tmp/t.html' | sed -e 's/E+13//g' | sed -e 's/\.//g'`

id0=`printf "%13.0f" ${id0}'00' `

echo $id0

#now let`s update the id0 in the channellist

sed -i 's/id0=[0-9]\{14\}/id0='$id0/g /etc/enigma2/userbouquet.teledunet.tv

#now reload servicelist
./wget -q -O - http://127.0.0.1/web/servicelistreload?mode=2 > /dev/null 2>&1
echo "id0 updated "

date >> /tmp/CRON-DATEI.log

exit 0
