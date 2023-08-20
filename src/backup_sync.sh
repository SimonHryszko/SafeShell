#!/bin/bash

if [ ! -f "$HOME/.config/.IaC" ]; then
    echo "Error: file '$HOME/.config/.IaC' not found. Run IaC!"
    exit 1
fi

mode=$1
work_tree=$(grep "backup_work_tree" "$HOME/.config/.IaC" | awk -F= '{print $2}')
git_dir=$(grep "backup_dest" "$HOME/.config/.IaC" | awk -F= '{print $2}')

if [ "$mode" == "master" ]; then
    echo "Committing changes..."
    git --work-tree="$work_tree" --git-dir="$git_dir" commit -am "Auto backup"

    echo "Pulling changes..."
    git --work-tree="$work_tree" --git-dir="$git_dir" pull

    echo "Pushing changes..."
    git --work-tree="$work_tree" --git-dir="$git_dir" push
elif [ "$mode" == "slave" ]; then
    git --work-tree="$work_tree" --git-dir="$git_dir" pull --force
else
    echo "Error: Invalid mode. Please specify 'master' or 'slave'."
    exit 1
fi