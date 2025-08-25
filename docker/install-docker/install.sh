##############################################
# Fast Install Script - Docker + Docker Compose
#
# Description:
# Installs the latest stable Docker on:
# - Ubuntu (20.04 / 22.04 / newer)
# - Debian (10 / 11 / 12)
#
# Tested on Hetzner and OVH VPS (August 2025).
#
# Author: vikaar996 (ViKaar Dev)
# GitHub: https://github.com/vikaar996/fast-install-scripts
##############################################

#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Colors for output
GREEN="\033[0;32m"
NC="\033[0m" # No Color

# Function for printing status messages
log() {
  echo -e "${GREEN}>>> $1${NC}"
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run this script as root (sudo)."
  exit 1
fi

log "Updating package list..."
apt-get update -y

log "Installing required dependencies..."
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

log "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

log "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

log "Updating package list again..."
apt-get update -y

log "Installing Docker Engine..."
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin

log "Adding current user to the docker group..."
usermod -aG docker "${SUDO_USER:-$USER}"

log "Installing Docker Compose (v2.x)..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)

curl -SL "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose

log "✅ Installation complete!"
docker --version
docker-compose --version

##############################################
# Fast Install Script - Docker + Docker Compose
#
# Description:
# Installs the latest stable Docker on:
# - Ubuntu (20.04 / 22.04 / newer)
# - Debian (10 / 11 / 12)
#
# Tested on Hetzner and OVH VPS (August 2025).
#
# Author: vikaar996 (ViKaar Dev)
# GitHub: https://github.com/vikaar996/fast-install-scripts
##############################################
