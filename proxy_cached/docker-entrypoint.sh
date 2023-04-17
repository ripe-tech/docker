#!/bin/bash

set -e

envsubst < /etc/nginx/default.conf > /etc/nginx/default.conf;

if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
    set -- \
        nginx /etc/nginx.conf; \
        varnishd \
        -F \
        -f /etc/varnish/default.vcl \
        -a http=:80,HTTP \
        -p feature=+http2 \
        -s malloc,$VARNISH_SIZE; \
        "$@"
fi

exec "$@"
