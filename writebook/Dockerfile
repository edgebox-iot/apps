FROM ghcr.io/basecamp/writebook:latest
LABEL org.opencontainers.image.description="Writebook is an easy-to-use application for publishing content on the web."

USER root
COPY entrypoint.sh /usr/local/bin/edgebox-entrypoint.sh
RUN chmod +x /usr/local/bin/edgebox-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/edgebox-entrypoint.sh"]
CMD ["bin/boot"]

EXPOSE 80 443
