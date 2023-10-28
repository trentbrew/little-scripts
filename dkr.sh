#!/bin/bash

exec() {
    docker exec -it $1 /bin/sh;
}
inspect() {
    docker inspect $1
}
