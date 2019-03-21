#!/bin/bash

if [ "$#" -ne "1" ]; then
    echo "Need to pass ubuntu version"
    echo "example: ./build_contracts.sh 1.6.2 18.04"
    exit 1
fi

ubuntu_version=${1}
docker_prefix=eosnewyork

docker build \
       --build-arg ubuntu_version=${ubuntu_version} \
       --tag ${docker_prefix}/eosbuilder:${ubuntu_version} \
       .
