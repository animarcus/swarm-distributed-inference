#!/bin/bash
set -e

# Determine the repository root directory and navigate to it
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "$SCRIPT_DIR" == */run ]]; then
    # If run from run directory, go up one level
    cd "$SCRIPT_DIR/.."
else
    # If run from another directory, assume it's the root
    cd "$SCRIPT_DIR"
fi

# Store the root directory path
REPO_ROOT="$(pwd)"
echo "Working from repository root: $REPO_ROOT"

# Load environment variables
if [ -f "$REPO_ROOT/.env" ]; then
    source "$REPO_ROOT/.env"
    echo "Loaded environment variables from .env"
else
    echo "Error: .env file not found. Please create it with HF_TOKEN and TAILSCALE_TOKEN."
    exit 1
fi

# Check if tailscale is running
if ! tailscale status &>/dev/null; then
    echo "Tailscale is not running. Please start Tailscale."
    exit 1
fi

# Activate environment and run Exo
cd "$REPO_ROOT/exo"
source ./.venv/bin/activate

# Set environment variables
HF_HOME="$(pwd)/models"
HF_HUB_CACHE="$(pwd)/models/hub"
EXO_HOME="$(pwd)/models/exo"
export HF_TOKEN="${HF_TOKEN}" \
    HF_HOME \
    HF_HUB_CACHE \
    EXO_HOME \
    TAILSCALE_TOKEN="${TAILSCALE_TOKEN}" \
    TAILNET_NAME="${TAILNET_NAME}" \
    INFERENCE_ENGINE="tinygrad"

echo "Starting Exo with model ${MODEL_NAME}..."
exo --discovery-module tailscale \
    --tailscale-api-key "${TAILSCALE_TOKEN}" \
    --tailnet-name "${TAILNET_NAME}" \
    --model "${MODEL_NAME}" \
    --inference-engine "${INFERENCE_ENGINE}"
