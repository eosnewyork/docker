
ARG builder_tag
FROM eosnewyork/eosbuilder:${builder_tag}

ARG symbol=EOS
ARG version
ARG github_url=https://github.com/EOSIO/eos.git

ENV HOME=/root

RUN apt update \
    && apt install -y git pkg-config libzmq5-dev curl sudo cmake

# get common submodules
# get zmq
RUN git clone https://github.com/eosrio/eos_zmq_plugin

# account_snapshot_plugin
RUN git clone https://github.com/deckb/account_snapshot_plugin

ENV LOCAL_CMAKE_FLAGS="-DEOSIO_ADDITIONAL_PLUGINS=/eos_zmq_plugin -DEOSIO_ADDITIONAL_PLUGINS=/account_snapshot_plugin"
ENV CMAKE_PREFIX_PATH=/root/lib:${CMAKE_PREFIX_PATH}

# build eosio
RUN git clone ${github_url} --recursive \
    && cd eos \
    && git checkout ${version} \
    && git submodule update --init --recursive \
    && ./eosio_build.sh -s $symbol -o Release -y || ./scripts/eosio_build.sh -s $symbol -o Release -y
   
RUN  cd eos \
     && cmake --build ./build --target install \
     && cd build/packages \
     && ls . \
     && bash generate_package.sh deb


ENV EOSIO_ROOT=/opt/eosio
ENV LD_LIBRARY_PATH /usr/local/eosio/lib
VOLUME /opt/eosio/bin/data-dir
ENV PATH /usr/local/eosio/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin