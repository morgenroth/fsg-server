#!/bin/sh
set -e
set -x

if [ $(grep -ci $CUPS_ADMIN /etc/shadow) -eq 0 ]; then
    useradd $CUPS_ADMIN --system -G root,lpadmin --no-create-home --password $(mkpasswd $CUPS_PASSWD)
fi

exec /usr/sbin/cupsd -c /var/cups_config/cupsd.conf -f
