#!/bin/bash -e

# Ensure database directory exists in the mounted volume
mkdir -p /rails/storage/db
chown -R 1000:1000 /rails/storage 2>/dev/null || true

# Enable jemalloc for reduced memory usage and latency
if [ -f /usr/lib/*/libjemalloc.so.2 ]; then
  export LD_PRELOAD="$(echo /usr/lib/*/libjemalloc.so.2) $LD_PRELOAD"
fi

exec "$@"
