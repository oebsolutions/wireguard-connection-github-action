#!/bin/bash

echo "<<<=== Connect to WireGuard GitHub Action ===>>>"

# Variables
INTERFACE_PRIVATE_KEY=${INTERFACE_PRIVATE_KEY}
INTERFACE_ADDRESS=${INTERFACE_ADDRESS}
PEER_PUBLIC_KEY=${PEER_PUBLIC_KEY}
PEER_ALLOWED_IPS=${PEER_ALLOWED_IPS}
PEER_ENDPOINT=${PEER_ENDPOINT}


# Generate GitHub side wireguard configuration
cat > github.conf <<EOT
[Interface]
PrivateKey = ${INTERFACE_PRIVATE_KEY}
Address = ${INTERFACE_ADDRESS}
[Peer]
PublicKey = ${PEER_PUBLIC_KEY}
Endpoint = ${PEER_ENDPOINT}
AllowedIPs = ${PEER_ALLOWED_IPS}
PersistentKeepalive = 20
EOT

# Dependencies
sudo DEBIAN_FRONTEND=noninteractive apt-get -qq update
sudo DEBIAN_FRONTEND=noninteractive apt-get -yqq install wireguard-dkms

sudo cp github.conf /etc/wireguard

# Bring up tunnel, abort on failure
sudo wg-quick up github || exit 1

echo "<<<=== Connect to WireGuard GitHub Action ===>>>"