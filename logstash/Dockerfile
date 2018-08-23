FROM docker.elastic.co/logstash/logstash:6.3.2

LABEL maintainer="alexander.malic@maastrichtuniversity.nl"

WORKDIR /usr/share/logstash/bin/
RUN logstash-plugin update && \
  logstash-plugin install logstash-patterns-core

COPY ./logstash.conf /etc/logstash/conf.d/logstash.conf

USER logstash
EXPOSE 12201/udp

CMD ["logstash", "-f", "/etc/logstash/conf.d/logstash.conf"]