#!/bin/bash

#create docker network
docker-compose up -d consul

## Get IP
CONSUL_INT_IP=$(docker inspect -f '{{ .NetworkSettings.Networks.kafkaelasticsearch_network.IPAddress }}' consul)
if [ ! -z "${CONSUL_IP}" ]; then
	sed -i '' -e "s/dns: .*/dns: ${CONSUL_IP}/" base.yml
	sed -i '' -e "s/CONSUL_CLUSTER_IPS=.*/CONSUL_CLUSTER_IPS=${CONSUL_IP}/" base.yml
fi
echo "export CONSUL_INT_IP=${CONSUL_INT_IP}" > env.sh
source env.sh
docker-compose up -d zookeeper kafka-broker kafka-manager elasticsearch
sleep 5
echo ">> Please 'source env.sh' to pick up the IP adress of the Consul node"
