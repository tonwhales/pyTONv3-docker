FROM ubuntu:20.04

# ENV DEBIAN_FRONTEND=noninteractive 
# RUN apt-get update && \
#     apt-get install -y \
#     wget git python3 python3-pip build-essential make cmake clang \
#     libgflags-dev zlib1g-dev libssl-dev libreadline-dev libmicrohttpd-dev pkg-config libgsl-dev

RUN apt-get update && \
    apt-get install -y \
    wget git python3 python3-pip

RUN python3 -m pip install tvm_valuetypes aiohttp aiocache psutil crc16 requests ujson

# TON
# WORKDIR /usr/src
# RUN git clone --recursive https://github.com/newton-blockchain/ton.git
# RUN CC=$(which clang) && CXX=$(which clang++) && CCACHE_DISABLE=1 && cmake -DCMAKE_BUILD_TYPE=Release /usr/src/ton
# RUN make -j 4 fift validator-engine lite-client pow-miner validator-engine-console generate-random-id dht-server
	
# API
EXPOSE 8080
WORKDIR /usr/src/pytonv3
ENV GETMETHODS false
ENV TON_CONFIG /usr/src/pytonv3/config.json

# Milticlient branch
RUN git clone https://github.com/EmelyanenkoK/pytonv3.git /usr/src/pytonv3 && git checkout 84e2e5ec4b521146c83b5a5810899155250d4b6f

CMD python3 -m pyTON --port 8080 --getmethods ${GETMETHODS} --liteserverconfig ${TON_CONFIG}