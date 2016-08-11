#!/usr/bin/env bash

consul="false"
nomad="false"
clean="false"

for var in "$@"
do
	case "$var" in
		"--all")
		consul="true"
		nomad="true"
		;;
		"--consul")
		consul="true"
		;;
		"--nomad")
		nomad="true"
		;;
		"--clean")
		clean="true"
		;;
	esac

	echo "$var"
done

if [[ "$1" == "" || "$clean" == "false" && "$consul" == "false" && "$nomad" == "false" ]]; then
	echo "There's nothing to do here ... usage:"
	echo "./bootstrap.sh
arguments:
	--all:      Start all services
	--consul:   only start consul
	--nomad:    only start nomad
	--clean:    only stop and clean up after this script"
	exit
fi

docker-compose down

docker-compose build

if [ "$clean" == "true" ]; then
	exit 0
fi

docker-compose up -d consul
docker-compose scale consul=0
sleep 3

if [ "$consul" == "true" ]; then
	docker-compose scale consul=3
	sleep 5

	docker-compose scale consul_client=1
	sleep 2
fi

if [ "$nomad" == "true" ]; then
	docker-compose scale nomad=1
	sleep 30

	docker-compose scale nomad=2
	sleep 30

	docker-compose scale nomad=3
	sleep 30


	docker-compose scale nomad_client=1
fi
