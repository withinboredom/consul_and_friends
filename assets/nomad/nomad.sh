#!/bin/bash

type="$1"

if [ "$type" == "server" ]; then
	exec /bin/nomad agent -config /nomad.json -bind=$(ip route get 8.8.8.8 | awk 'NR==1 {print $NF}')
fi

if [ "$type" == "client" ]; then
	exec /bin/nomad agent -config /nomad_client.json -bind=$(ip route get 8.8.8.8 | awk 'NR==1 {print $NF}')
fi
