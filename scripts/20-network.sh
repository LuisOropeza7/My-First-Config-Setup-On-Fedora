#!/usr/bin/env bash
set -e

echo "Instalando paquetes de red..."

sudo dnf install \
	avahi \
	avahi-tools \
	nss-mdns \
	firewall-config
