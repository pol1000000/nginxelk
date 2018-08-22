#!/bin/bash
set -e

# Run as user logstash
set -- gosu logstash
logstash -f /etc/logstash/conf.d/my_logstash.conf
# Add `--verbose --debug` if you need more info.