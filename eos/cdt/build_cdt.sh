#!/bin/bash

if [ "$#" -ne "3" ]; then
    echo "Need to pass eosio, ubuntu, and cdt versions"
    echo "example: ./build_contracts.sh 1.6.2 18.04 1.5.0"
    exit 1
fi

ubuntu_version=${2}
eos_version=${1}_${ubuntu_version}
version=${3}
docker_prefix=eosnewyork

docker build \
       --build-arg eos_tag=eos:${eos_version} \
       --build-arg version=v${version} \
       --tag ${docker_prefix}/eos.cdt:${version}_${eos_version} \
       .
