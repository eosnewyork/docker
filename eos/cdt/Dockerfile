ARG eos_tag
FROM ${eos_tag}

ARG symbol=EOS
ARG version

# build eosio
RUN git clone https://github.com/eosio/eosio.cdt --recursive \
    && cd eosio.cdt \
    && git checkout ${version} \
    && git submodule update --init --recursive \
    && cmake \
    &&  cmake --build /opt/eosio --target install \
    && echo finish

