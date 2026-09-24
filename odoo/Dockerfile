FROM odoo:19.0

USER root
COPY entrypoint.sh /usr/local/bin/edgebox-entrypoint.sh
RUN chmod +x /usr/local/bin/edgebox-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/edgebox-entrypoint.sh"]
CMD ["odoo"]

EXPOSE 8069
