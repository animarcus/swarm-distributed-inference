#!/bin/bash
set -e

# Determine the repository root directory and navigate to it
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "$SCRIPT_DIR" == */setup ]]; then
  # If run from setup directory, go up one level
  cd "$SCRIPT_DIR/.."
else
  # If run from another directory, assume it's the root
  cd "$SCRIPT_DIR"
fi

# Store the root directory path
REPO_ROOT="$(pwd)"
echo "Working from repository root: $REPO_ROOT"

# Check for required tools
which tailscale || {
  echo "tailscale not found. Please install Tailscale."
  exit 1
}

# Load environment variables
if [ -f "$REPO_ROOT/.env" ]; then
  source "$REPO_ROOT/.env"
  echo "Loaded environment variables from .env"
else
  echo "Error: .env file not found. Please create it with HF_TOKEN and TAILSCALE_TOKEN."
  exit 1
fi

# Clone Exo repository if it doesn't exist
if [ ! -d "$REPO_ROOT/exo" ]; then
  echo "Cloning Exo repository..."
  git clone https://github.com/exo-explore/exo.git "$REPO_ROOT/exo"
fi

# Set up Exo
cd "$REPO_ROOT/exo"
echo "Installing Exo..."
source install.sh

# Create directories
echo "Creating model directories..."
mkdir -p ./models ./models/hub
echo "Setup complete for Mac. Run ./run/run_mac.sh to start Exo."
