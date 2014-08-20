#! /usr/bin/bash

title_pipe="/tmp/.mpc-pipe"

mpc_args=""

get_title() {
    # return the current title
    title_name=$(mpc current ${mpc_args})

    if [ ${#title_name} -gt 24 ]; then
        title_name=${title_name:0:21}"..."
    fi
    
    echo ${title_name} | tee ${title_pipe}
    # sleep 5
    # ~/bin/volume.sh
}

loop_title() {
    while true; do
        get_title
    done
}

case $1 in
    "loop")
        mpc_args=" --wait "
        loop_title
        ;;
    "ask")
        mpc_args=""
        get_title
        ;;
    *)
        exit 1
        ;;
esac

