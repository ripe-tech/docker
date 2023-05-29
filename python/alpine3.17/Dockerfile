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

ENV PYTHON_PIP_VERSION 23.0.1
ENV PYTHON_SETUPTOOLS_VERSION 65.5.1
ENV PYTHON_GET_PIP_URL https://github.com/pypa/get-pip/raw/0fe65e3c4342300f77a1158d9f2b06fbcf054a88/public/get-pip.py
ENV PYTHON_GET_PIP_SHA256 69a1d4496fe9ab42ffe23fc005e6250cb2899902249855278ee200221c131706
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
