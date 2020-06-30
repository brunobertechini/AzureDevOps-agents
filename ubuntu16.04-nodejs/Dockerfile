ARG FROM_IMAGE
ARG FROM_IMAGE_TAG

FROM ${FROM_IMAGE:-devopsubuntu16.04}:${FROM_IMAGE_TAG:-latest}

COPY scripts /scripts

ENV AGENT_TOOLSDIRECTORY=/_work/_tool

RUN /scripts/installers/nodejs.sh
