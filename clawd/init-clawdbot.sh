#!/bin/sh
# Clawdbot Edgebox App - Zero-config Initialization
# Configures Clawdbot with environment variables on first startup

set -e

WORKSPACE="${CLAWDBOT_WORKSPACE:-/home/system/components/clawd/data/clawd}"
STATE_DIR="${CLAWDBOT_STATE_DIR:-/home/system/components/clawd/data/.clawdbot}"
MAIN_AGENT_DIR="$STATE_DIR/agents/main/agent"

# Create directories
mkdir -p "$MAIN_AGENT_DIR"

# Check if agent is already initialized
if [ -f "$MAIN_AGENT_DIR/identity.json" ]; then
    echo "[Clawdbot] Agent already initialized, skipping onboarding"
    exit 0
fi

echo "[Clawdbot] Initializing default agent with environment configuration..."

# Create identity.json with defaults from env vars or sensible defaults
cat > "$MAIN_AGENT_DIR/identity.json" << EOF
{
  "id": "main",
  "name": "${CLAWDBOT_AGENT_NAME:-Clawd}",
  "model": "${CLAWDBOT_AGENT_MODEL:-anthropic/claude-opus-4-5}",
  "type": "agent"
}
EOF

echo "[Clawdbot] Agent identity created:"
cat "$MAIN_AGENT_DIR/identity.json"

# Create a minimal settings file if it doesn't exist
if [ ! -f "$MAIN_AGENT_DIR/settings.json" ]; then
    cat > "$MAIN_AGENT_DIR/settings.json" << EOF
{
  "workspace": "$WORKSPACE",
  "capabilities": {}
}
EOF
fi

echo "[Clawdbot] Agent initialization complete!"
