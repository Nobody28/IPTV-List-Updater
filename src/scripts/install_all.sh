#!/bin/sh
# created by Nobody28 & satinfo
#
# www.gigablue-support.com
# www.opena.tv
cat /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts/begin.txt
echo $LINE 
echo 'Updating ALL IPTV Bouquet'
echo $LINE
echo 'FIRST STEP UPDATE BOUQUETS AND SERVICES'
echo 'Updating Services'
echo 'Please Wait'
echo $LINE

cd /usr/lib/enigma2/python/Plugins/Extensions/IPTV-List-Updater/scripts
ls | grep IPTV_ > Update_all.sh
cat Update_all.sh | grep .sh > Update_all1.sh
rm Update_all.sh
sed 's/IPTV_/.\/IPTV_/' Update_all1.sh > Update_all.sh
chmod 755 Update_all.sh
./Update_all.sh
rm Update_all.sh
rm Update_all1.sh
