FROM alpine:3.18

LABEL version="1.0"
LABEL maintainer="Platforme <development@platforme.com>"

EXPOSE 80
EXPOSE 443

ARG APORTS_COMMIT=7843f08683dff0ce67394eb8be2f58f598606199

ENV SERVER_NAME=localhost
ENV PROXY_PROTO=https://
ENV PROXY_HOST=app.platforme.com
ENV VARNISH_SIZE=1G

COPY docker-entrypoint.sh /
COPY nginx.default.template /
COPY varnish.default.template /

RUN set -e;\
    \
    apk add --no-cache envsubst varnish nginx; \
    \
    apk add --virtual build -q --no-progress --update alpine-sdk sudo; \
    adduser -D builder; \
    echo "builder ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/builder; \
    addgroup builder abuild; \
    su builder -c "abuild-keygen -nai"; \
    git clone https://gitlab.alpinelinux.org/alpine/aports.git; \
    cd aports; git checkout $APORTS_COMMIT; \
    cd testing/varnish-modules; \
    chown builder -R .; \
    su builder -c "abuild -r"; \
    tree ~builder/packages/; \
    apk add --allow-untrusted ~builder/packages/testing/**/varnish-modules-0.22.0-r0.apk; \
    \
    rm /etc/varnish/default.vcl; \
    \
    rm /etc/nginx/http.d/default.conf; \
    nginx -t -c /etc/nginx/nginx.conf; \
    \
    apk del --no-network build; \
    rm -rf ~builder /packages /aports /etc/sudoers.d/builder; \
    deluser --remove-home builder; \
    chown varnish /var/lib/varnish;

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD []
