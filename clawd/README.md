# Clawdbot - AI Agent Gateway EdgeApp

**Clawdbot** is an AI agent gateway that integrates WhatsApp, Telegram, Discord, and iMessage into a unified control plane. This EdgeApp runs Clawdbot as a centralized hub that local instances can connect to.

## Overview

- 🤖 **AI-Powered**: Integrates Claude (Anthropic) and other LLMs via Pi agent
- 📱 **Multi-Channel**: WhatsApp, Telegram, Discord, iMessage all in one place
- 🌐 **Distributed**: Central gateway with local client connections
- 🔒 **Secure**: Token-based auth, per-agent sandboxing
- 🎛️ **Configurable**: Dashboard UI for channel setup and credentials

## Quick Start

### Installation

```bash
# Clone or sync the edgebox-iot/apps repo
cd ~/Repositories/edgebox-iot/apps

# Build locally
make build apps="clawd"

# Run locally
make run apps="clawd"
```

Access the dashboard at: **http://clawd.local**

### Configuration

The Clawdbot gateway is configurable via the Edgebox dashboard. Key settings:

- **Telegram Bot Token**: Get from [@BotFather](https://t.me/BotFather)
- **Discord Bot Token**: Create at [Discord Developer Portal](https://discord.com/developers)
- **Gateway Token**: Optional security token for remote access
- **Primary Model**: Which LLM to use (default: Claude Opus 4.5)

### Ports

- **18789**: Gateway WebSocket (loopback by default, use token for remote)
- **18790**: Bridge for iOS/Android node pairing
- **18793**: Canvas host (WebView assets)
- **80**: Web UI (reverse-proxied via Traefik)

## Architecture

```
┌─────────────────────────────────┐
│   Edgebox System                │
│   ┌─────────────────────────┐   │
│   │  Clawdbot Gateway       │   │
│   │  - WhatsApp/Telegram    │   │
│   │  - Discord/iMessage     │   │
│   │  - WebChat UI           │   │
│   │  - Auth Management      │   │
│   └─────────────────────────┘   │
│         ↑              ↓          │
│   ┌─────────────────────────┐   │
│   │ Traefik Reverse Proxy   │   │
│   │ (clawd.local)           │   │
│   └─────────────────────────┘   │
└─────────────────────────────────┘
         ↑
    LAN / Tailnet
         ↓
┌─────────────────────────────────┐
│  Local Clawdbot (Mac/Linux)     │
│  Connects to central Gateway    │
└─────────────────────────────────┘
```

## Local Client Configuration

To connect a local Clawdbot instance to this central gateway:

```json
{
  "gateway": {
    "bind": "remote",
    "host": "clawd.local",
    "port": 18789,
    "token": "${CLAWDBOT_GATEWAY_TOKEN}"
  },
  "agents": {
    "defaults": {
      "workspace": "~/clawd-local"
    }
  }
}
```

## File Structure

```
clawd/
├── Dockerfile                    # Node 22 + Clawdbot
├── entrypoint.sh                # Init script
├── clawdbot.json.template       # Default config
├── edgebox-compose.yml          # Docker Compose config
├── edgebox.env                  # Metadata (EDGEAPP_NAME, etc.)
├── edgeapp.template.env         # Config variables for dashboard
├── edgeapp-icon.png             # App icon
├── edgebox-postinstall.sh       # Post-install hook
└── src/                         # Static assets (if any)
```

## Environment Variables

| Variable | Type | Required | Description |
|----------|------|----------|-------------|
| `TELEGRAM_BOT_TOKEN` | string | false | Telegram Bot API token |
| `DISCORD_BOT_TOKEN` | string | false | Discord Bot token |
| `CLAWDBOT_GATEWAY_TOKEN` | string | false | Security token for remote access |
| `CLAWDBOT_PRIMARY_MODEL` | string | false | Primary LLM (default: claude-opus-4-5) |
| `ANTHROPIC_API_KEY` | string | false | Anthropic API key |
| `OPENAI_API_KEY` | string | false | OpenAI API key (fallback) |

## Persistence

- **Config**: `/home/system/components/clawd/config/clawdbot.json`
- **Workspace**: `/home/system/components/clawd/data/clawd`
- **State**: `/home/system/components/clawd/data/.clawdbot`

Data persists across container restarts via Docker volumes.

## Extending

### Add a New Agent

Edit `clawdbot.json`:

```json
{
  "agents": {
    "list": [
      { "id": "main", "workspace": "..." },
      { "id": "work", "workspace": "..." }
    ]
  },
  "bindings": [
    { "agentId": "work", "match": { "channel": "discord" } }
  ]
}
```

### Multi-instance Setup

Run multiple app instances with different ports:

```bash
# Instance 1
docker-compose -p clawd-1 up -d

# Instance 2
docker-compose -p clawd-2 up -d
```

## Troubleshooting

### Health Check Fails

```bash
# Check logs
docker logs edgebox-clawd-ws

# Verify ports are open
lsof -i :18789
```

### Can't Connect from Local Client

- Ensure `CLAWDBOT_GATEWAY_TOKEN` is set in both gateway and client
- Check network connectivity: `ping clawd.local`
- Verify firewall allows port 18789

### Channel Credentials Not Loading

- Set env variables in docker-compose or Edgebox dashboard
- Restart the container after changing credentials
- Check logs for auth errors

## Resources

- **Clawdbot Docs**: https://docs.clawd.bot
- **Clawdbot GitHub**: https://github.com/clawdbot/clawdbot
- **Edgebox Docs**: https://edgebox.io
- **Clawdbot Discord**: https://discord.com/invite/clawd

## License

MIT - Same as Clawdbot
