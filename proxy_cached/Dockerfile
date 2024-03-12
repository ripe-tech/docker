FROM alpine:3.18

LABEL version="1.0"
LABEL maintainer="Platforme <development@platforme.com>"

EXPOSE 80
EXPOSE 443

ENV SERVER_NAME=localhost
ENV PROXY_PROTO=https://
ENV PROXY_HOST=app.platforme.com
ENV VARNISH_SIZE=1G

COPY docker-entrypoint.sh /
COPY nginx.default.template /
COPY varnish.default.template /

RUN set -e; \
    \
    apk add --no-cache envsubst nginx; \
    apk add varnish --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main; \
    apk add varnish-modules --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing; \
    \
    rm /etc/nginx/http.d/default.conf; \
    nginx -t -c /etc/nginx/nginx.conf; \
    \
    chown varnish /var/lib/varnish;

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD []
