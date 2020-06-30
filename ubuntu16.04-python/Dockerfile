ARG FROM_IMAGE
ARG FROM_IMAGE_TAG

FROM ${FROM_IMAGE:-devopsubuntu16.04}:${FROM_IMAGE_TAG:-latest}

COPY scripts /scripts

ENV AGENT_TOOLSDIRECTORY=/_work/_tool

RUN apt-get install make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libsqlite3-dev \
    unixodbc-dev

RUN /scripts/installers/python.sh && \
    /scripts/installers/python373.sh
