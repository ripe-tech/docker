#!/bin/sh
set -e

if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
    set -- varnishd \
        -F \
        -f /etc/varnish/default.vcl \
        -a http=:${VARNISH_HTTP_PORT:-80},HTTP \
        -p feature=+http2 \
        -s malloc,$VARNISH_SIZE \
        "$@"
fi

exec "$@"
