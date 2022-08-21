# upmpdcli-docker - a Docker image for upmpdcli
[An UPnP Audio Media Renderer based on MPD](https://www.lesbonscomptes.com/upmpdcli/)
## Reference
This repo is forked from GioF71 and modified for my needs.

## Links

Source: [GitHub](https://github.com/jojo141185/upmpdcli-docker)  
Docker-Images: [DockerHub](https://hub.docker.com/r/jojo141185/upmpdcli)

## Why

I prepared this Dockerfile Because I wanted to be able to install upmpdcli easily on any machine (provided the architecture is amd64 or arm).

## Prerequisites

You need to have Docker up and running on a Linux machine, and the current user must be allowed to run containers (this usually means that the current user belongs to the "docker" group).

You can verify whether your user belongs to the "docker" group with the following command:
`getent group | grep docker`
This command will output one line if the current user does belong to the "docker" group, otherwise there will be no output.

You will also need a running instance mpd server (Music Player Daemon) on your network.  
Consider using my
- mopidy-mpd docker image:
Source: [GitHub](https://github.com/jojo141185/mopidy-docker)  
Docker-Images: [DockerHub](https://hub.docker.com/r/jojo141185/mopidy)

OR alternatively the smaller mpd-alsa / mpd-pulseaudio docker image:
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

Note that we have used the *MPD_HOST* environment variable so that upmpdcli can use the mpd instance running on *mpd.local*.

We also need to use the *host* network so the upnp renderer can be discovered on your network.

The following tables reports all the currently supported environment variables.

VARIABLE|DEFAULT|NOTES
---|---|---
MPD_HOST|localhost|The host where mpd runs
MPD_PORT|6600|The port used by mpd
UPMPD_FRIENDLY_NAME|upmpd|Name of the upnpd renderer
AV_FRIENDLY_NAME|upmpd-av|Name of the upnpd renderer (av mode)
TIDAL_ENABLE|no|Set to yes to enable Tidal support
TIDAL_USERNAME|tidal_username|Your Tidal account username
TIDAL_PASSWORD|tidal_password|Your Tidal account password
TIDAL_API_TOKEN|tidal_api_token|Your Tidal account API token
TIDAL_QUALITY|low|Tidal quality: low, high, lossless
QOBUZ_ENABLE|no|Set to yes to enable Qobuz support
QOBUZ_USERNAME|qobuz_username|Your Qobuz account username
QOBUZ_PASSWORD|qobuz_password|Your Qobuz account password
QOBUZ_FORMAT_ID|5|Qobuz format id: 5 for mp3, 7 for FLAC, 27 for hi-res
STARTUP_DELAY_SEC|0| Delay before starting the application. This can be useful if your container is set up to start automatically, so that you can resolve race conditions with mpd and with squeezelite if all those services run on the same audio device. I experienced issues with my Asus Tinkerboard, while the Raspberry Pi has never really needed this. Your mileage may vary. Feel free to report your personal experience.

## Build

You can build (or rebuild) the image by opening a terminal from the root of the repository and issuing the following command:

`docker build . -t jojo141185/upmpdcli`

It will take very little time even on a Raspberry Pi. When it's finished, you can run the container following the previous instructions.  
Just be careful to use the tag you have built.
