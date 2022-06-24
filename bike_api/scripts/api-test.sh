#!/bin/bash

HOST="http://localhost:3000"

curl $HOST/bikes

curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"model": "Giant TCR", "year": 2018, "slug":"giant-tcr-2018", "description": "A good road bike."}' \
  $HOST/bikes