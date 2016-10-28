FROM elasticsearch:5.0

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="elasticsearch shield marvel watcher graph"

COPY config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml
COPY config/roles.yml /etc/elasticsearch/x-pack/roles.yml

# Add roles
COPY config/roles.yml /elasticsearch/config/shield/

## install modules
RUN bin/elasticsearch-plugin install x-pack --batch

ENV admin="admin" \
    admin_pwd="changeme" \
    power_user="power-user" \
    power_user_pwd="changeme" \
    user="user" \
    user_pwd="changeme" \
    kibana_server="kibana-server" \
    kibana_server_pwd="changeme" \
    kibana_user="kibana" \
    kibana_pwd="changeme" \
    logstash_user="logstash" \
    logstash_pwd="changeme" \
    marvel_user="marvel" \
    marvel_pwd="changeme" \
    remote_marvel_agent="marvel-agent" \
    remote_marvel_agent_pwd="changeme" \
    watcher_admin="watcher-admin" \
    watcher_admin_pwd="changeme" \
    heap_size="1g"

RUN mkdir -p /config
ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["elasticsearch"]
