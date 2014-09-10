#!/bin/sh
set -x
nohup /usr/local/bin/wrapdocker &

nohup java -jar /opt/jenkins.war  &
PID=$!
sleep 5
wait $pid
#tail -f --pid $PID ./nohup.out
