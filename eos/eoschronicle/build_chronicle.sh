#!/bin/bash

if [ "$#" -ne "1" ]; then
    echo "Need to pass version"
    echo "example: ./build_contracts.sh 1.0"
    exit 1
fi
cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

version=${1}
if [ "${version}" != "master" ]; then
    version_prefix="v"
fi
docker_prefix=eosnewyork

docker build \
       --build-arg version=${version_prefix}${version} \
       --tag ${docker_prefix}/eos-chronicle:${version} \
       ${cwd}

# run docker image and copy build files locally
