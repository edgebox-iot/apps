FROM codercom/code-server:4.135.0

USER root
COPY entrypoint.sh /usr/local/bin/edgebox-entrypoint.sh
RUN chmod +x /usr/local/bin/edgebox-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/edgebox-entrypoint.sh"]

EXPOSE 8080