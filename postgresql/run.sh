#!/bin/bash

source /etc/default_user.sh

POSTGRESQL_BIN=/usr/lib/postgresql/9.4/bin/postgres
POSTGRESQL_CONFIG_FILE=/etc/postgresql/9.4/main/postgresql.conf
POSTGRESQL_DATA=/data

POSTGRESQL_CMD="sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE"

shopt -s nullglob
shopt -s dotglob # To include hidden files
files=($POSTGRESQL_DATA/*)

if [ ! -d $POSTGRESQL_DATA ] || [ ${#files[@]} -eq 0 ]; then
    mkdir -p $POSTGRESQL_DATA
    chown -R postgres:postgres $POSTGRESQL_DATA
    chmod -R 0700 $POSTGRESQL_DATA
    sudo -u postgres /usr/lib/postgresql/9.4/bin/initdb -D $POSTGRESQL_DATA -E 'UTF-8'

    $POSTGRESQL_CMD <<< "CREATE USER $POSTGRESQL_USER WITH SUPERUSER;" > /dev/null
    $POSTGRESQL_CMD <<< "ALTER USER $POSTGRESQL_USER WITH PASSWORD '$POSTGRESQL_PASS';" > /dev/null
    $POSTGRESQL_CMD <<< "CREATE DATABASE $POSTGRESQL_DB OWNER $POSTGRESQL_USER TEMPLATE $POSTGRESQL_TEMPLATE;" > /dev/null
fi

exec sudo -u postgres $POSTGRESQL_BIN  -D POSTGRESQL_DATA --config-file=$POSTGRESQL_CONFIG_FILE