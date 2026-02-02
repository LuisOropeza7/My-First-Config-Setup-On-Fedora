#!/usr/bin/env bash
DEST_BIN="/usr/local/bin/kanata"

REPO_ROOT=$(dirname "$(dirname "$(readlink -f "$0")")")
CONFIG_FILE="$REPO_ROOT/config/kanata/kanata.kbd"
DEST_CONF="$HOME/.config/kanata/kanata.kbd"

# Download Kanata from github
echo "Downloading kanata and installing kanata"

TEMP_DIR=$(mktemp -d)
ZIP_URL="https://github.com/jtroo/kanata/releases/download/v1.10.1/kanata-linux-binaries-v1.10.1-x64.zip"

curl -L "$ZIP_URL" -o "$TEMP_DIR/kanata.zip"

echo "Installing Kanata and Home Row Mods"

unzip "$TEMP_DIR/kanata.zip" -d "$TEMP_DIR"

sudo cp "$TEMP_DIR/kanata_linux_x64" "$DEST_BIN"
sudo chmod +x "$DEST_BIN"

rm -rf "$TEMP_DIR"

# Create config folder
mkdir -p "$HOME/.config/kanata"

# Create udev rules
echo 'KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/99-input.rules

# Add user to input groups
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER

# Copy the configuration file from the repo to user configuration
cp "$CONFIG_FILE" "$DEST_CONF"

# Create system service to make kanata runs even from login screens
sudo bash -c "cat <<EOF > /etc/systemd/system/kanata.service
[Unit]
Description=Kanata system-wide
DefaultDependencies=no
After=systemd-udev-settle.service
Before=display-manager.service

[Service]
Type=simple
ExecStart=/usr/local/bin/kanata --cfg /home/$USER/.config/kanata/kanata.kbd
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF"

# Make the service active
sudo systemctl daemon-reload
sudo systemctl enable kanata.service
sudo systemctl restart kanata.service
echo "¡Listo! Kanata instalado y corriendo."
