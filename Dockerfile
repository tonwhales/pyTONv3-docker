FROM ubuntu:20.04

# ENV DEBIAN_FRONTEND=noninteractive 
# RUN apt-get update && \
#     apt-get install -y \
#     wget git python3 python3-pip build-essential make cmake clang \
#     libgflags-dev zlib1g-dev libssl-dev libreadline-dev libmicrohttpd-dev pkg-config libgsl-dev
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
RUN apt-get update && \
    apt-get install -y \
    wget git python3 python3-pip \
    build-essential make cmake clang \
    libgflags-dev zlib1g-dev libssl-dev libreadline-dev libmicrohttpd-dev pkg-config libgsl-dev

RUN python3 -m pip install tvm_valuetypes aiohttp aiocache psutil crc16 requests ujson

# TON
WORKDIR /usr/src
RUN git clone --recursive https://github.com/tonwhales/ton-distrib.git ton
COPY tonlib.patch /usr/src/ton/
WORKDIR /usr/src/ton
RUN git apply /usr/src/ton/tonlib.patch
WORKDIR /usr/src
RUN mkdir build
WORKDIR /usr/src/build
RUN CC=$(which clang) && CXX=$(which clang++) && CCACHE_DISABLE=1 && CFLAGS=-Wno-error && cmake -DCMAKE_BUILD_TYPE=Release ../ton
RUN make -j 4 tonlibjson
	
# API
EXPOSE 8080
WORKDIR /usr/src/pytonv3
ENV GETMETHODS false
ENV TON_CONFIG /usr/src/pytonv3/config.json

# Milticlient branch
RUN git clone https://github.com/EmelyanenkoK/pytonv3.git /usr/src/pytonv3 && git checkout 84e2e5ec4b521146c83b5a5810899155250d4b6f

# Add config
ADD config.json .

CMD python3 -m pyTON --cdll /usr/src/build/tonlib/libtonlibjson.so --port 8080 --getmethods ${GETMETHODS} --liteserverconfig ${TON_CONFIG} 