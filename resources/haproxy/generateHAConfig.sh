#/bin/bash

function restart {
	echo Restarting Config generator...
	kill -9 $(ps x|grep "generateHAConfig.sh"|grep -v grep |sed 's/^ *//'|cut -f1 -d\ )
	nohup /./generateHAConfig.sh & 

}

trap 'restart' 0 1 2 3 4 5 6 15

while true
do
	/getHaConfig.sh $MARATHON_HOST > /tmp/ha.cfg

	new_cfg=$(md5sum /tmp/ha.cfg|cut -f1 -d' ')
	old_cfg=$(md5sum /etc/haproxy/haproxy.cfg|cut -f1 -d' ')

	if [[ $new_cfg != $old_cfg ]]
	then 
		mv /tmp/ha.cfg /etc/haproxy/haproxy.cfg
		service haproxy reload
	fi
	sleep 30
done
