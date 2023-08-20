#!/bin/bash

function backup_sync() {
    mode=$1
    work_tree=$(cat ~/.config | grep work-tree | cut -d' ' -f2)
    git_dir=$(cat ~/.config | grep git-dir | cut -d' ' -f2)

    if [ "$mode" == "master" ]; then
        git --work-tree=$work_tree --git-dir=$git_dir add -A
        git --work-tree=$work_tree --git-dir=$git_dir commit -m "Generic commit message"
        git --work-tree=$work_tree --git-dir=$git_dir pull
        git --work-tree=$work_tree --git-dir=$git_dir push
    elif [ "$mode" == "slave" ]; then
        git --work-tree=$work_tree --git-dir=$git_dir pull --force
    else
        echo "Error: Invalid mode. Please specify 'master' or 'slave'."
        exit 1
    fi
}

backup_sync $1

