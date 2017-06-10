# Kafka Streams Heavy-Hitter Elasticsearch Example

An example of how to run a kafka streaming stack in a Docker Swarm on multiple nodes.

## Starting the Kafka Zookeeper Elasticsearch Stack

A hint, maybe you need to prepare your machines for elasticsearch by doing

    $sysctl -w vm.max_map_count=262144

So we create a network

    $docker network create --driver overlay --attachable=true backend_services

    $docker stack deploy --compose-file backend.yml backend

## Stoping
    
    $docker service rm backend_zkui backend_broker backend_kafkamanager backend_esmaster backend_esdata backend_kibana backend_zookeeper    

#### Kafka Manager

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

__Start Stack__

    $docker stack deploy --compose-file streamprocessors.yml kstream

__Start Interactive__

	$docker run -t --rm -i --name clj-kstream-lf-producer --network backend_services sojoner/clj-kstream-lf-producer:0.1.0 --broker backend_broker:9092 --topic logs-replay

	$docker run -t --rm -i --name clj-kstream-cutter --network backend_services sojoner/clj-kstream-cutter:0.2.1 --broker backend_broker:9092 --input-topic logs-replay --output-topic mapped-test-json --selector msg --name stream-cut-json-field
	
	$docker run -t --rm -i --name clj-kstream-hh --network backend_services sojoner/clj-kstream-hh:0.1.0 --broker backend_broker:9092 --input-topic mapped-test-json --output-topic heavy-hitters  --window-size 1 --name stream-hh

	$docker run -t --rm -i --name clj-kstream-string-long-window-aggregate --network backend_services sojoner/clj-kstream-string-long-window-aggregate:0.2.2 --broker backend_broker:9092 --input-topic heavy-hitters --window-size 1 --output-topic agg-result --name stream-agg

	$docker run -t --rm -i --name clj-kstream-elasticsearch-sink --network backend_services sojoner/clj-kstream-elasticsearch-sink:0.0.1 --broker backend_broker:9092 --topic agg-result --elasticsearch http://backend_esmaster:9200 --index heavy-hitters-test-idx --index-type hh-struct

__Remove__

	$docker service rm kstream_clj-kstream-cutter kstream_clj-kstream-lf-producer kstream_clj-kstream-string-long-window-aggregate kstream_clj-kstream-elasticsearch-sink kstream_clj-kstream-hh



## Some Docker commands

    $ docker images
    $ docker rmi <IMAGE-HASH>
    $ docker network ls
    $ docker ps -a


© Sojoner 2017

