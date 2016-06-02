#!/usr/bin/env bash
curl -XPUT "http://$ELASTICSEARCH_HOST:$ES_PORT/searchedqueries/suggestions/_mapping" -d'
{
   "properties" : {
        "query" : { "type" : "string" },
        "weight": { "type" : "integer" },
        "suggest" : { "type" : "completion",
            "analyzer": "simple",
            "search_analyzer" : "simple",
            "payloads" : true
        }
      }
}'