FROM logstash:5.6.10

ADD http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz /opt/
RUN cd /opt && tar -xzvf GeoLite2-City.tar.gz && \
  mv GeoLite2-City*/GeoLite2-City.mmdb . && \
  rm -f GeoLite2-City.tar.gz && \
  rm -rf GeoLite2-City*/

RUN /usr/share/logstash/bin/logstash-plugin install logstash-patterns-core

COPY ./logstash.conf /etc/logstash/conf.d/logstash.conf

USER logstash
EXPOSE 12201/udp

CMD ["logstash", "-f", "/etc/logstash/conf.d/logstash.conf"]