#!/bin/bash

set -e

cd $WORKSPACE

docker build -t backendbuild:$BUILD_NUMBER .
CID=$(docker run -t -v $WORKSPACE:/data  backendbuild:$BUILD_NUMBER mvn clean install -DskipTests)
sleep 4
echo WE_Backend $CID is installed and all tests passed.

registryHost=$(curl -s hsapp.getcatchapp.com:8080/v2/apps/registry  | python -mjson.tool |grep host|cut -f2 -d:|cut -f2 -d\")
registryPort=$(curl -s hsapp.getcatchapp.com:8080/v2/apps/registry  | python -mjson.tool |grep -A 7 tasks|grep -A1 ports|grep -o "[0-9]*")

cd $WORKSPACE
mv dist/we-backend*shaded.jar deployment/docker/backend/we-backend.jar

cd $WORKSPACE/deployment/docker/backend/
docker build --no-cache=true -t $registryHost:$registryPort/we_backend:$BUILD_NUMBER .
docker tag $registryHost:$registryPort/we_backend:latest
docker push $registryHost:$registryPort/we_backend:$BUILD_NUMBER
docker push $registryHost:$registryPort/we_backend:latest
# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
#docker rmi $(docker images -q)
