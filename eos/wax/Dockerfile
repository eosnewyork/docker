ARG ubuntu_version
#ARG builder_tag
#FROM eosnewyork/eosbuilder:${builder_tag}
FROM ubuntu:$ubuntu_version

ARG symbol=WAX
ARG version
ARG github_url=https://github.com/worldwide-asset-exchange/wax-blockchain.git

ENV HOME=/root

RUN apt update \
    && apt install -y git pkg-config libzmq5-dev curl sudo cmake jq

# build eosio
RUN git clone ${github_url} --recursive \
    && cd wax-blockchain \
    && git checkout wax-${version} \
    && git submodule update --init --recursive \
    && ./scripts/eosio_build.sh -s $symbol -o Release -y -P -f

RUN  cd wax-blockchain \
    && export VERBOSE=1 \ 
    && cd build/ \
    && make install \
    && cd packages \
    && ls . \
    && bash generate_package.sh deb \
    && dpkg -i *deb


ENV EOSIO_ROOT=/opt/eosio
ENV LD_LIBRARY_PATH /usr/local/eosio/lib
VOLUME /opt/eosio/bin/data-dir
ENV PATH /usr/local/eosio/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
