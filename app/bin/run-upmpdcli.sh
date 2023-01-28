#!/bin/bash

TEMPLATE_CONFIG_FILE=/app/template/upmpdcli.conf
CONFIG_FILE=/app/conf/upmpdcli.conf

if test -f "$CONFIG_FILE"; then 
    echo "Configuration file [$CONFIG_FILE] already exists, skipping text substitution"
else 
    echo "Configuration file [$CONFIG_FILE] not found, copy template."
    cp $TEMPLATE_CONFIG_FILE $CONFIG_FILE
    sed -i 's/UPMPD_FRIENDLY_NAME/'"$UPMPD_FRIENDLY_NAME"'/g' $CONFIG_FILE
    sed -i 's/AV_FRIENDLY_NAME/'"$AV_FRIENDLY_NAME"'/g' $CONFIG_FILE
    sed -i 's/MPD_HOST/'"$MPD_HOST"'/g' $CONFIG_FILE
    sed -i 's/MPD_PORT/'"$MPD_PORT"'/g' $CONFIG_FILE
    echo "Deezer Enable: $DEEZER_ENABLE"
    if [ "$DEEZER_ENABLE" = true ]; then
        echo "Processing Spotify settings";
        sed -i 's/\#deezeruser/deezeruser/g' $CONFIG_FILE;
        sed -i 's/\#deezerpass/deezerpass/g' $CONFIG_FILE;
        sed -i 's/DEEZER_USERNAME/'"$DEEZER_USERNAME"'/g' $CONFIG_FILE;
        sed -i 's/DEEZER_PASSWORD/'"$DEEZER_PASSWORD"'/g' $CONFIG_FILE;
    fi
    echo "HRA Enable: $HRA_ENABLE"
    if [ "$HRA_ENABLE" = true ]; then
        echo "Processing HRA settings";
        sed -i 's/\#hrauser/hrauser/g' $CONFIG_FILE;
        sed -i 's/\#hrapass/hrapass/g' $CONFIG_FILE;
        sed -i 's/\#hralang/hralang/g' $CONFIG_FILE;
        sed -i 's/HRA_USERNAME/'"$HRA_USERNAME"'/g' $CONFIG_FILE;
        sed -i 's/HRA_PASSWORD/'"$HRA_PASSWORD"'/g' $CONFIG_FILE;
        sed -i 's/HRA_LANG/'"$HRA_LANG"'/g' $CONFIG_FILE;
    fi
    echo "Spotify Enable: $SPOTIFY_ENABLE"
    if [ "$SPOTIFY_ENABLE" = true ]; then
        echo "Processing Spotify settings";
        sed -i 's/\#spotifyuser/spotifyuser/g' $CONFIG_FILE;
        sed -i 's/\#spotifypass/spotifypass/g' $CONFIG_FILE;
        sed -i 's/\#spotifybitrate/spotifybitrate/g' $CONFIG_FILE;
        sed -i 's/SPOTIFY_USERNAME/'"$SPOTIFY_USERNAME"'/g' $CONFIG_FILE;
        sed -i 's/SPOTIFY_PASSWORD/'"$SPOTIFY_PASSWORD"'/g' $CONFIG_FILE;
        sed -i 's/SPOTIFY_BITRATE/'"$SPOTIFY_BITRATE"'/g' $CONFIG_FILE;
    fi
    echo "Tidal Enable: $TIDAL_ENABLE"
    if [ "$TIDAL_ENABLE" = true ]; then
        echo "Processing Tidal settings";
        sed -i 's/\#tidaluser/tidaluser/g' $CONFIG_FILE;
        sed -i 's/\#tidalpass/tidalpass/g' $CONFIG_FILE;
        sed -i 's/\#tidalapitoken/tidalapitoken/g' $CONFIG_FILE;
        sed -i 's/\#tidalquality/tidalquality/g' $CONFIG_FILE;
        sed -i 's/TIDAL_USERNAME/'"$TIDAL_USERNAME"'/g' $CONFIG_FILE;
        sed -i 's/TIDAL_PASSWORD/'"$TIDAL_PASSWORD"'/g' $CONFIG_FILE;
        sed -i 's/TIDAL_API_TOKEN/'"$TIDAL_API_TOKEN"'/g' $CONFIG_FILE;
        sed -i 's/TIDAL_QUALITY/'"$TIDAL_QUALITY"'/g' $CONFIG_FILE;
    fi
    echo "Qobuz Enable: $QOBUZ_ENABLE"
    if [ "$QOBUZ_ENABLE" = true ]; then
        echo "Processing Qobuz settings";
        sed -i 's/\#qobuzuser/qobuzuser/g' $CONFIG_FILE;
        sed -i 's/\#qobuzpass/qobuzpass/g' $CONFIG_FILE;
        sed -i 's/\#qobuzformatid/qobuzformatid/g' $CONFIG_FILE;
        sed -i 's/QOBUZ_USERNAME/'"$QOBUZ_USERNAME"'/g' $CONFIG_FILE;
        sed -i 's/QOBUZ_PASSWORD/'"$QOBUZ_PASSWORD"'/g' $CONFIG_FILE;
        sed -i 's/QOBUZ_FORMAT_ID/'"$QOBUZ_FORMAT_ID"'/g' $CONFIG_FILE;
    fi
#    if [ -z "${UPRCL_MEDIADIRS}" ]; then
#        echo "Variable UPRCL_MEDIADIRS not specified";
#    else
#        echo "Variable UPRCL_MEDIADIRS has been specified specified: [$UPRCL_MEDIADIRS]";
#        sed -i 's/\#uprclmediadirs/uprclmediadirs/g' $CONFIG_FILE;
#        sed -i 's/UPRCL_MEDIADIRS/'"$UPRCL_MEDIADIRS"'/g' $CONFIG_FILE;
#    fi
    cat $CONFIG_FILE
fi

echo "About to sleep for $STARTUP_DELAY_SEC second(s)"
sleep $STARTUP_DELAY_SEC
echo "Ready to start."

/usr/bin/upmpdcli -c $CONFIG_FILE

