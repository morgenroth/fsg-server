#!/bin/bash
set -e

if [ -n "${DNS_SERVER}" ]; then
  echo "nameserver ${DNS_SERVER}" > /etc/resolv.conf
  if [ -n "${DNS_DOMAIN}" ]; then
    echo "search ${DNS_DOMAIN}" >> /etc/resolv.conf
  fi
fi

if [[ "$1" != "prosody" ]]; then
    exec prosodyctl $*
    exit 0;
fi

if [ "$LOCAL" -a  "$PASSWORD" -a "$DOMAIN" ] ; then
    prosodyctl register $LOCAL $DOMAIN $PASSWORD
fi

exec "$@"
