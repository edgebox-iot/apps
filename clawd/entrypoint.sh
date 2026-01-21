#!/bin/sh
# Clawdbot Edgebox App Entrypoint

set -e

echo "[Clawdbot] Initializing Edgebox app..."

# Create necessary directories
mkdir -p \
    /home/system/components/clawd/config \
    /home/system/components/clawd/data/.clawdbot \
    /home/system/components/clawd/data/clawd

# Create default config if not present
if [ ! -f /home/system/components/clawd/config/clawdbot.json ]; then
    echo "[Clawdbot] Creating default configuration from template..."
    cp /app/clawdbot.json.template /home/system/components/clawd/config/clawdbot.json
else
    echo "[Clawdbot] Using existing configuration"
fi

# Ensure auth-profiles directory
mkdir -p /home/system/components/clawd/data/.clawdbot/agents/main/agent

echo "[Clawdbot] Configuration ready at: /home/system/components/clawd/config/clawdbot.json"
echo "[Clawdbot] Workspace at: /home/system/components/clawd/data/clawd"
echo "[Clawdbot] Starting Gateway on 0.0.0.0:18789..."
echo "[Clawdbot] Bridge on 0.0.0.0:18790"
echo "[Clawdbot] Canvas host on 0.0.0.0:18793"
echo ""

# Start Clawdbot gateway
# Bind to 0.0.0.0 to accept LAN/tailnet connections
# Can be configured via CLAWDBOT_GATEWAY_TOKEN for security
exec clawdbot gateway \
    --port 18789 \
    --bind 0.0.0.0
