#!/bin/bash

TEMPLATE_CONFIG_FILE=/app/template/upmpdcli.conf
CONFIG_FILE=/app/conf/upmpdcli.conf


if test -f "$CONFIG_FILE"; then 
    echo "Configuration file [$CONFIG_FILE] already exists, skipping text substitution"
else 
    echo "Configuration file [$CONFIG_FILE] not found, copy template."
    cp $TEMPLATE_CONFIG_FILE $CONFIG_FILE
fi

# Change config from environment variables
if [ -n "${UPMPD_FRIENDLY_NAME}" ]; then sed -i 's/^ *#* *friendlyname *= *[^#]*/friendlyname = '"${UPMPD_FRIENDLY_NAME}"'/' $CONFIG_FILE; fi
if [ -n "${AV_FRIENDLY_NAME}" ]; then sed -i 's/^ *#* *avfriendlyname *= *[^#]*/avfriendlyname = '"${AV_FRIENDLY_NAME}"'/' $CONFIG_FILE; fi
if [ -n "${MS_FRIENDLY_NAME}" ]; then sed -i 's/^ *#* *msfriendlyname *= *[^#]*/msfriendlyname = '"${MS_FRIENDLY_NAME}"'/' $CONFIG_FILE; fi

if [ -n "${MPD_HOST}" ]; then sed -i 's/^ *#* *mpdhost *= *[^ ]*/mpdhost = '"${MPD_HOST}"'/' $CONFIG_FILE; fi
if [ -n "${MPD_PORT}" ]; then sed -i 's/^ *#* *mpdport *= *[^ ]*/mpdport = '"${MPD_PORT}"'/' $CONFIG_FILE; fi
if [ -n "${MPD_PWD}" ]; then sed -i 's/^ *#* *mpdpassword *= *[^ ]*/mpdpassword = '"${MPD_PWD}"'/' $CONFIG_FILE; fi
if [ -n "${UPNPAV_ENABLE}" ]; then sed -i 's/^ *#* *upnpav *= *[^ ]*/upnpav = '"${UPNPAV_ENABLE}"'/' $CONFIG_FILE; fi
if [ -n "${OPENHOME_ENABLE}" ]; then sed -i 's/^ *#* *openhome *= *[^ ]*/openhome = '"${OPENHOME_ENABLE}"'/' $CONFIG_FILE; fi
if [ -n "${OPENHOME_ENABLE}" ]; then sed -i 's/^ *#* *openhome *= *[^ ]*/openhome = '"${OPENHOME_ENABLE}"'/' $CONFIG_FILE; fi
if [ "$DEEZER_ENABLE" = true ]; then
    if [ -n "${DEEZER_USERNAME}" ]; then sed -i 's/^ *#* *deezeruser *= *[^ ]*/deezeruser = '"${DEEZER_USERNAME}"'/' $CONFIG_FILE; fi
    if [ -n "${DEEZER_PASSWORD}" ]; then sed -i 's/^ *#* *deezerpass *= *[^ ]*/deezerpass = '"${DEEZER_PASSWORD}"'/' $CONFIG_FILE; fi
else
    sed -i 's/^ *# *deezeruser *= *[^ ]*/#deezeruser = /' $CONFIG_FILE
    sed -i 's/^ *# *deezerpass *= *[^ ]*/#deezerpass = /' $CONFIG_FILE
fi
if [ "$HRA_ENABLE" = true ]; then
    if [ -n "${HRA_USERNAME}" ]; then sed -i 's/^ *#* *hrauser *= *[^ ]*/hrauser = '"${HRA_USERNAME}"'/' $CONFIG_FILE; fi
    if [ -n "${HRA_PASSWORD}" ]; then sed -i 's/^ *#* *hrapass *= *[^ ]*/hrapass = '"${HRA_PASSWORD}"'/' $CONFIG_FILE; fi
    if [ -n "${HRA_LANG}" ]; then sed -i 's/^ *#* *hralang *= *[^ ]*/hralang = '"${HRA_LANG}"'/' $CONFIG_FILE; fi
else
    sed -i 's/^ *# *hrauser *= *[^ ]*/#hrauser = /' $CONFIG_FILE
    sed -i 's/^ *# *hrapass *= *[^ ]*/#hrapass = /' $CONFIG_FILE
    sed -i 's/^ *# *hralang *= *[^ ]*/#hralang = /' $CONFIG_FILE
