ARG eos_tag
FROM eosnewyork/${eos_tag}

ARG symbol=EOS
ARG version

# build eosio
RUN git clone https://github.com/eosio/eosio.cdt \
    && cd eosio.cdt \
    && git checkout v${version} \
    && git submodule update --init --recursive \
    && ./build.sh ${symbol} \
    && ./install.sh
