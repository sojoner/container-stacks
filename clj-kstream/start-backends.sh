#!/bin/bash

echo "Start consul"
#create docker network
docker-compose up -d consul

## Get IP
CONSUL_INT_IP=$(docker inspect -f '{{ .NetworkSettings.Networks.cljkstream_network.IPAddress }}' consul)
echo "export CONSUL_INT_IP=${CONSUL_INT_IP}" > env.sh

echo "start kafka elasticsearch stack"
docker-compose up -d zookeeper kafka-broker kafka-manager elasticsearch
sleep 5
echo ">> Please 'source env.sh' to pick up the IP adress of the Consul node"


