#!/bin/bash

echo "Stop Streamin Apps"

docker-compose kill clj-kstream-lf-producer clj-kstream-cutter clj-kstream-hh clj-kstream-string-long-window-aggregate clj-kstream-elasticsearch-sink
docker-compose rm -f clj-kstream-lf-producer clj-kstream-cutter clj-kstream-hh clj-kstream-string-long-window-aggregate clj-kstream-elasticsearch-sink
