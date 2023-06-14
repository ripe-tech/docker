FROM debian:bookworm-slim

LABEL version="1.0"
LABEL maintainer="Platforme <development@platforme.com>"

EXPOSE 80
EXPOSE 443

ARG VARNISH_MODULES_VERSION=0.20.0
ARG VARNISH_MODULES_SHA512SUM=e63d6da8f63a5ce56bc7a5a1dd1a908e4ab0f6a36b5bdc5709dca2aa9c0b474bd8a06491ed3dee23636d335241ced4c7ef017b57413b05792ad382f6306a0b36
ARG VARNISH_MODULES_QUERYFILTER_VERSION=1.0.1
ARG VARNISH_MODULES_QUERYFILTER_SHA512SUM=6c3178d656dfffa7f515afc5d01e00d86b4149e9e61e8024b524e04a427cf3875a918f03999a9bbf4e762ec684d8d193aa03b8d36c1291a825834905802ecc32
ARG TOOLBOX_COMMIT=96bab07cf58b6e04824ffec608199f1780ff0d04

ENV SERVER_NAME=localhost
ENV PROXY_PROTO=https://
ENV PROXY_HOST=app.platforme.com
ENV VARNISH_SIZE=1G

RUN apt-get -y update && apt-get -y upgrade &&\
    apt-get -y --no-install-recommends install gettext nginx varnish varnish-modules &&\
    apt-get -y clean && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /
COPY nginx.default.template /
COPY varnish.default.template /

RUN set -e; \
    export DEBIAN_FRONTEND=noninteractive; \
    export DEBCONF_NONINTERACTIVE_SEEN=true; \
    apt-get -y update; apt-get -y install \
        automake \
        build-essential \
        ca-certificates \
        curl \
        git \
        libgetdns10 \
        libgetdns-dev \
        libtool \
        libvarnishapi-dev \
        pkg-config \
        python3-docutils; \
    \
    rm /etc/varnish/default.vcl; \
    \
    rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default; \
    touch /etc/nginx/default.conf; \
    sed -i '/sites-enabled.*$/i \\tinclude \/etc\/nginx\/default\.conf;' /etc/nginx/nginx.conf; \
    nginx -t -c /etc/nginx/nginx.conf; \
    \
    cd /tmp; \
    git clone https://github.com/varnish/toolbox.git; cd toolbox; \
    git checkout $TOOLBOX_COMMIT; \
    cp install-vmod/install-vmod /usr/local/bin/; \
    \
    install-vmod https://github.com/varnish/varnish-modules/releases/download/$VARNISH_MODULES_VERSION/varnish-modules-$VARNISH_MODULES_VERSION.tar.gz $VARNISH_MODULES_SHA512SUM; \
    \
    chown varnish /var/lib/varnish; \
    apt-get -y purge --auto-remove \
        automake \
        build-essential \
        ca-certificates \
        curl \
        git \
        libgetdns10 \
        libgetdns-dev \
        libtool \
        libvarnishapi-dev \
        pkg-config \
        python3-docutils; \
    apt-get -y clean; \
    rm -rf /var/lib/apt/lists/* /tmp/toolbox /usr/lib/varnish/vmods/libvmod_*.la;

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD []
