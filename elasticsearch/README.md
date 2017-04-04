# Elasticsearch 
This docker compose lets you start various elasticsearch instances.

### Getting Started

Start latest ES 1 version 

    $docker-compose up -d  elasticsearch-1
    $docker-compose up -d  elasticsearch-2
    $docker-compose up -d  elasticsearch-5

Visit this URL

    http://<YOUR_DOCKER_HOST>:9000

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


© Sojoner 2017