FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y wget git python3 python3-pip

RUN python3 -m pip install tvm_valuetypes aiohttp aiocache

EXPOSE 8080

WORKDIR /usr/src/pytonv3

ENV GETMETHODS false
ENV TON_CONFIG config.json

RUN git clone -b multiclient https://github.com/EmelyanenkoK/pytonv3.git /usr/src/pytonv3

RUN cd /usr/src/pytonv3 && ls

CMD python3 -m pyTON --port 8080 --getmethods ${GETMETHODS} --liteserverconfig ${TON_CONFIG}