#!/bin/bash
#

WORKSPACE=$(pwd)

for COMPOSE_YML in $(find -name docker-compose.yml); do
  cd $(dirname ${COMPOSE_YML})
  docker-compose ${1}
  cd ${WORKSPACE}
done
