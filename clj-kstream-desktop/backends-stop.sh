#!/bin/bash

echo "Stop backends"
docker-compose kill zookeeper kafka-broker kafka-manager elasticsearch1 elasticsearch2 kibana
docker-compose rm -f zookeeper kafka-broker kafka-manager elasticsearch1 elasticsearch2 kibana
