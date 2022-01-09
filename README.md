# pyTONv3-docker

Reliable docker image for TON blockchain API.

# How to use

To start with default lite servers:
`docker run -p 8080:8080 tonwhales/ton-http-api:v2`

To start with custom config (custom lite servers):

First generate config in `mytonctl`: `installer` -> `plsc`. It generates `/usr/bin/ton/local.config.json` with all required settings.

`docker run -p 8080:8080 -v "/usr/bin/ton/local.config.json:/usr/src/pytonv3/config.json:ro" tonwhales/ton-http-api:v2`

# License 
MIT