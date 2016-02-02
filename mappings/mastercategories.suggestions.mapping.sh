#!/usr/bin/env bash
curl -XPUT "http://$ELASTICSEARCH_HOST:$ES_PORT/mastercategories/suggestions/_mapping" -d'
{
   "_all": {
      "analyzer": "slovencina"
   },
   "properties": {
      "ancestors": {
            "properties": {
               "_id": {
                  "type": "string",
                  "index": "not_analyzed",
                  "include_in_all": false
               },
               "label": {
                  "type": "string",
                  "index": "not_analyzed",
                  "include_in_all": false
               },
               "path": {
                  "type": "string",
                  "index": "not_analyzed",
                  "include_in_all": false
               }
            }
       },
      "children": {
            "properties": {
               "_id": {
                  "type": "string",
                  "index": "not_analyzed",
                  "include_in_all": false
               },
               "label": {
                  "type": "string",
                  "index": "not_analyzed",
                  "include_in_all": false
               },
               "path": {
                  "type": "string",
                  "index": "not_analyzed",
                  "include_in_all": false
               },
               "priority": {
                  "type": "long",
                  "index": "not_analyzed",
                  "include_in_all": false
               }
            }
       },
      "count": {
            "type": "long",
            "index": "not_analyzed",
            "include_in_all": false
       },
      "icon": {
            "type": "string",
            "index": "no",
            "include_in_all": false
       },
      "label": {
            "type": "string"
       },
      "path": {
            "type": "string"
       },
      "priority": {
            "type": "long",
            "index": "not_analyzed",
            "include_in_all": false
       }
   }
}'
