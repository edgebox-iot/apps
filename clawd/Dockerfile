# Clawdbot AI Agent Gateway
FROM node:22-bookworm-slim

LABEL org.opencontainers.image.description="Clawdbot - AI Agent Gateway for WhatsApp, Telegram, Discord, and iMessage"

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    python3 \
    python3-pip \
    ffmpeg \
    imagemagick \
    ghostscript \
    libxcb1 \
    libxkbcommon0 \
    dumb-init \
    tini \
    && rm -rf /var/lib/apt/lists/*

# Create app user first
RUN useradd -m -u 1001 -s /bin/bash clawdbot

# Set working directory
WORKDIR /home/clawdbot

# Create necessary directories with proper permissions
RUN mkdir -p \
    /home/system/components/clawd/config \
    /home/system/components/clawd/data/.clawdbot \
    /home/system/components/clawd/data/clawd && \
    chown -R clawdbot:clawdbot /home/system/components/clawd /home/clawdbot

# Install Clawdbot as root first (npm install works better)
RUN npm install -g clawdbot@latest

# Copy scripts and config template
COPY --chown=clawdbot:clawdbot ./entrypoint.sh /app/entrypoint.sh
COPY --chown=clawdbot:clawdbot ./init-clawdbot.sh /app/init-clawdbot.sh
RUN chmod +x /app/entrypoint.sh /app/init-clawdbot.sh && chown clawdbot /app

COPY --chown=clawdbot:clawdbot ./clawdbot.json.template /app/clawdbot.json.template

# Switch to app user for runtime
USER clawdbot

# Expose ports
EXPOSE 18789 18790 18793 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:18789/health || exit 1

# Use tini to handle signals properly
ENTRYPOINT ["/usr/bin/tini", "--"]

# Start the Clawdbot gateway
CMD ["/app/entrypoint.sh"]
