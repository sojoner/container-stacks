# Kafka Elasticsearch

This will start a consul,  kafka, elasticsearch stack for toying around.

## Starting the Kafka Zookeeper Elasticsearch Stack

    $ ./backends-start.sh
    $ source env.sh
    $ docker-compose ps

Goto the consul UI in your browser to see if everything has started.

## Working with the up.sh script

In oder to work with docker network overlays and service discovery, we have this __start-backends.sh__ script. It will

* start consul with the __docker-compose__ command
* get the __IP__ for the __consul__ service
* write the consul __IP__ to the __env.sh__ file
* __source__ the __env.sh__ file
* start kafka and elasticsearch with the __docker-compose__ command

Now if you want to add, or change something you would either need to add this to the docker-compose.yml file and than you can edit the up.sh file for permant use, or you just __docker-compose__ command.

## Verify 

### Kafka

Visiting this URL

    http://<YOUR_DOCKER_HOST>:9000

You should see a UI please follow [this](https://github.com/yahoo/kafka-manager) for more informations.

### Elasticsearch

Visit this URL

    http://<YOUR_DOCKER_HOST>:9200

You should see somthing like.

    {
    "status": 200,
    "name": "Sise-Neg",
    "cluster_name": "dp-es",
    "version": {
        "number": "1.7.6",
        "build_hash": "c730b59357f8ebc555286794dcd90b3411f517c9",
        "build_timestamp": "2016-11-18T15:21:16Z",
        "build_snapshot": false,
        "lucene_version": "4.10.4"
        },
    "tagline": "You Know, for Search"
    }


### Visit Kibana

    http://<YOUR_DOCKER_HOST>:5601

## Start Stream processors    
    ./kstreams-stop.sh

### Check the logs 

    $docker logs <CONTAINER_NAME>


## Stop and remove the containers

    $./backends-stop.sh
    $./kstreams-stop.sh

## Clean Your Images

    $ docker images
    $ docker rmi <IMAGE-HASH>

© Sojoner 2017

