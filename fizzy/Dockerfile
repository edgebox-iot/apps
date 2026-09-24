FROM ghcr.io/basecamp/fizzy:main
LABEL org.opencontainers.image.description="Fizzy is a simple project management tool using Kanban boards."

USER root
COPY entrypoint.sh /usr/local/bin/edgebox-entrypoint.sh
RUN chmod +x /usr/local/bin/edgebox-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/edgebox-entrypoint.sh"]

EXPOSE 80 443
