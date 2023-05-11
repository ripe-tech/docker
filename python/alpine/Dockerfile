FROM alpine:3.18

LABEL version="1.0"
LABEL maintainer="Platforme <development@platforme.com>"

RUN apk update &&\
    apk add --no-cache \
        bash \
        ca-certificates \
        git \
        python3 &&\
    python --version

ENV PYTHON_PIP_VERSION 23.1.2
ENV PYTHON_SETUPTOOLS_VERSION 65.5.1
ENV PYTHON_GET_PIP_URL https://github.com/pypa/get-pip/raw/0d8570dc44796f4369b652222cf176b3db6ac70e/public/get-pip.py
ENV PYTHON_GET_PIP_SHA256 96461deced5c2a487ddc65207ec5a9cffeca0d34e7af7ea1afc470ff0d746207
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
