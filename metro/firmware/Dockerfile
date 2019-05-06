FROM ubuntu:18.04

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
    python python-setuptools python-pip build-essential wget

RUN pip install IntelHex

RUN wget --quiet https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2

RUN tar -xjvf gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2

ENV PATH=$PATH:/gcc-arm-none-eabi-8-2018-q4-major-linux/bin

RUN apt install -y git \
    && git clone https://github.com/eosnewyork/gecko_sdk_suite

ENV GECKO_SDK=/gecko_sdk_suite/gecko_sdk_suite/v2.4/