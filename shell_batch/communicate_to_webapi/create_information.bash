#!/bin/bash
# curl -v -H "Accept: */*" -H "Content-type: application/json" -X POST -d \
#   '{"subject":"test", "detail":"foobarbaz", "tag":"foo,bar,baz"}' \
#   http://localhost:8080/information/create

curl -v -H "Accept: */*" -H "Content-type: application/json" -X POST -d \
  '{"information": { "subject":"test", "detail":"foobarbaz" }, "tag": {"name": "helldso,newone"} }' \
  http://localhost:8080/information/create
 
