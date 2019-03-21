ARG ubuntu_version

FROM ubuntu:$ubuntu_version

ARG JOBS=4

ENV HOME=/root
ENV SRC_LOCATION=$HOME/src
ENV OPT_LOCATION=$HOME/opt
ENV VAR_LOCATION=$HOME/var
ENV ETC_LOCATION=$HOME/etc
ENV BIN_LOCATION=$HOME/bin
ENV DATA_LOCATION=$HOME/data
ENV CMAKE_VERSION_MAJOR=3
ENV CMAKE_VERSION_MINOR=13
ENV CMAKE_VERSION_PATCH=2
ENV CMAKE_VERSION=${CMAKE_VERSION_MAJOR}.${CMAKE_VERSION_MINOR}.${CMAKE_VERSION_PATCH}
ENV MONGODB_VERSION=4.0.6
ENV MONGODB_ROOT=${OPT_LOCATION}/mongodb-${MONGODB_VERSION}
ENV MONGODB_CONF=${ETC_LOCATION}/mongod.conf
ENV MONGODB_LOG_LOCATION=${VAR_LOCATION}/log/mongodb
ENV MONGODB_LINK_LOCATION=${OPT_LOCATION}/mongodb
ENV MONGODB_DATA_LOCATION=${DATA_LOCATION}/mongodb
ENV MONGO_C_DRIVER_VERSION=1.13.0
ENV MONGO_C_DRIVER_ROOT=${SRC_LOCATION}/mongo-c-driver-${MONGO_C_DRIVER_VERSION}
ENV MONGO_CXX_DRIVER_VERSION=3.4.0
ENV MONGO_CXX_DRIVER_ROOT=${SRC_LOCATION}/mongo-cxx-driver-r${MONGO_CXX_DRIVER_VERSION}
ENV BOOST_VERSION_MAJOR=1
ENV BOOST_VERSION_MINOR=67
ENV BOOST_VERSION_PATCH=0
ENV BOOST_VERSION=${BOOST_VERSION_MAJOR}_${BOOST_VERSION_MINOR}_${BOOST_VERSION_PATCH}
ENV BOOST_ROOT=${SRC_LOCATION}/boost_${BOOST_VERSION}
ENV BOOST_LINK_LOCATION=${OPT_LOCATION}/boost
ENV LLVM_VERSION=release_40
ENV LLVM_ROOT=${OPT_LOCATION}/llvm
ENV LLVM_DIR=${LLVM_ROOT}/lib/cmake/llvm
ENV DOXYGEN_VERSION=1_8_14
ENV DOXYGEN_ROOT=${SRC_LOCATION}/doxygen-${DOXYGEN_VERSION}
ENV TINI_VERSION=0.18.0

RUN mkdir /root/opt \
    && mkdir /root/etc \
    && mkdir /root/src

# build dependenciesOB
RUN cat /etc/issue \
  && echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
  && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo wget curl net-tools ca-certificates unzip gnupg doxygen

RUN echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main" >> /etc/apt/sources.list.d/llvm.list \
  && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y git llvm-4.0 clang-4.0 libclang-4.0-dev make automake libbz2-dev libssl-dev doxygen graphviz \
     libgmp3-dev autotools-dev build-essential libicu-dev python2.7 python2.7-dev python3 python3-dev \
     autoconf libtool curl zlib1g-dev sudo ruby libusb-1.0-0-dev libcurl4-gnutls-dev pkg-config \
  && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-4.0/bin/clang 400 \
  && update-alternatives --install /usr/bin/clang++ clang++ /usr/lib/llvm-4.0/bin/clang++ 400

RUN wget https://cmake.org/files/v3.9/cmake-3.9.6-Linux-x86_64.sh \
    && bash cmake-3.9.6-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir --skip-license \
    && rm cmake-3.9.6-Linux-x86_64.sh

ENV CC clang
ENV CXX clang++

RUN cd ${SRC_LOCATION} \
    && curl -LO https://dl.bintray.com/boostorg/release/${BOOST_VERSION_MAJOR}.${BOOST_VERSION_MINOR}.${BOOST_VERSION_PATCH}/source/boost_$BOOST_VERSION.tar.bz2 \
    && tar -xjf boost_$BOOST_VERSION.tar.bz2 \
    && echo "src ${BOOST_ROOT}" \
    && cd $BOOST_ROOT \
    && ./bootstrap.sh --prefix=$BOOST_ROOT \
    && ./b2 -q -j"${JOBS}" install \
    && cd .. \
    && rm -f boost_$BOOST_VERSION.tar.bz2 \
    && rm -rf $BOOST_LINK_LOCATION \
    && ln -s $BOOST_ROOT $BOOST_LINK_LOCATION \
    || exit 1

#RUN git clone --depth 1 --single-branch --branch release_40 https://github.com/llvm-mirror/llvm.git \
#    && git clone --depth 1 --single-branch --branch release_40 https://github.com/llvm-mirror/clang.git llvm/tools/clang \
#    && cd llvm \
#    && cmake -H. -Bbuild -GNinja -DCMAKE_INSTALL_PREFIX=/opt/wasm -DLLVM_TARGETS_TO_BUILD= -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly -DCMAKE_BUILD_TYPE=Release  \
#    && cmake --build build --target install \
#    && cd .. && rm -rf llvm
RUN ln -s /usr/lib/llvm-4.0 $LLVM_ROOT

#RUN wget https://github.com/WebAssembly/binaryen/archive/1.37.21.tar.gz -O - | tar -xz \
#    && cd binaryen-1.37.21 \
#    && cmake -H. -Bbuild -GNinja -DCMAKE_BUILD_TYPE=Release \
#    && cmake --build build --target install \
#    && cd .. && rm -rf binaryen-1.37.21

#RUN git clone --depth 1 https://github.com/cryptonomex/secp256k1-zkp \
#    && cd secp256k1-zkp \
#    && ./autogen.sh \
#    && ./configure --prefix=/usr/local \
#    && make -j$(nproc) install \
#    && cd .. && rm -rf secp256k1-zkp

#RUN git clone --depth 1 -b releases/v3.3 https://github.com/mongodb/mongo-cxx-driver \
#    && cd mongo-cxx-driver/build \
#    && cmake -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local .. \
#    && make -j$(nproc) \
#    && make install \
#    && cd ../../ && rm -rf mongo-cxx-driver

#RUN git clone --depth 1 --single-branch --branch master https://github.com/ucb-bar/berkeley-softfloat-3.git \
#    && cd berkeley-softfloat-3/build/Linux-x86_64-GCC \
#    && make -j${nproc} SPECIALIZE_TYPE="8086-SSE" SOFTFLOAT_OPS="-DSOFTFLOAT_ROUND_EVEN -DINLINE_LEVEL=5 -DSOFTFLOAT_FAST_DIV32TO16 -DSOFTFLOAT_FAST_DIV64TO32" \
#    && mkdir -p /opt/berkeley-softfloat-3 && cp softfloat.a /opt/berkeley-softfloat-3/libsoftfloat.a \
#    && mv ../../source/include /opt/berkeley-softfloat-3/include && cd - && rm -rf berkeley-softfloat-3

ENV SOFTFLOAT_ROOT /opt/berkeley-softfloat-3
