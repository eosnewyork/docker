
ARG builder_tag
FROM ${builder_tag}

ARG symbol=EOS
ARG version
ARG as_version=1
ARG github_url=https://github.com/deckb/eos.git

# build eosio
RUN git clone $github_url --recursive \
    && cd eos \
    && git checkout v${version} \
    && git submodule update --init --recursive \
    && ./eosio_build.sh -s EOS -o Release

RUN ls -lsa \
    && cd ./eos \
    && cmake --build /opt/eosio --target install \
    && cd /opt/eosio \
    && sed -i -e 's/'${version}'/'${version}'.as'${as_version}'/g' CPackConfig.cmake CPackSourceConfig.cmake \
    && cpack

ENV EOSIO_ROOT=/opt/eosio
ENV LD_LIBRARY_PATH /usr/local/eosio/lib
VOLUME /opt/eosio/bin/data-dir
ENV PATH /usr/local/eosio/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin