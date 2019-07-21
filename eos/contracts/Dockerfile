ARG cdt_version
FROM eosnewyork/${cdt_version}

ARG version
ARG boost_location

ENV BOOST_ROOT ${boost_location}
# build eosio.contracts
RUN git clone https://github.com/eosio/eosio.contracts \
    && cd eosio.contracts \
    && git checkout ${version} \
    && BOOST_ROOT=${boost_location} ./build.sh -y

# build eosio.assert
RUN git clone https://github.com/eosio/eosio.assert \
    && cd eosio.assert \
    && ./build.sh
