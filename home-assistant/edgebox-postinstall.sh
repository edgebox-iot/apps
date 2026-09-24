#!/bin/sh -e
# Pre-configure reverse-proxy trust for fresh installs.
#
# Since Home Assistant 2026.8 the HTTP server settings (use_x_forwarded_for,
# trusted_proxies) live in .storage/http instead of configuration.yaml. A
# fresh instance behind the Edgebox SSL-terminating proxy would otherwise
# answer 400 to every proxied request with no way to reach the UI to fix it.
# Seed the file once; never touch an existing one.
HTTP_JSON="./appdata/config/.storage/http"
if [ ! -f "$HTTP_JSON" ]; then
    mkdir -p "$(dirname "$HTTP_JSON")"
    cat > "$HTTP_JSON" <<'EOF'
{
  "version": 2,
  "minor_version": 2,
  "key": "http",
  "data": {
    "stable": {
      "server_port": 8123,
      "use_x_forwarded_for": true,
      "trusted_proxies": [
        "172.19.0.0/16",
        "127.0.0.1",
        "::1"
      ]
    }
  }
}
EOF
fi
