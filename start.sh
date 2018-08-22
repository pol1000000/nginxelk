#!/bin/bash

ELK_VERSION="5.6.10"
NGINX_VERSION="1.15.2"

# 1. First let's start Elasticsearch

docker run -d --rm --name elasticsearch \
  elasticsearch:$ELK_VERSION

# 2. Now we can start logstash (host from config has to match link)

docker build -t mylogstash ./logstash

docker run -d --rm --name logstash \
  --link elasticsearch:elasticsearch \
  mylogstash

# 3. Let's run Kibana
# If you want to check it out go to http://localhost:5601
# Don't forget to create an Index pattern

docker run -d --rm --name kibana \
  --link elasticsearch:elasticsearch \
  -p 5601:5601 \
  kibana:$ELK_VERSION

# 4. Finally let's start our webserver
# Note that logging can not be connected via Link
# --> this will not work in a Docker-Compose File
# Except $LOGSTASH_ADDRESS is defined as environment variable

LOGSTASH_ADDRESS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' logstash)

docker run -d --rm --name nginx \
  --log-driver=gelf \
  --log-opt gelf-address=udp://$LOGSTASH_ADDRESS:12201 \
  --log-opt tag="test" \
  -p 80:80 \
  nginx:$NGINX_VERSION

echo " run \"curl localhost\" to create log events"
