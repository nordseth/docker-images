#!/bin/sh
set -e

if test -f "/tmp/.ssh/id_rsa"; then
    cp -R /tmp/.ssh/id_rsa /root/.ssh
    chmod 600 /root/.ssh/id_rsa
fi

if test -f "/tmp/.ssh/id_rsa.pub"; then
    cp -R /tmp/.ssh/id_rsa.pub /root/.ssh
    chmod 644 /root/.ssh/id_rsa.pub
fi

echo "Host *\n    UserKnownHostsFile /tmp/.ssh/known_hosts" > /root/.ssh/config
chmod 600 /root/.ssh/config

exec "$@"