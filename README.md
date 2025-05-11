# SWARM Distributed Inference

## Prerequisites

- Tailscale installed and logged in to AI Team account
- Python 3.12+
- AI team HuggingFace token
- Tailscale API key (get from Aaron)

## Setup

First, create your `.env` file:

```bash
HF_TOKEN="ai_team_huggingface_token"
TAILSCALE_TOKEN="tailscale_api_key_from_aaron"
TAILNET_NAME="projectsepflait.github"
MODEL_NAME="llama-3.1-8b"
```

Make scripts executable:

```bash
chmod +x setup/*.sh run/*.sh 
```

## For Mac

1. Setup:

```bash
./setup/setup_mac.sh
```

2. Run:

```bash
./run/run_mac.sh
```

## For Linux

1. Setup:

```bash
./setup/setup_linux.sh
```

2. Run:

```bash
./run/run_linux.sh
```
