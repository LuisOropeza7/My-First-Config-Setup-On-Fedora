#!/usr/bin/env bash
et -e

echo "=> Updating the system"
sudo dnf update && sudo dnf upgrade -y

echo "=> Instaling basic tools"
sudo dnf install -y \
	git \
	curl \
	wget \
	unzip \
	rsync \
	fastfetch \
	neovim \
	htop \
	sudo
