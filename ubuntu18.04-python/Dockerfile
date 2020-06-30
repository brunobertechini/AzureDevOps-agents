ARG FROM_IMAGE
ARG FROM_IMAGE_TAG

FROM ${FROM_IMAGE:-devopsubuntu18.04}:${FROM_IMAGE_TAG:-latest}

COPY scripts /scripts

ENV AGENT_TOOLSDIRECTORY=/_work/_tool

RUN apt-get update && apt-get install make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libsqlite3-dev \
    unixodbc-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libreadline-dev \
    libffi-dev \
    wget

RUN /scripts/installers/python.sh && \
    /scripts/installers/python_from_source.sh "3.6.10" && \
    /scripts/installers/python_from_source.sh "3.7.3" && \
    /scripts/installers/python_from_source.sh "3.7.6" && \
    /scripts/installers/python_from_source.sh "3.8.1"
