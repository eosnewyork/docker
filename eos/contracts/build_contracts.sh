#!/bin/bash
#/root/eosio/1.8/src/boost_1_70_0
if [ "$#" -ne "5" ]; then
    echo "Need to pass cdt, eos, ubuntu, and contract versions"
    echo "example: ./build_contracts.sh 1.5.0 1.6.2 18.04 1.5.2 /root/eosio/1.8/src/boost_1_70_0"
    exit 1
fi

ubuntu_version=${3}
eos_version=${2}
version=${4}
cdt_version=${1}_${eos_version}_${ubuntu_version}
boost_location=${5}
echo boost_loc=${boost_location}
docker_prefix=eosnewyork

docker build \
       --build-arg cdt_version=eos.cdt:${cdt_version} \
       --build-arg version=v${version} \
       --build-arg boost_location=${boost_location} \
       --tag ${docker_prefix}/eos.contracts:${version}_${cdt_version} \
       .
