#!/bin/sh -e

# Ensure coder-owned working directories exist with correct ownership
# (fresh bind mounts are created root-owned, but code-server runs as uid 1000).
mkdir -p /home/coder/.config/code-server /home/coder/.local/share/code-server /home/coder/project
chown -R 1000:1000 /home/coder/.config /home/coder/.local /home/coder/project 2>/dev/null || true

exec env HOME=/home/coder setpriv --reuid=1000 --regid=1000 --clear-groups /usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 .
