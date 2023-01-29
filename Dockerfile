ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS base

LABEL maintainer="jojo141185"
LABEL source="https://github.com/jojo141185/upmpdcli-docker"

# Set Architecture Variables
ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT
RUN printf "I'm building for TARGETPLATFORM=${TARGETPLATFORM}" \
    && printf ", TARGETARCH=${TARGETARCH}" \
    && printf ", TARGETVARIANT=${TARGETVARIANT} \n"
    
# Switch to the root user while we do our changes
USER root

# Non-interactive setup
ARG DEBIAN_FRONTEND=noninteractive

# Set Timezone
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required Debian packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    wget \
    curl \
    gpg \
    dirmngr \
    ca-certificates \
    git \
    build-essential \
    sudo \
  && rm -rf /var/lib/apt/lists/*

# ======
# Install UPnP Media Renderer front-end for MPD
#
# Include upmpdcli official Repo
# RUN mkdir -p /usr/share/keyrings \
#   && wget -q -O /usr/share/keyrings/lesbonscomptes.gpg https://www.lesbonscomptes.com/pages/lesbonscomptes.gpg
# ARG REPO_ARM=https://www.lesbonscomptes.com/upmpdcli/pages/upmpdcli-rbuster.list
# ARG REPO_AMD64=https://www.lesbonscomptes.com/upmpdcli/pages/upmpdcli-buster.list
# RUN if [ "$TARGETARCH" = "arm" ]; then \
# 	wget -q -O /etc/apt/sources.list.d/upmpdcli.list $REPO_ARM ; \
#     elif [ "$TARGETARCH" = "amd64" ]; then \
#     	wget -q -O /etc/apt/sources.list.d/upmpdcli.list $REPO_AMD64 ; \
#     else \
# 	wget -q -O /etc/apt/sources.list.d/upmpdcli.list $REPO_AMD64 ; \
#     fi
    
# Include additional PPA Repo
RUN apt-get update \
  && apt-get install -y \
    software-properties-common \
    exiftool \
  && add-apt-repository ppa:jean-francois-dockes/upnpp1 \
  && rm -rf /var/lib/apt/lists/*

# Install packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    upmpdcli \
    upmpdcli-* \
  && rm -rf /var/lib/apt/lists/*

# Cleanup
RUN apt-get remove -y \
	software-properties-common \
  && apt-get autoremove -y

# Run and generate default config file
RUN upmpdcli -v

RUN mkdir -p /app
RUN mkdir -p /app/template
RUN mkdir -p /app/conf
RUN mkdir -p /app/doc

RUN cp /etc/upmpdcli.conf /app/conf/original.upmpdcli.conf

VOLUME /uprcl/confdir
VOLUME /uprcl/mediadirs
VOLUME /user/config
VOLUME /cache
VOLUME /log

COPY app/template/upmpdcli.conf /app/template/upmpdcli.conf

COPY app/bin/run-upmpdcli.sh /app/bin/run-upmpdcli.sh
RUN chmod +x /app/bin/run-upmpdcli.sh

COPY README.md /app/doc

WORKDIR /app/bin

ENTRYPOINT ["/app/bin/run-upmpdcli.sh"]
