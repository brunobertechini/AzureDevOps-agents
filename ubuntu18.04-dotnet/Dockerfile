ARG FROM_IMAGE
ARG FROM_IMAGE_TAG

FROM ${FROM_IMAGE:-devopsubuntu18.04}:${FROM_IMAGE_TAG:-latest}

COPY scripts /scripts

ENV AGENT_TOOLSDIRECTORY=/_work/_tool

RUN /scripts/installers/mspackages.sh && \
    /scripts/installers/dotnetcore-sdk.sh && \
    /scripts/installers/powershellcore.sh && \
    /scripts/installers/azpowershell.sh
