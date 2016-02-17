#!/usr/bin/env bash

{
  while true; do
    curl -f 127.0.0.1:9200;
    if [ $? -eq 0 ]; then
      printf '\e[1;34m%-6s\e[m \n%s\n' 'GOOD, ES IS UP!'
      cd $ES_HOME && ./createMappings.sh
      break;
    else
      printf '\e[1;34m%-6s\e[m \n%s\n' "...WAITING UNTIL ES COMES UP..."
    fi
    sleep 2
  done
} &
exec $ES_HOME/bin/elasticsearch "$@"
exec "$@"