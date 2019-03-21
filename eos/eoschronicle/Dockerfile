
ARG builder_tag
FROM ubuntu:18.10

ARG version

RUN apt update \
    && apt install -y git g++ cmake libboost-dev libboost-thread-dev libboost-test-dev libboost-filesystem-dev libboost-date-time-dev libboost-system-dev libboost-iostreams-dev libboost-program-options-dev libboost-locale-dev libssl-dev libgmp-dev pkg-config libzmq5-dev 

# get eos-chronicle
RUN git clone https://github.com/EOSChronicleProject/eos-chronicle \
    && cd eos-chronicle \
    && git submodule update --init --recursive \
    && git checkout ${version} \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make

RUN ln -s /eos-chronicle/build/chronicle-receiver /usr/bin/