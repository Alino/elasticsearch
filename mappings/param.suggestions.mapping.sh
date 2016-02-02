#!/usr/bin/env bash
curl -XPUT "http://$ELASTICSEARCH_HOST:$ES_PORT/paramvalues/suggestions/_mapping" -d'
{
  "properties": {
     "param": {
        "type": "nested",
        "properties": {
            "paramName": {
                "type": "string"
             },
             "value": {
                "type": "string",
                "analyzer": "nGram_analyzer"
             }
        }
     }
  }
}'

curl -XPUT "http://$ELASTICSEARCH_HOST:$ES_PORT/paramnames/suggestions/_mapping" -d'
{
  "properties": {
      "paramName": {
          "type": "string",
          "analyzer": "nGram_analyzer"
       }
  }
}'