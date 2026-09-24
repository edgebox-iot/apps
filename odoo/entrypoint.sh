#!/bin/bash -e

# Generate a default odoo.conf on first install (Odoo 19 entrypoint
# requires the [options] section to exist) and fix ownership of the
# mounted data volumes (odoo runs as uid 100).
CONF_FILE="/etc/odoo/odoo.conf"
if [ ! -f "$CONF_FILE" ]; then
    mkdir -p "$(dirname "$CONF_FILE")"
    printf '[options]\ndb_host = odoo-db\ndb_port = 5432\ndb_user = odoo\ndb_password = odoo\n' > "$CONF_FILE"
fi
chown -R 100:101 /var/lib/odoo /mnt/extra-addons /etc/odoo 2>/dev/null || true

exec /entrypoint.sh "$@"
