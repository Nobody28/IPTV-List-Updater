#!/bin/sh
# created by Nobody28
#
clear
echo '####################################'
echo '#     Teledunet Auto ID Updater    #'
echo '#             by Nobody28          #'
echo '####################################'
echo $LINE 
# echo 'Install Auto ID Updater every 24h'
echo $LINE
echo 'Please Wait'
echo $LINE

if grep -qs 'Teledunet_id_update' cat /etc/cron/root  ; 
	then
# 		echo "Cron for Updatescript found"
# 		echo "Nothing to install!"
		echo $LINE
		echo "Update Id0 !"
		cd /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts
		./Teledunet_id_update.sh
	else
# 		echo "Install Updatescript!"
# 		echo "*/5 * * * * 	/usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/Teledunet_id_update.sh silent" >> /etc/cron/root
# 		cd /etc/init.d
# 		./busybox-cron start
		echo $LINE
		echo "Start Updatescript!"
		cd /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts
		./Teledunet_id_update.sh
fi

sleep 10