ARG builder_tag
#ARG ubuntu_version
FROM eosnewyork/eosbuilder:${builder_tag}
#FROM ubuntu:${ubuntu_version}

ARG symbol=BOS
ARG version
ARG github_url=https://github.com/boscore/bos.git

# build eosio
RUN git clone $github_url --recursive \
    && cd bos \
    && git checkout ${version} \
    && git submodule update --init --recursive \
    && ./eosio_build.sh -s $symbol 
   
RUN  cd bos \
     && ./eosio_install.sh \
     && cd ./build/packages \
     && ls . \
     && bash generate_package.sh deb


ENV EOSIO_ROOT=/opt/eosio
ENV LD_LIBRARY_PATH /usr/local/eosio/lib
VOLUME /opt/eosio/bin/data-dir
ENV PATH /usr/local/eosio/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin