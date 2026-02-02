#!/usr/bin/env bash
set -e

# This script is meant to be the base for networking usage
# It installs the necesar packages to make basic networking operations such as
# Make devices discovarable.
echo "Installing network packages"

sudo dnf install \
	avahi \
	avahi-tools \
	nss-mdns \
	firewall-config
