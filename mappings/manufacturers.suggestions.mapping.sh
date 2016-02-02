#!/usr/bin/env bash
curl -XPUT "http://$ELASTICSEARCH_HOST:$ES_PORT/manufacturers/suggestions/_mapping" -d'
{
   "_all": {
      "analyzer": "nGram_analyzer"
   },
   "properties": {
      "_id": {
            "type": "string",
            "index": "not_analyzed",
            "include_in_all": false
       },
      "name": {
            "type": "string"
       }
   }
}'
