#!/bin/sh
# created by Nobody28
#
clear
echo '############################'
echo '#      Update DIGIBIT      #'
echo '#        by Nobody28       #'
echo '############################'
echo $LINE 
echo 'Search Digibit'
echo $LINE
echo 'Please Wait'
echo $LINE
arp -a | grep DIGIBIT | sed 's/[\.| ][],a-z,A-Z,\.,\(,\), ,0-9,:,\[]*//' | tr -d "\n" > /tmp/digibit.txt
echo -n 'Digibit TV http://' > /tmp/digibit_new.txt
cat /tmp/digibit.txt >> /tmp/digibit_new.txt
echo -n ':8080/m3u Digibit' >> /tmp/digibit_new.txt
cat /tmp/digibit_new.txt
echo $LINE
echo $LINE
echo $LINE
sleep 5