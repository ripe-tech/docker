FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

ARG CPU_ARCH="x86_64"
ARG KTX_VERSION="4.2.1"
ARG PYTHON_VERSION="3.12.1"
ARG POETRY_VERSION="1.7.1"
ARG NODE_VERSION="18"

ENV PYTHONFAULTHANDLER=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONHASHSEED=random
ENV PYTHONDONTWRITEBYTECODE=1
ENV HOME="/home/realtime"
ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PATH"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# base dependency install
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -q -y --no-install-recommends curl wget jq gnupg gnupg2 ca-certificates git build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev rclone

# install google-chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-get install -q -y google-chrome-stable

# install nodejs
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_VERSION.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update &&\
    apt-get install -q -y --no-install-recommends git nodejs rclone libegl1-mesa &&\
    corepack enable

# cleanup
RUN apt-get clean &&\
    rm -rf /var/lib/apt/lists/* && rm /etc/apt/sources.list.d/google.list

# install ktx-software
RUN wget -c -O KTX.deb https://github.com/KhronosGroup/KTX-Software/releases/download/v$KTX_VERSION/KTX-Software-$KTX_VERSION-Linux-$CPU_ARCH.deb && \
    dpkg -i KTX.deb && \
    rm KTX.deb

# create realtime user
RUN groupadd --gid 10000 realtime && useradd --uid 10000 --gid 10000 --shell /bin/bash --create-home realtime

# install python and poetry with pyenv
USER realtime
RUN git clone https://github.com/pyenv/pyenv.git $HOME/pyenv && \
    $HOME/pyenv/bin/pyenv install $PYTHON_VERSION && \
    eval "$($HOME/pyenv/bin/pyenv init -)" && $HOME/pyenv/bin/pyenv global $PYTHON_VERSION && pip install numpy poetry setuptools wheel six auditwheel && \
    pip install poetry==$POETRY_VERSION

CMD ["tail", "-f", "/dev/null"]
