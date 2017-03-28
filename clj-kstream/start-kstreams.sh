#!/bin/bash

echo "start fake producer"
docker-compose up -d clj-kstream-lf-producer
sleep 2

echo "start clj-kstream-cutter"
docker-compose up -d clj-kstream-cutter
sleep 2

echo "start clj-kstream-hh"
#docker-compose up -d clj-kstream-hh
sleep 2

echo "start clj-kstream-string-long-window-aggregate"
docker-compose up -d clj-kstream-string-long-window-aggregate
sleep 2

echo "start clj-kstream-elasticsearch-sink"
docker-compose up -d clj-kstream-elasticsearch-sink