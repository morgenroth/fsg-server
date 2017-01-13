#!/bin/bash
set -e

if [ -n "${DNS_SERVER}" ]; then
  echo "nameserver ${DNS_SERVER}" > /etc/resolv.conf
  if [ -n "${DNS_DOMAIN}" ]; then
    echo "search ${DNS_DOMAIN}" >> /etc/resolv.conf
  fi
fi

sudo -u prosody prosody
