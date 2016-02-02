#!/usr/bin/env bash
curl -XPOST "http://$ELASTICSEARCH_HOST:$ES_PORT/paramvalues" -d'
{
"settings": {
  "analysis": {
    "filter": {
      "lemmagen_filter_sk": {
        "type": "lemmagen",
        "lexicon": "sk"
      },
      "sk_SK" : {
        "type" : "hunspell",
        "locale" : "sk_SK",
        "dedup" : true,
        "recursion_level" : 0
      },
      "synonym_filter": {
        "type": "synonym",
        "synonyms_path": "synonyms/sk_SK.txt",
        "ignore_case": true
      },
      "stopwords_SK": {
        "type": "stop",
        "stopwords_p  ath": "stop-words/stop-words-slovak.txt",
        "ignore_case": true
      },
      "nGram_filter": {
        "type": "nGram",
        "min_gram": 1,
        "max_gram": 20,
        "token_chars": [
          "letter",
          "digit",
          "punctuation",
          "symbol"
        ]
      }
    },
    "analyzer": {
      "slovencina_synonym": {
        "type": "custom",
        "tokenizer": "standard",
        "filter": [
          "stopwords_SK",
          "lemmagen_filter_sk",
          "lowercase",
          "stopwords_SK",
          "synonym_filter",
          "asciifolding"
        ]
      },
      "slovencina": {
        "type": "custom",
        "tokenizer": "standard",
        "filter": [
          "stopwords_SK",
          "lemmagen_filter_sk",
          "lowercase",
          "stopwords_SK",
          "asciifolding",
          "nGram_filter"
        ]
      },
      "nGram_analyzer": {
        "type": "custom",
        "tokenizer": "whitespace",
        "filter": [
          "lowercase",
          "asciifolding",
          "nGram_filter"
        ]
      },
      "whitespace_analyzer": {
        "type": "custom",
        "tokenizer": "whitespace",
        "filter": [
          "lowercase",
          "asciifolding"
        ]
      }
    }
  }
}
}'



curl -XPOST "http://$ELASTICSEARCH_HOST:$ES_PORT/paramnames" -d'
{
"settings": {
  "analysis": {
    "filter": {
      "lemmagen_filter_sk": {
        "type": "lemmagen",
        "lexicon": "sk"
      },
      "sk_SK" : {
        "type" : "hunspell",
        "locale" : "sk_SK",
        "dedup" : true,
        "recursion_level" : 0
      },
      "synonym_filter": {
        "type": "synonym",
        "synonyms_path": "synonyms/sk_SK.txt",
        "ignore_case": true
      },
      "stopwords_SK": {
        "type": "stop",
        "stopwords_p  ath": "stop-words/stop-words-slovak.txt",
        "ignore_case": true
      },
      "nGram_filter": {
        "type": "nGram",
        "min_gram": 1,
        "max_gram": 20,
        "token_chars": [
          "letter",
          "digit",
          "punctuation",
          "symbol"
        ]
      }
    },
    "analyzer": {
      "slovencina_synonym": {
        "type": "custom",
        "tokenizer": "standard",
        "filter": [
          "stopwords_SK",
          "lemmagen_filter_sk",
          "lowercase",
          "stopwords_SK",
          "synonym_filter",
          "asciifolding"
        ]
      },
      "slovencina": {
        "type": "custom",
        "tokenizer": "standard",
        "filter": [
          "stopwords_SK",
          "lemmagen_filter_sk",
          "lowercase",
          "stopwords_SK",
          "asciifolding",
          "nGram_filter"
        ]
      },
      "nGram_analyzer": {
        "type": "custom",
        "tokenizer": "whitespace",
        "filter": [
          "lowercase",
          "asciifolding",
          "nGram_filter"
        ]
      },
      "whitespace_analyzer": {
        "type": "custom",
        "tokenizer": "whitespace",
        "filter": [
          "lowercase",
          "asciifolding"
        ]
      }
    }
  }
}
}'