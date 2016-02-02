#!/usr/bin/env bash
curl -XPUT "http://$ELASTICSEARCH_HOST:$ES_PORT/masterproducts/product/_mapping" -d'
{
   "_all": {
      "analyzer": "slovencina_synonym"
   },
   "properties": {
     "category": {
        "properties": {
          "masterCategory_id": {
            "type": "string",
            "index": "not_analyzed"
          },
          "label": {
            "type": "string",
            "analyzer": "slovencina_synonym",
            "fields": {
              "raw": {
                "type": "string",
                "include_in_all": false,
                "index": "not_analyzed"
              }
            }
          },
          "path": {
            "type": "string",
            "index": "not_analyzed",
            "include_in_all": false
          }
        }
     },
     "dateOfCreation": {
        "type": "date",
        "format": "dateOptionalTime",
        "include_in_all": false
     },
     "dateOfModification": {
        "type": "date",
        "format": "dateOptionalTime",
        "include_in_all": false
     },
     "description": {
        "type": "string",
        "analyzer": "slovencina_synonym"
     },
     "ean": {
        "type": "string"
     },
     "eshopProducts": {
        "properties": {
           "delivery_date": {
              "type": "string",
              "include_in_all": false
           },
           "eshop_id": {
              "type": "string",
              "include_in_all": false
           },
           "item_id": {
              "type": "string",
              "include_in_all": false
           },
           "price": {
              "type": "double",
              "include_in_all": false
           },
           "price_vat": {
              "type": "double",
              "include_in_all": false
           },
           "url": {
              "type": "string",
              "include_in_all": false
           }
        }
     },
     "manufacturer": {
        "type": "string",
        "analyzer": "slovencina"
     },
     "nameAndParams": {
        "type": "string",
        "analyzer": "slovencina"
     },
     "name": {
        "type": "string",
        "analyzer": "slovencina_synonym",
        "copy_to": "nameAndParams"
     },
     "params": {
        "properties": {
           "paramName": {
              "type": "string",
              "copy_to": "nameAndParams"
           },
           "value": {
              "type": "string",
              "copy_to": "nameAndParams"
           }
        }
     },
     "photo": {
        "type": "string",
        "include_in_all": false
     },
     "productSlug": {
        "type": "string"
     },
     "type": {
        "type": "string",
        "include_in_all": false
     }
   }
}'