fi
if [ "$SPOTIFY_ENABLE" = true ]; then
    if [ -n "${SPOTIFY_USERNAME}" ]; then sed -i 's/^ *#* *spotifyuser *= *[^ ]*/spotifyuser = '"${SPOTIFY_USERNAME}"'/' $CONFIG_FILE; fi
    if [ -n "${SPOTIFY_PASSWORD}" ]; then sed -i 's/^ *#* *spotifypass *= *[^ ]*/spotifypass = '"${SPOTIFY_PASSWORD}"'/' $CONFIG_FILE; fi
    if [ -n "${SPOTIFY_BITRATE}" ]; then sed -i 's/^ *#* *spotifybitrate *= *[^ ]*/spotifybitrate = '"${SPOTIFY_BITRATE}"'/' $CONFIG_FILE; fi
else
    sed -i 's/^ *# *spotifyuser *= *[^ ]*/#spotifyuser = /' $CONFIG_FILE
    sed -i 's/^ *# *spotifypass *= *[^ ]*/#spotifypass = /' $CONFIG_FILE
    sed -i 's/^ *# *spotifybitrate *= *[^ ]*/#spotifybitrate = /' $CONFIG_FILE
fi
if [ "$TIDAL_ENABLE" = true ]; then
    if [ -n "${TIDAL_USERNAME}" ]; then sed -i 's/^ *#* *tidaluser *= *[^ ]*/tidaluser = '"${TIDAL_USERNAME}"'/' $CONFIG_FILE; fi
    if [ -n "${TIDAL_PASSWORD}" ]; then sed -i 's/^ *#* *tidalpass *= *[^ ]*/tidalpass = '"${TIDAL_PASSWORD}"'/' $CONFIG_FILE; fi
    if [ -n "${TIDAL_API_TOKEN}" ]; then sed -i 's/^ *#* *tidalapitoken *= *[^ ]*/tidalapitoken = '"${TIDAL_API_TOKEN}"'/' $CONFIG_FILE; fi
    if [ -n "${TIDAL_QUALITY}" ]; then sed -i 's/^ *#* *tidalquality *= *[^ ]*/tidalquality = '"${TIDAL_QUALITY}"'/' $CONFIG_FILE; fi
else
    sed -i 's/^ *# *tidaluser *= *[^ ]*/#tidaluser = /' $CONFIG_FILE
    sed -i 's/^ *# *tidalpass *= *[^ ]*/#tidalpass = /' $CONFIG_FILE
    sed -i 's/^ *# *tidalapitoken *= *[^ ]*/#tidalapitoken = /' $CONFIG_FILE
    sed -i 's/^ *# *tidalquality *= *[^ ]*/#tidalquality = /' $CONFIG_FILE
fi
if [ "$QOBUZ_ENABLE" = true ]; then
    if [ -n "${QOBUZ_USERNAME}" ]; then sed -i 's/^ *#* *qobuzuser *= *[^ ]*/qobuzuser = '"${QOBUZ_USERNAME}"'/' $CONFIG_FILE; fi
    if [ -n "${QOBUZ_PASSWORD}" ]; then sed -i 's/^ *#* *qobuzpass *= *[^ ]*/qobuzpass = '"${QOBUZ_PASSWORD}"'/' $CONFIG_FILE; fi
    if [ -n "${QOBUZ_FORMAT_ID}" ]; then sed -i 's/^ *#* *qobuzformatid *= *[^ ]*/qobuzformatid = '"${QOBUZ_FORMAT_ID}"'/' $CONFIG_FILE; fi
else
    sed -i 's/^ *# *qobuzuser *= *[^ ]*/#qobuzuser = /' $CONFIG_FILE
    sed -i 's/^ *# *qobuzpass *= *[^ ]*/#qobuzpass = /' $CONFIG_FILE
    sed -i 's/^ *# *qobuzformatid *= *[^ ]*/#qobuzformatid = /' $CONFIG_FILE
fi

echo "About to sleep for $STARTUP_DELAY_SEC second(s)"
sleep $STARTUP_DELAY_SEC

echo "Trying to start UPNPDCli with configuration:" 
cat $CONFIG_FILE

/usr/bin/upmpdcli -c $CONFIG_FILE

