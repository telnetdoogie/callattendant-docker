#!/bin/sh
USER_CONFIG_DIR=$CONFIG_DIR
TEMPLATE_DIR=/app/config_template

# Check if the config directory is empty
if [ "`ls -A $USER_CONFIG_DIR 2>/dev/null`" = "" ]; then
    echo "Config directory is empty. Initializing with default configs..."
    cp -r $TEMPLATE_DIR/* $CONFIG_DIR/
fi

# Proceed with the normal startup command
callattendant --data-path $USER_CONFIG_DIR --config $USER_CONFIG_DIR/app.cfg
