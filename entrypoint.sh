#!/usr/bin/env bash

{
until $(curl --output /dev/null --silent --head --fail http://127.0.0.1:9200); do
  printf '\e[1;34m%-6s\e[m \n%s\n' "...WAITING UNTIL ES COMES UP..."
  sleep 2
done
printf '\e[1;34m%-6s\e[m \n%s\n' 'GOOD, ES IS UP! GOING TO CREATE INDEXES AND MAPPINGS...'
cd $ES_HOME && ./createMappings.sh
printf '\e[1;34m%-6s\e[m \n%s\n' 'CREATION OF INDEXES AND MAPPINGS IS DONE.'
} &
exec $ES_HOME/bin/elasticsearch "$@"
exec "$@"