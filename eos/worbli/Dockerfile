
ARG builder_tag
FROM eosnewyork/eosbuilder:${builder_tag}

ARG symbol=EOS
ARG git_tag
ARG github_url=https://github.com/worbli/worbli.git

# build eosio
RUN git clone $github_url --recursive \
    && cd worbli \
    && time git checkout worbli-${git_tag} \
    && git submodule update --init --recursive \
    && ./eosio_build.sh -s $symbol -o Release -y || ./scripts/eosio_build.sh -s $symbol -o Release -y -f -P
   
RUN  cd worbli \
     && cmake --build ./build --target install \
     && cd build/packages \
     && ls . \
     && bash generate_package.sh deb


ENV EOSIO_ROOT=/opt/eosio
ENV LD_LIBRARY_PATH /usr/local/eosio/lib
VOLUME /opt/eosio/bin/data-dir
ENV PATH /usr/local/eosio/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin