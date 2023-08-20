#!/bin/bash
#shellcheck disable=SC1091
SCRIPT_FILE=$(basename "$0")
FILE_NO_EXT="${SCRIPT_FILE%.*}"
export DISPLAY=:0.0

VPN="$1"; [[ -z "$VPN" ]] && notify-send "$FILE_NO_EXT" "Expected VPN name as first argument" && exit 1
network_ID=$(nmcli connection show | grep "$VPN" | awk '{print $4}'); [[ -z "$network_ID" ]] && notify-send "$FILE_NO_EXT" "VPN not found (network_ID)" && exit 1
VPN_ID=$(nmcli con | grep "$VPN" | awk '{print $2}')

#if network_ID is '--' then the VPN is not connected
if [ "$network_ID" = "--" ]; then
    nmcli con up "$VPN_ID" || notify-send "$FILE_NO_EXT" "Error conecting to VPN"
else
    nmcli con down "$VPN_ID" || notify-send "$FILE_NO_EXT" "Error disconecting from VPN"
fi
