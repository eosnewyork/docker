#!/bin/bash

if [ "$#" -ne "2" ]; then
    echo "Need to pass bos and ubuntu versions"
    echo "example: ./build_contracts.sh 2.0.3 18.04"
    exit 1
fi

cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ubuntu_version=${2}
version=${1}
docker_prefix=eosnewyork

docker build \
       --build-arg builder_tag=${ubuntu_version} \
       --build-arg version=v${version} \
       --tag ${docker_prefix}/bos:${version}_${ubuntu_version} \
       ${cwd}

if [ "${?}" -ne "0" ]; then
    echo "Build failed!"
    exit 1
fi


# run docker image and copy build files locally
docker run \
       -v ${cwd}:/mnt/build \
       -it ${docker_prefix}/bos:${version}_${ubuntu_version} \
       /bin/bash -c "ls /bos/build/packages && cp /bos/build/packages/eosio_${version}-1_amd64.deb /mnt/build/"
       #"ls /eos/build/package && cp /eos/build/package/eosio_${version}-1_amd64.deb /mnt/build/"
