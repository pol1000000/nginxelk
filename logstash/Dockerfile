FROM logstash:5.6.10

RUN /usr/share/logstash/bin/logstash-plugin install logstash-patterns-core

COPY ./my_logstash.conf /etc/logstash/conf.d/my_logstash.conf
COPY start_logstash.sh /

EXPOSE 12201/udp
CMD ["/start_logstash.sh"]