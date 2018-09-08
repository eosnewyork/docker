ARG symbol=EOS
ARG version
ARG builder_tag
FROM ${builder_tag}

# build eosio
RUN git clone https://github.com/EOSIO/eos.git --recursive \
    && cd eos \
    && git checkout ${version} \
    && git submodule update --init --recursive \
    && cmake -H. -B"/opt/eosio" -DCMAKE_BUILD_TYPE=Release -DWASM_ROOT=/opt/wasm -DCMAKE_CXX_COMPILER=clang++ \
       -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=/opt/eosio  -DSecp256k1_ROOT_DIR=/usr/local -DBUILD_MONGO_DB_PLUGIN=true -DCORE_SYMBOL_NAME=$symbol \
    && cd build \
    && cpack

ENV EOSIO_ROOT=/opt/eosio
ENV LD_LIBRARY_PATH /usr/local/lib
VOLUME /opt/eosio/bin/data-dir
ENV PATH /opt/eosio/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin