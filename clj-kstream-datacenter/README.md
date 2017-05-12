# Kafka Streams Heavy-Hitter Elasticsearch Example

An example of how to run a kafka streaming stack in a Docker Swarm on multiple nodes.

## Starting the Kafka Zookeeper Elasticsearch Stack

    $docker network create --driver overlay --attachable=true backend_services

    $docker stack deploy --compose-file backend.yml backend

#### Kafka

Visiting this URL

    http://<YOUR_DOCKER_HOST>:9000

You should see a UI please follow [this](https://github.com/yahoo/kafka-manager) for more informations.

#### Elasticsearch

Visit this URL

    http://<YOUR_DOCKER_HOST>:9200

#### Visit Kibana

    http://<YOUR_DOCKER_HOST>:5601

#### Check the logs 

    $docker logs <CONTAINER_NAME>

## The Kafka Streaming Applications

__Stop__

    $docker stack deploy --compose-file streamprocessors.yml kstream

__Start__

	$docker run -t --rm -i --name clj-kstream-lf-producer --network backend_services sojoner/clj-kstream-lf-producer:0.1.0 --broker backend_broker:9092 --topic logs-replay

	$docker run -t --rm -i --name clj-kstream-cutter --network backend_services sojoner/clj-kstream-cutter:0.2.0 --broker backend_broker:9092 --zookeeper backend_zookeeper:2181 --input-topic logs-replay --output-topic mapped-test-json --selector msg --name stream-cut-json-field
	
	$docker run -t --rm -i --name clj-kstream-hh --network backend_services sojoner/clj-kstream-hh:0.1.0 --broker backend_broker:9092 --input-topic mapped-test-json --output-topic heavy-hitters  --window-size 1 --name stream-hh

	$docker run -t --rm -i --name clj-kstream-hh --network backend_services sojoner/clj-kstream-string-long-window-aggregate:0.2.2 --broker backend_broker:9092 --input-topic heavy-hitters --window-size 1 --output-topic agg-result --name stream-agg

	$docker run -t --rm -i --name clj-kstream-hh --network backend_services sojoner/clj-kstream-elasticsearch-sink:0.0.1 --broker backend_broker:9092 --topic agg-result --elasticsearch http://backend_esmaster:9200 --index heavy-hitters-test-idx --index-type hh-struct


	


    


## Some Docker commands

    $ docker images
    $ docker rmi <IMAGE-HASH>

© Sojoner 2017

