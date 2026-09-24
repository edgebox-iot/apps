#!/bin/bash -e

# Ensure the mounted storage volume is writable for the rails user
# (fresh bind mounts are created root-owned, but the app runs as uid 1000).
mkdir -p /rails/storage
chown -R 1000:1000 /rails/storage 2>/dev/null || true

exec setpriv --reuid=1000 --regid=1000 --clear-groups /rails/bin/docker-entrypoint ./bin/thrust ./bin/rails server
