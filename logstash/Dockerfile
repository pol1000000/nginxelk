FROM logstash:5.6.10

RUN /usr/share/logstash/bin/logstash-plugin install logstash-patterns-core

COPY ./my_logstash.conf /etc/logstash/conf.d/my_logstash.conf
COPY start_logstash.sh /

ADD http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz /opt/
RUN cd /opt && tar -xzvf GeoLite2-City.tar.gz && \
  rm GeoLite2-City.tar.gz && \
  mv GeoLite2-City*/GeoLite2-City.mmdb . && \
  rm -rf GeoLite2-City*/

EXPOSE 12201/udp
CMD ["/start_logstash.sh"]
