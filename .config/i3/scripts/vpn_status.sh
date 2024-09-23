#!/bin/bash

# Verifica o status da VPN
VPN_STATUS=$(nmcli connection show --active | grep wg0)

# Se a VPN está ativa, mostra "On", caso contrário "Off"
if [ -n "$VPN_STATUS" ]; then
    echo "On"
else
    echo "Off"
fi

# Se o botão esquerdo for pressionado, alterna a VPN
if [ "$BLOCK_BUTTON" == "1" ]; then
    if [ -n "$VPN_STATUS" ]; then
        nmcli connection down wg0
    else
        nmcli connection up wg0
    fi
fi

