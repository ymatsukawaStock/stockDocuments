#!/bin/bash
LIMITNUM=$1
TAG=$2
SORT=$3
SORTBY=$4

echo "http://localhost:8080/information?limit=$LIMITNUM&sortBy=$SORTBY&tag=$TAG&sort=$SORT"
curl -v -H "Accept: */*" "http://localhost:8080/information?limit=$LIMITNUM&sortBy=$SORTBY&tag=$TAG&sort=$SORT"
