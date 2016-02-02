#!/usr/bin/env bash

# todo - once this was executed successfully dont execute it again

cd mappings
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
cd ../