#!/bin/bash

if [ "$#" -ne "1" ]; then
    echo "Need to pass version"
    echo "example: ./build_contracts.sh 1.0"
    exit 1
fi

version=${1}
docker_prefix=eosnewyork

docker build \
       --build-arg version=v${version} \
       --tag ${docker_prefix}/eos-chronicle:${version} \
       .

# run docker image and copy build files locally
