#!/bin/sh
# Import sample datasets into MongoDB

`mongoimport --host carbon/localhost:27001,localhost:27002,localhost:27003 --db test --collection incidents --file ../data/incidents.json --drop`
