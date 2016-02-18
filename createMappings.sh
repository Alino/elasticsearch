#!/usr/bin/env bash

function isMappingCreated() {
  if [ -f "$ES_HOME/mappingsCreated" ];
  then
    return 0
  else
    return 1
  fi
}

if isMappingCreated; then
  printf '\e[1;34m%-6s\e[m \n%s\n' 'mappings and indexes were already created'
else
  printf '\e[1;34m%-6s\e[m \n%s\n' 'GOING TO CREATE INDEXES AND MAPPINGS...'
  {
    cd $ES_HOME/mappings
    ./mastercategories.index.sh
    ./mastercategories.suggestions.mapping.sh
    ./manufacturers.index.sh
    ./manufacturers.suggestions.mapping.sh
    ./masterproducts.index.sh
    ./masterproducts.product.mapping.sh
    ./param.index.sh
    ./param.suggestions.mapping.sh
    ./searchedqueries.index.sh
    ./searchedqueries.suggestions.mapping.sh
    cd $ES_HOME
  } && printf '\e[1;34m%-6s\e[m \n%s\n' 'CREATION OF INDEXES AND MAPPINGS IS DONE.' && touch $ES_HOME/mappingsCreated
fi

