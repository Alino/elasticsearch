#FROM ubuntu:trusty
FROM java:openjdk-8-jre
MAINTAINER Alexander Sadovsky

# install Java
# -----------------------
#  RUN apt-get update
#  RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-9-jre-headless wget && apt-get clean
#  ENV JAVA_HOME /usr/lib/jvm/java-9-openjdk-amd64

# install curl
# -----------------------
RUN apt-get update && apt-get install -y curl nano

# install ElasticSearch
# -----------------------
RUN wget -qO /tmp/es.tgz https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.3.3/elasticsearch-2.3.3.tar.gz && \
  cd /usr/share && \
  tar xf /tmp/es.tgz && \
  rm /tmp/es.tgz && \
  mv /usr/share/elasticsearch-2.3.3 /usr/share/elasticsearch
ENV ES_HOME /usr/share/elasticsearch
ENV ELASTICSEARCH_HOST localhost
ENV ES_PORT 9200
# ES_HEAP_SIZE 256m is needed to run on 512mb RAM droplet. (Staging env)
ENV ES_HEAP_SIZE 256m
ENV ES_JAVA_OPTS -server
RUN mkdir -p $ES_HOME
RUN useradd -d $ES_HOME -M -r elasticsearch && \
    chown -R elasticsearch: $ES_HOME
COPY config/hunspell/sk_SK /usr/share/elasticsearch/config/hunspell/sk_SK
COPY config/stop-words /usr/share/elasticsearch/config/stop-words
COPY config/synonyms /usr/share/elasticsearch/config/synonyms
COPY mappings /usr/share/elasticsearch/mappings
COPY createMappings.sh /usr/share/elasticsearch/createMappings.sh
COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
COPY pluginInstallers /usr/share/elasticsearch/pluginInstallers/
COPY entrypoint.sh /opt/entrypoint.sh
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/* && \
    chmod +x /usr/share/elasticsearch/createMappings.sh && \
    chmod +x /usr/share/elasticsearch/mappings/*
USER elasticsearch

# install plugins
# -----------------------
RUN cd /usr/share/elasticsearch && \
    bin/plugin install https://github.com/vhyza/elasticsearch-analysis-lemmagen/releases/download/v2.3.3/elasticsearch-analysis-lemmagen-2.3.3-plugin.zip && \
    bin/plugin install license && \
    bin/plugin install marvel-agent


WORKDIR $ES_HOME
EXPOSE 9200 9300
ENTRYPOINT /opt/entrypoint.sh