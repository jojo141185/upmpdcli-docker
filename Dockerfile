ARG BASE_IMAGE
FROM ${BASE_IMAGE} AS base

# Set Architecture Variables
ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT
RUN printf "I'm building for TARGETPLATFORM=${TARGETPLATFORM}" \
    && printf ", TARGETARCH=${TARGETARCH}" \
    && printf ", TARGETVARIANT=${TARGETVARIANT} \n"
    
# Switch to the root user while we do our changes
USER root

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

# Install UPnP Media Renderer front-end for MPD
RUN mkdir -p /usr/share/keyrings \
  && wget -q -O /usr/share/keyrings/lesbonscomptes.gpg https://www.lesbonscomptes.com/pages/lesbonscomptes.gpg
  
ARG REPO_ARM=https://www.lesbonscomptes.com/upmpdcli/pages/upmpdcli-rbuster.list
ARG REPO_AMD64=https://www.lesbonscomptes.com/upmpdcli/pages/upmpdcli-buster.list
RUN if [ "$TARGETARCH" = "arm" ]; then \
	wget -q -O /etc/apt/sources.list.d/upmpdcli.list $REPO_ARM ; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
    	wget -q -O /etc/apt/sources.list.d/upmpdcli.list $REPO_ARM ; \
    elif [ "$TARGETARCH" = "amd64" ]; then \
    	wget -q -O /etc/apt/sources.list.d/upmpdcli.list $REPO_AMD64 ; \
    else \
    	wget -q -O /etc/apt/sources.list.d/upmpdcli.list $REPO_AMD64 ; \
    fi

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    upmpdcli \
    upmpdcli-qobuz \
    upmpdcli-spotify \
    upmpdcli-tidal \
  && rm -rf /var/lib/apt/lists/*
  
RUN upmpdcli -v

RUN mkdir -p /app
RUN mkdir -p /app/conf
RUN mkdir -p /app/doc

RUN cp /etc/upmpdcli.conf /app/conf/original.upmpdcli.conf

ENV UPMPD_FRIENDLY_NAME upmpd
ENV AV_FRIENDLY_NAME upmpd-av

ENV MPD_HOST localhost
ENV MPD_PORT 6600

ENV TIDAL_ENABLE no
ENV TIDAL_USERNAME tidal_username
ENV TIDAL_PASSWORD tidal_password
ENV TIDAL_API_TOKEN tidal_api_token
ENV TIDAL_QUALITY low

ENV QOBUZ_ENABLE no
ENV QOBUZ_USERNAME qobuz_username
ENV QOBUZ_PASSWORD qobuz_password
ENV QOBUZ_FORMAT_ID 5

ENV STARTUP_DELAY_SEC 0

#ENV UPRCL_MEDIADIRS ""

VOLUME /var/cache/upmpdcli
#VOLUME /media-dir

COPY app/conf/upmpdcli.conf /app/conf/upmpdcli.conf

COPY app/bin/run-upmpdcli.sh /app/bin/run-upmpdcli.sh
RUN chmod u+x /app/bin/run-upmpdcli.sh

COPY README.md /app/doc

WORKDIR /app/bin

ENTRYPOINT ["/app/bin/run-upmpdcli.sh"]