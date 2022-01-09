# pyTONv3-docker

Reliable docker image for TON blockchain API.

# How to use

To start with default lite servers:
`docker run -p 8080:8080 tonwhales/ton-http-api:v2`

To start with custom config (custom lite servers):
`docker run -p 8080:8080 -v config.json:/etc/ton/config.json:ro tonwhales/ton-http-api:v2`

Where config.json is:

```json
{
        "liteservers": [
        {
            "ip": <ip>,
            "port": <port>,
            "id": {
                "@type": "pub.ed25519",
                "key": <key>
            }
        }
        ],
        "validator": {
            "@type": "validator.config.global",
            "zero_state": {
              "workchain": -1,
              "shard": -9223372036854775808,
              "seqno": 0,
              "root_hash": "F6OpKZKqvqeFp6CQmFomXNMfMj2EnaUSOXN+Mh+wVWk=",
              "file_hash": "XplPz01CXAps5qeSWUtxcyBfdAo5zVb1N979KLSKD24="
            },
            "init_block": {
              "root_hash": "irEt9whDfgaYwD+8AzBlYzrMZHhrkhSVp3PU1s4DOz4=",
              "seqno": 10171687,
              "file_hash": "lay/bUKUUFDJXU9S6gx9GACQFl+uK+zX8SqHWS9oLZc=",
              "workchain": -1,
              "shard": -9223372036854775808
            },
            "hardforks": [
              {
                "file_hash": "t/9VBPODF7Zdh4nsnA49dprO69nQNMqYL+zk5bCjV/8=",
                "seqno": 8536841,
                "root_hash": "08Kpc9XxrMKC6BF/FeNHPS3MEL1/Vi/fQU/C9ELUrkc=",
                "workchain": -1,
                "shard": -9223372036854775808
              }
            ]
         }
}
```

# License 
MIT