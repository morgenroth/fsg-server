#!/bin/bash
#


do_check() {
  RET=$(docker-compose exec radius /data/radius-python/radtest.sh | grep "rad_recv: Access-Accept")
  [ -n "${RET}" ]
}

logger -t "radius" "Radius checker started"

echo -n "Checking "
while [ 1 ]; do
  if do_check; then
    echo -n "."
  else
    echo "\nRadius responded wrong => restarting"
    logger -t "radius" "Radius responded wrong => restarting"
    docker-compose restart radius
    echo -n "Checking "
  fi
  sleep 10
done

logger -t "radius" "Radius checker stopped"

