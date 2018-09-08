
ARG builder_tag
FROM ${builder_tag}

ARG symbol=EOS
ARG version
ARG github_url=https://github.com/EOSIO/eos.git

# build eosio
RUN git clone $github_url --recursive \
    && cd eos \
    && git checkout ${version} \
    && git submodule update --init --recursive \
    && cmake -H. -B"/opt/eosio" -DCMAKE_BUILD_TYPE=Release -DWASM_ROOT=/opt/wasm -DCMAKE_CXX_COMPILER=clang++ \
       -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=/usr/local/eosio  -DSecp256k1_ROOT_DIR=/usr/local -DBUILD_MONGO_DB_PLUGIN=true -DCORE_SYMBOL_NAME=$symbol \
    && cmake --build /opt/eosio --target install \
    && cd /opt/eosio \
    && cpack

ENV EOSIO_ROOT=/opt/eosio
ENV LD_LIBRARY_PATH /usr/local/eosio/lib
VOLUME /opt/eosio/bin/data-dir
ENV PATH /usr/local/eosio/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin