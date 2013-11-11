#!/bin/sh
# created by Nobody28
#
clear
echo '############################'
echo '#     Proxy Autostarter    #'
echo '#        by Nobody28       #'
echo '############################'
echo $LINE 
echo 'Install Autostart UDP-Proxy'
echo $LINE
echo 'Please Wait'
echo $LINE
if [ -f /etc/udpxy ]; 
    then
        echo "Proxy exists!"
		echo "Nothing to do!"
		echo $LINE
    else 
        echo "Proxy installing and starting!"
		cp /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/udpxy /etc/udpxy
        chmod 755 /etc/udpxy
        cd /etc/rc3.d
        ln -s /etc/udpxy S99udpxy
        echo $LINE
		echo  'Proxy installed'
fi
ps -e > /tmp/ps.txt
if grep -qs 'udpxy' cat /tmp/ps.txt  ; 
	then
		echo "active UDP-Proxy found"
		echo "Nothing to do!"
	else
		echo "no active UDP-Proxy found"
		echo "starting UDP-Proxy"
		cd /usr/bin/
		./udpxy -p 4050 &
fi
sleep 10