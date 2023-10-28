#!/bin/bash

post() {
    curl -X POST -H "Content-Type: application/json" -d $1 $2;
}

get() {
    curl -X GET -H "Content-Type: application/json" -d $1 $2;
}

put() {
    curl -X PUT -H "Content-Type: application/json" -d $1 $2;
}

delete() {
    curl -X DELETE -H "Content-Type: application/json" -d $1 $2;
}
