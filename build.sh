#!/bin/bash

pushd app
mvn install
popd

docker stop $(docker ps | grep tomee-fwd | tail -n 1 | awk '{ print $1 }')
docker build -t tomee-fwd .
