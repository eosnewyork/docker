ARG ubuntu_version

FROM ubuntu:$ubuntu_version
ARG eos_version=1.7.0
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
ENV MONGODB_VERSION=4.1.1
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

RUN mkdir -p $SRC_LOCATION \
    && mkdir -p $OPT_LOCATION \ 
    && mkdir -p $VAR_LOCATION \
    && mkdir -p $BIN_LOCATION \
    && mkdir -p $VAR_LOCATION/log \
    && mkdir -p $ETC_LOCATION \
    && mkdir -p $MONGODB_LOG_LOCATION \
    && mkdir -p $MONGODB_DATA_LOCATION

# intall dependencies
RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
    git llvm-4.0 clang-4.0 libclang-4.0-dev make automake libbz2-dev libssl-dev doxygen graphviz libgmp3-dev autotools-dev \
    build-essential libicu-dev python2.7 python2.7-dev python3 python3-dev autoconf libtool curl zlib1g-dev sudo ruby \
    libusb-1.0-0-dev libcurl4-gnutls-dev pkg-config cmake lldb-4.0

#RUN curl -LO https://cmake.org/files/v$CMAKE_VERSION_MAJOR.$CMAKE_VERSION_MINOR/cmake-$CMAKE_VERSION.tar.gz \
#    && tar -xzf cmake-$CMAKE_VERSION.tar.gz \
#    && cd cmake-$CMAKE_VERSION \
#    && ./bootstrap --prefix=$HOME \
#    && make -j"${JOBS}" \
#    && make install \
#    && cd .. \
#    && rm -f cmake-$CMAKE_VERSION.tar.gz

RUN cd ${SRC_LOCATION} \
    && curl -LO https://dl.bintray.com/boostorg/release/${BOOST_VERSION_MAJOR}.${BOOST_VERSION_MINOR}.${BOOST_VERSION_PATCH}/source/boost_$BOOST_VERSION.tar.bz2 \
    && tar -xjf boost_$BOOST_VERSION.tar.bz2 \
    && cd $BOOST_ROOT \
    && ./bootstrap.sh --prefix=$BOOST_ROOT \
    && ./b2 -q -j"${JOBS}" install \
    && cd .. \
    && rm -f boost_$BOOST_VERSION.tar.bz2 \
    && rm -rf $BOOST_LINK_LOCATION \
    && ln -s $BOOST_ROOT $BOOST_LINK_LOCATION

# 18.04 is not supported for mongodb 3.6
# so manually set 16 for now <- this will bite me in the @$$ at some point
RUN export OS_MAJ=18 \
    && export OS_MIN=04 \
    && cd $SRC_LOCATION/ \
    && curl -OL http://downloads.mongodb.org/linux/mongodb-linux-x86_64-ubuntu$OS_MAJ$OS_MIN-$MONGODB_VERSION.tgz \
    && tar -xzf mongodb-linux-x86_64-ubuntu$OS_MAJ$OS_MIN-$MONGODB_VERSION.tgz \
    && mv $SRC_LOCATION/mongodb-linux-x86_64-ubuntu$OS_MAJ$OS_MIN-$MONGODB_VERSION $MONGODB_ROOT \
    && touch $MONGODB_LOG_LOCATION/mongod.log \
    && rm -f mongodb-linux-x86_64-ubuntu$OS_MAJ$OS_MIN-$MONGODB_VERSION.tgz \
    && mkdir -p $MONGODB_DATA_LOCATION \
    && rm -rf $MONGODB_LINK_LOCATION \
    && rm -rf $BIN_LOCATION/mongod \
    && ln -s $MONGODB_ROOT $MONGODB_LINK_LOCATION \
    && ln -s $MONGODB_LINK_LOCATION/bin/mongod $BIN_LOCATION/mongod

RUN cd ${SRC_LOCATION} \
    && curl -LO https://github.com/mongodb/mongo-c-driver/releases/download/$MONGO_C_DRIVER_VERSION/mongo-c-driver-$MONGO_C_DRIVER_VERSION.tar.gz \
    && tar -xzf mongo-c-driver-$MONGO_C_DRIVER_VERSION.tar.gz \
    && cd mongo-c-driver-$MONGO_C_DRIVER_VERSION \
    && mkdir -p cmake-build \
    && cd cmake-build \
    && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$HOME -DENABLE_BSON=ON -DENABLE_SSL=OPENSSL -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF -DENABLE_STATIC=ON .. \
    && make -j"${JOBS}" \
    && make install \
    && cd ../.. \
    && rm mongo-c-driver-$MONGO_C_DRIVER_VERSION.tar.gz

RUN cd ${SRC_LOCATION} \
    && curl -L https://github.com/mongodb/mongo-cxx-driver/archive/r$MONGO_CXX_DRIVER_VERSION.tar.gz -o mongo-cxx-driver-r$MONGO_CXX_DRIVER_VERSION.tar.gz \
    && tar -xzf mongo-cxx-driver-r${MONGO_CXX_DRIVER_VERSION}.tar.gz \
    && cd mongo-cxx-driver-r$MONGO_CXX_DRIVER_VERSION/build \
    && cmake -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$HOME .. \
    && make -j"${JOBS}" VERBOSE=1 \
    && make install \
    && cd ../.. \
    && rm -f mongo-cxx-driver-r$MONGO_CXX_DRIVER_VERSION.tar.gz

RUN ln -s /usr/lib/llvm-4.0 $LLVM_ROOT \
    && ln -s /root/lib/* /lib/ \
    && ln -s /root/include /include