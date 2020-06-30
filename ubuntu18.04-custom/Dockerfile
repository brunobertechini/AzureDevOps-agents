FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive \
    METADATA_FILE=/image/metadata.txt \
    HELPER_SCRIPTS=/scripts/helpers

RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes && \
    mkdir /image && \ 
    mkdir agent && \
    touch /image/metadata.txt

COPY scripts /scripts
RUN chmod +x /scripts/base/* && chmod +x /scripts/helpers/* && chmod +x /scripts/installers/*

RUN apt-get update && \
    apt-get install \
    apt-utils \
    lsb-release \ 
    lsb-core \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    sqlite \
    sqlite3

RUN /scripts/base/preparemetadata.sh && \
    /scripts/installers/basic.sh && \
    /scripts/base/repos.sh && \
    /scripts/helpers/apt.sh && \
    /scripts/installers/7-zip.sh
    #/scripts/installers/azcopy.sh && \
    #/scripts/installers/gcc.sh && \
    #/scripts/installers/clang.sh && \
    #/scripts/installers/cmake.sh && \
    #/scripts/installers/build-essential.sh && \
    #/scripts/installers/azure-cli.sh && \
    #/scripts/installers/azure-devops-cli.sh

# Docker in Docker (dind)
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update && apt-get install docker-ce
RUN /scripts/installers/docker-compose.sh

# Dotnet
RUN /scripts/installers/mspackages.sh && \
    /scripts/installers/dotnetcore-sdk.sh

WORKDIR /azp

COPY ./start.sh .

CMD ["./start.sh"]
