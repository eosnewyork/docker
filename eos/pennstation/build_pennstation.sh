#!/bin/bash

if [ "$#" -ne "1" ]; then
    echo "Need to pass contract"
    echo "version format: <eos.contracts>_<eos.cdt>_<eos>_<ubuntu>"
    echo "example: ./build_contracts.sh 1.5.2_1.5.0_1.6.2_18.04"
    exit 1
fi

contract_version=${1}
docker_prefix=eosnewyork

docker build \
       --build-arg contract_version=eos.contracts:${contract_version} \
       --tag ${docker_prefix}/pennstation:${contract_version} \
       .

# run docker image and copy build files locally
