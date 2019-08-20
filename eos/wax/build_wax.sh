#!/bin/bash

if [ "$#" -ne "3" ]; then
    echo "Need to pass wax major version, wax minor version, and ubuntu"
    echo "example: ./build_contracts.sh 1.8.1 1.0.0 18.04"
    exit 1
fi

cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ubuntu_version=${3}
minor_version=${2}
major_version=${1}
version=${major_version}-${minor_version}
docker_prefix=eosnewyork
docker_repo=wax

docker build \
       --build-arg ubuntu_version=${ubuntu_version} \
       --build-arg version=${version} \
       --tag ${docker_prefix}/${docker_repo}:${version}_${ubuntu_version} \
       ${cwd}

if [ "${?}" -ne "0" ]; then
    echo "Build failed!"
    exit 1
fi


# run docker image and copy build files locally
docker run \
       -v ${cwd}:/mnt/build \
       -it ${docker_prefix}/${docker_repo}:${version}_${ubuntu_version} \
       /bin/bash -c "ls /wax-blockchain/build/packages && cp /wax-blockchain/build/packages/eosio_${major_version}*_amd64.deb /mnt/build/"
       #"ls /eos/build/package && cp /eos/build/package/eosio_${version}-1_amd64.deb /mnt/build/"
