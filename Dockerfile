# FROM ubuntu:trusty
FROM java:openjdk-7-jre
MAINTAINER Alexander Sadovsky

# install Java
# -----------------------
#  RUN apt-get update
#  RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre-headless wget && apt-get clean
#  ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# install curl
# -----------------------
RUN apt-get update && apt-get install -y curl nano

# install ElasticSearch
# -----------------------
RUN wget -qO /tmp/es.tgz https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz && \
  cd /usr/share && \
  tar xf /tmp/es.tgz && \
  rm /tmp/es.tgz && \
  mv /usr/share/elasticsearch-1.7.1 /usr/share/elasticsearch
ENV ES_HOME /usr/share/elasticsearch
ENV ELASTICSEARCH_HOST localhost
ENV ES_PORT 9200
ENV ES_HEAP_SIZE 450m
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
    bin/plugin --install elasticsearch-analysis-lemmagen --url file:///usr/share/elasticsearch/pluginInstallers/elasticsearch-analysis-lemmagen-0.1-plugin.zip && \
    bin/plugin -i elasticsearch/marvel/latest && \
    bin/plugin --install royrusso/elasticsearch-HQ && \
    bin/plugin --install mobz/elasticsearch-head


WORKDIR $ES_HOME
EXPOSE 9200 9300
ENTRYPOINT /opt/entrypoint.sh