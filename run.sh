#!/bin/bash

NGINX_VERSION="1.15.2"

# 1. First let's start our ELK-Stack
docker-compose up -d --build --force-recreate

# this could be exported to a environment variable
LOGSTASH_ADDRESS=$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginxelk_logstash_1)

# 2. Now let's start a test application
# 2.1 try to query http://localhost and some wrong url's
# 2.2 set up an index on http://localhost:5601
docker run -d --rm --name nginx \
  --log-driver=gelf \
  --log-opt gelf-address=udp://$LOGSTASH_ADDRESS:12201 \
  --log-opt tag="test" \
  -p 80:80 \
  nginx:$NGINX_VERSION

echo " run \"curl localhost\" to create log events"
