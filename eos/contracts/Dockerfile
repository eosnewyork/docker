ARG cdt_version
FROM eosnewyork/${cdt_version}

ARG version
# build eosio
RUN git clone https://github.com/eosio/eosio.contracts \
    && cd eosio.contracts \
    && git checkout ${version} \
    && git submodule update --init --recursive \
    && ./build.sh -y