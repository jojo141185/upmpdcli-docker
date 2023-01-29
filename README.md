# upmpdcli-docker: A Docker image for upmpdcli
[An UPnP Audio Media Renderer based on MPD](https://www.lesbonscomptes.com/upmpdcli/)
## Reference
This repo is forked from GioF71 and modified for my needs.

## Links
Source: [GitHub](https://github.com/jojo141185/upmpdcli-docker)  
Docker-Images: [DockerHub](https://hub.docker.com/r/jojo141185/upmpdcli)

## Why
I prepared this Dockerfile because I wanted to be able to install upmpdcli easily on multiple machines with different architectures (amd64, arm).

## Prerequisites
You need to have Docker up and running on a Linux machine, and the current user must be allowed to run containers (this usually means that the current user belongs to the "docker" group).

You can verify whether your user belongs to the "docker" group with the following command:
`getent group | grep docker`
This command will output one line if the current user does belong to the "docker" group, otherwise there will be no output.

You will also need a running instance mpd server (Music Player Daemon) on your network.  

Consider using my Mopidy-MPD docker image:

Source: [GitHub](https://github.com/jojo141185/mopidy-docker)  
Docker-Images: [DockerHub](https://hub.docker.com/r/jojo141185/mopidy)

Or alternatively, the much smaller mpd-alsa / mpd-pulseaudio docker image:

Source: [GitHub](https://github.com/jojo141185/mpd-alsa-docker)  
Docker-Images: [DockerHub](https://hub.docker.com/r/jojo141185/mpd-alsa)

## Get the image

Here is the [repository](https://hub.docker.com/repository/docker/jojo141185/upmpdcli) on DockerHub.

Getting the image from DockerHub is as simple as typing:

`docker pull jojo141185/upmpdcli:stable`

You may want to pull the "stable" image as opposed to the "latest".

## Usage

Say your mpd host is "mpd.local", you can start upmpdcli by typing

`docker run -d --rm --net host -e MPD_HOST:mpd.local jojo141185/upmpdcli:stable`

Note that ee need to use the *host* network so the upnp renderer can be discovered on your network.

In this line we define the *MPD_HOST* environment variable to connect upmpdcli to a running mpd instance on address *mpd.local*.


The following table reports the currently supported environment variables / services.

VARIABLE|DEFAULT|NOTES
---|---|---
MPD_HOST|localhost|The host where mpd runs
MPD_PORT|6600|The port used by mpd
MPD_PWD| | Passwort for mpd connection (if needed)
UPMPD_FRIENDLY_NAME|upmpd|Name of the upnpd renderer
UPNPAV_ENABLE|0|Enable UPnP AV services (0=deactivated, 1=activated)
AV_FRIENDLY_NAME|upmpd-av|Name of the upnpd renderer (av-service mode)
OPENHOME_ENABLE|1|Enable OpenHome services (0=deactivated, 1=activated)
STARTUP_DELAY_SEC|0| Delay before starting the application. This can be useful if your container is set up to start automatically.
---|---|---
DEEZER_ENABLE|false|Set to yes to enable Deezer support
DEEZER_USERNAME| |Your Deezer account username
DEEZER_PASSWORD| |Your Deezer account password
---|---|---
SPOTIFY_ENABLE|false|Set to yes to enable Spotify support
SPOTIFY_USERNAME| |Your Spotify account username
SPOTIFY_PASSWORD| |Your Spotify account password
SPOTIFY_BITRATE|160|96, 160 or 320
---|---|---
QOBUZ_ENABLE|false|Set to yes to enable Qobuz support
QOBUZ_USERNAME| |Your Qobuz account username
QOBUZ_PASSWORD| |Your Qobuz account password
QOBUZ_FORMAT_ID|5|Qobuz format id: 5 for mp3, 7 for FLAC, 27 for hi-res
---|---|---
HRA_ENABLE|false|Set to yes to enable HRA support
HRA_USERNAME| |Your HRA account username
HRA_PASSWORD| |Your HRA account password
HRA_LANG|en|language setting (en/de)
---|---|---
TIDAL_ENABLE|false|Set to yes to enable Tidal support
TIDAL_USERNAME| |Your Tidal account username
TIDAL_PASSWORD| |Your Tidal account password
TIDAL_API_TOKEN| |Your Tidal account API token
TIDAL_QUALITY|low|Tidal quality: low, high, lossless

*Note: Values with spaces are only allowed in friendly name patterns.*
<!-- 
### Currently Deprecated

VARIABLE|DEFAULT|NOTES
---|---|---
-->
## Build

You can build (or rebuild) the image by opening a terminal from the root of the repository and issuing the following command:

`docker build . -t jojo141185/upmpdcli`

It will take very little time even on a Raspberry Pi. When it's finished, you can run the container following the previous instructions.  
Just be careful to use the tag you have built.
