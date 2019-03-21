#!/bin/bash

if [ "$#" -ne "2" ]; then
    echo "Need to pass eos and ubuntu"
    echo "example: ./build_contracts.sh 1.6.2 18.04"
    exit 1
fi

ubuntu_version=${2}
version=${1}
docker_prefix=eosnewyork

docker build \
       --build-arg ubuntu_version=${ubuntu_version} \
       --build-arg version=v${version} \
       --tag ${docker_prefix}/eos:${version}_${ubuntu_version} \
       .

# run docker image and copy build files locally
docker run \
       -v `pwd`:/mnt/build \
       -it ${docker_prefix}/eos:${version}_${ubuntu_version} \
       /bin/bash -c "ls /eos/build/packages && cp /eos/build/packages/eosio_${version}-1_amd64.deb /mnt/build/"
       #"ls /eos/build/package && cp /eos/build/package/eosio_${version}-1_amd64.deb /mnt/build/"
