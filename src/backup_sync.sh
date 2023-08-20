#!/bin/bash

if [ ! -f $HOME/.config/.IaC/backup_sync_config ]; then
    echo "Error: backup_sync_config file not found."
    exit 1
fi

mode=$1
work_tree=$(grep "work-tree" $HOME/.config/.IaC/backup_sync_config | cut -d' ' -f2)
git_dir=$(grep "git-dir" $HOME/.config/.IaC/backup_sync_config | cut -d' ' -f2)

if [ "$mode" == "master" ]; then
    git --work-tree=$work_tree --git-dir=$git_dir add -A
    git --work-tree=$work_tree --git-dir=$git_dir commit -m "Auto backup"
    git --work-tree=$work_tree --git-dir=$git_dir pull
    git --work-tree=$work_tree --git-dir=$git_dir push
elif [ "$mode" == "slave" ]; then
    git --work-tree=$work_tree --git-dir=$git_dir pull --force
else
    echo "Error: Invalid mode. Please specify 'master' or 'slave'."
    exit 1
fi