#!/bin/bash

echo "Start consul"
#create docker network
docker-compose up -d consul

## Get IP
CONSUL_INT_IP=$(docker inspect -f '{{ .NetworkSettings.Networks.cljkstream_network.IPAddress }}' consul)
if [ ! -z "${CONSUL_IP}" ]; then
	sed -i '' -e "s/dns: .*/dns: ${CONSUL_IP}/" base.yml
	sed -i '' -e "s/CONSUL_CLUSTER_IPS=.*/CONSUL_CLUSTER_IPS=${CONSUL_IP}/" base.yml
fi
echo "export CONSUL_INT_IP=${CONSUL_INT_IP}" > env.sh
source env.sh
echo "start kafka elasticsearch stack"
docker-compose up -d zookeeper kafka-broker kafka-manager elasticsearch
sleep 5
echo ">> Please 'source env.sh' to pick up the IP adress of the Consul node"

echo "start clj-kstream-cutter"
docker-compose up -d clj-kstream-cutter
sleep 5

echo "start clj-kstream-hh"
docker-compose up -d clj-kstream-hh
sleep 5

echo "start clj-kstream-string-long-window-aggregate"
docker-compose up -d clj-kstream-string-long-window-aggregate
sleep 5

echo "start clj-kstream-elasticsearch-sink"
docker-compose up -d clj-kstream-elasticsearch-sink
sleep 5