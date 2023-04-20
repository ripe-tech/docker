#!/bin/bash

set -e

if [[ -f "/etc/varnish/default.vcl" ]]; then
    cp /varnish.default.template /etc/varnish/default.vcl
fi

envsubst '$SERVER_NAME$PROXY_PROTO$PROXY_HOST' < /nginx.default.template > /etc/nginx/default.conf;

if [ "$#" -eq 0 ] ; then
    nginx -c /etc/nginx/nginx.conf;
    set -- varnishd \
        -F \
        -f /etc/varnish/default.vcl \
        -a http=:80,HTTP \
        -p feature=+http2 \
        -s malloc,$VARNISH_SIZE; \
        "$@"
fi

exec "$@"
