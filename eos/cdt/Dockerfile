ARG eos_tag
FROM ${eos_tag}

ARG symbol=EOS
ARG version

# build eosio
RUN git clone https://github.com/eosio/eosio.cdt \
    && git submodule update --init --recursive \
    && cd eosio.cdt \
    && ./build.sh ${symbol}
