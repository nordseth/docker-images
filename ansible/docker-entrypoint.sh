#!/bin/sh
set -e

# Copy any private/public key pairs (id_rsa, id_ed25519, id_ecdsa, ...) from /tmp/.ssh
for key in /tmp/.ssh/id_*; do
    test -f "$key" || continue
    name=$(basename "$key")
    cp "$key" "/root/.ssh/$name"
    case "$name" in
        *.pub) chmod 644 "/root/.ssh/$name" ;;
        *)     chmod 600 "/root/.ssh/$name" ;;
    esac
done

printf 'Host *\n    UserKnownHostsFile /tmp/.ssh/known_hosts\n' > /root/.ssh/config
chmod 600 /root/.ssh/config

exec "$@"
