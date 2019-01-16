
ARG builder_tag
FROM eosnewyork/${builder_tag}

ARG symbol=EOS
ARG git_tag
ARG version
ARG github_url=https://github.com/worbli/worbli.git

# build eosio
RUN git clone $github_url --recursive \
    && cd worbli \
    && git checkout worbli-${git_tag} \
    && git submodule update --init --recursive \
    && ./eosio_build.sh -s $symbol -o Release
   
RUN  cd worbli \
     && cmake --build ./build --target install \
     && cd build/packages \
     && ls . \
     && sed -i -e 's/'${version}'/worbli-'${version}'/g' generate_package.sh \
     && bash generate_package.sh deb


ENV EOSIO_ROOT=/opt/eosio
ENV LD_LIBRARY_PATH /usr/local/eosio/lib
VOLUME /opt/eosio/bin/data-dir
ENV PATH /usr/local/eosio/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin