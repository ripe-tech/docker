FROM alpine:3.17

LABEL version="1.0"
LABEL maintainer="Platforme <development@platforme.com>"

RUN apk update &&\
    apk add --no-cache \
        bash \
        ca-certificates \
        git \
        python3 &&\
    python --version

ENV PYTHON_PIP_VERSION 22.3.1
ENV PYTHON_SETUPTOOLS_VERSION 65.5.1
ENV PYTHON_GET_PIP_URL https://github.com/pypa/get-pip/raw/d5cb0afaf23b8520f1bbcfed521017b4a95f5c01/public/get-pip.py
ENV PYTHON_GET_PIP_SHA256 394be00f13fa1b9aaa47e911bdb59a09c3b2986472130f30aa0bfaf7f3980637
RUN set -eux; \
    wget -O get-pip.py "$PYTHON_GET_PIP_URL"; \
    echo "$PYTHON_GET_PIP_SHA256 *get-pip.py" | sha256sum -c -; \
    python get-pip.py \
        --disable-pip-version-check \
        --no-cache-dir \
        --no-compile \
        "pip==$PYTHON_PIP_VERSION" \
        "setuptools==$PYTHON_SETUPTOOLS_VERSION"; \
    rm -f get-pip.py; \
    pip --version

CMD ["/bin/bash"]
