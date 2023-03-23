#!/bin/bash
set -e

if [ "$METADATA_JSON" = "" ]; then
    export METADATA_JSON=/mnt/metadata.json
fi
if [ "$DOT_ENV" = "" ]; then
    export DOT_ENV=/mnt/.env
fi

if [ "$CHALLENGE" = "yes" ]; then
    chmod 700 $METADATA_JSON
    chown root:root $METADATA_JSON

    [ -f $DOT_ENV ] && {
        chmod 400 $DOT_ENV
        chown root:root $DOT_ENV
        cat $DOT_ENV
        . $DOT_ENV
    } || {
        echo "No .env file found"
    }


    function execute() {
        su -c "$*" ctf
    }
else
    echo "Not in challenge mode"
    function execute() {
        sh -c "$*"
    }
fi

function extract_field() {
    cat $METADATA_JSON | jq "$1" -r
}

execute $*
exit

case $1 in
    init)
        execute "$(extract_field .tasks.init)"
        ;;
    runtime)
        execute "$(extract_field .tasks.runtime)"
        ;;
    daemon)
        execute "$(extract_field .tasks.daemon)"
        ;;
    debug)
        execute "exec $SHELL"
        ;;
    root)
        exec $SHELL
        ;;
    *)
        echo "Unknown command: $1"
        exit 1
        ;;
esac