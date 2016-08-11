# Consul and Nomad in Docker

This repo is for starting a production-like consul cluster. It starts 
three internal consul server services and allows them to form a quorum.
After that, it will start a 'consul client' that you can reach on your
local machine (localhost:8500).

Once consul is started up, it will start up a nomad server cluster, using
consul to get up and running. After the quorum is formed in nomad, it
will start a client on the local machine, using the local docker socket.

You can reach the nomad client at localhost:4646

## Usage

- `./bootstrap.sh --all`: Start all the services
- `./bootstrap.sh --consul`: Only start consul
- `./bootstrap.sh --nomad`: Only start nomad (requires consul)

