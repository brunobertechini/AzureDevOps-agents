ARG FROM_IMAGE
ARG FROM_IMAGE_TAG

FROM ${FROM_IMAGE:-devopsubuntu16.04}:${FROM_IMAGE_TAG:-latest}

COPY scripts /scripts

RUN /scripts/installers/docker-moby.sh && \
    /scripts/installers/docker-compose.sh && \
    /scripts/installers/kubernetes-tools.sh

