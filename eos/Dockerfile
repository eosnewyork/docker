
ARG builder_tag
FROM eosnewyork/${builder_tag}

ARG symbol=EOS
ARG version
ARG github_url=https://github.com/EOSIO/eos.git

# build eosio
RUN git clone $github_url --recursive \
    && cd eos \
    && git checkout ${version} \
    && git submodule update --init --recursive \
    && ./eosio_build.sh -s $symbol -o Release
   
RUN  cd eos \
     && cmake --build ./build --target install \
     && cd build/packages \
     && ls . \
     && bash generate_package.sh deb


ENV EOSIO_ROOT=/opt/eosio
ENV LD_LIBRARY_PATH /usr/local/eosio/lib
VOLUME /opt/eosio/bin/data-dir
ENV PATH /usr/local/eosio/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin