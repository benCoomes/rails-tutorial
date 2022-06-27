#!/bin/bash

HOST="http://localhost:3000"

case $1 in
"list-bikes")
curl $HOST/bikes
;;

"list-riders")
curl $HOST/riders
;;

"create-bike")
curl -X POST \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"$2\", \"year\": 2018, \"slug\":\"$3\", \"description\": \"$4\"}" \
  $HOST/bikes
;;

"create-rider")
curl -X POST \
  -H "Content-Type: application/json" \
  -d "{\"age\": 32, \"name\": \"$2\", \"races_won\": 12}" \
  $HOST/riders
;;

"assign-rider")
curl -X PUT \
  -H "Content-Type: application/json" \
  -d "{\"rider_id\": \"$2\"}" \
  $HOST/bikes/1
;;

"get-bike")
curl $HOST/bikes/$2
;;

*)
echo "Did not recognize the command $1"
;;
esac

printf "\n"