#!/bin/bash -x
#

NAME="fsg-server"
TAG="backup-$(date +%Y-%m-%d)"

mkdir -p ../${TAG}
tar cvzf ../${TAG}/${NAME}-etc.tar.gz /etc
tar cvzf ../${TAG}/${NAME}-docker-config.tar.gz ./

for DATA in $(find /data -mindepth 1 -maxdepth 1 -type d); do
  SUBTAG=$(basename ${DATA})
  tar cvzf ../${TAG}/${NAME}-data-${SUBTAG}.tar.gz ${DATA}
done
