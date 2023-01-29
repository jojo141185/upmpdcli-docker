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
    lsb-release \
    gpg \
    ca-certificates \
    sudo \
  && rm -rf /var/lib/apt/lists/*



# ======
# Install UPnP Media Renderer front-end for MPD
#
# Install upmpdcli from official Repo (DEBIAN)
RUN mkdir -p /usr/share/keyrings \
  #&& gpg --no-default-keyring --keyring /usr/share/keyrings/lesbonscomptes.gpg --keyserver keyserver.ubuntu.com --recv-key F8E3347256922A8AE767605B7808CE96D38B9201 \
  && wget -q -O /usr/share/keyrings/lesbonscomptes.gpg https://www.lesbonscomptes.com/pages/lesbonscomptes.gpg \
  && if [ "$TARGETARCH" = "arm" ]; then \
      REPO_TARGET="raspbian"; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
    	REPO_TARGET="raspbian"; \
    elif [ "$TARGETARCH" = "amd64" ]; then \
    	REPO_TARGET="debian"; \
    else \
      echo "Unknown Target in use with upmpdcli repository. Try amd64 debian as default." \
	    && REPO_TARGET="debian"; \
    fi \
  && echo "deb [signed-by=/usr/share/keyrings/lesbonscomptes.gpg] http://www.lesbonscomptes.com/upmpdcli/downloads/${REPO_TARGET}/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/upmpdcli.list

# # Install upmpdcli from PPA Repo (UBUNTU) 
# RUN apt-get update \
#   && apt-get install -y \
#     software-properties-common \
#   && add-apt-repository ppa:jean-francois-dockes/upnpp1 \
#   && rm -rf /var/lib/apt/lists/*
#   && apt-get remove -y \
#	software-properties-common

# Install packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    upmpdcli \
    upmpdcli-* \
  && rm -rf /var/lib/apt/lists/*

# Cleanup
RUN apt-get remove -y \
	lsb-release \
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
