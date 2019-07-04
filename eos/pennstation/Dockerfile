ARG contract_version
FROM eosnewyork/${contract_version}

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl ca-certificates vim psmisc python3-pip vim iputils-ping iproute2 wget\
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install numpy

RUN mkdir /mnt/tools/ \
    && cd /mnt/tools/ \
    && git clone https://github.com/warrick-eosny/websocketd.git \
    && cd websocketd/ \
    && make
