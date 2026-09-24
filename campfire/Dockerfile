FROM ghcr.io/basecamp/once-campfire:1.4.9
LABEL org.opencontainers.image.description="Campfire is a simple, self-hosted team chat application."

# Fix CSRF origin check when behind SSL-terminating proxy:
# We need assume_ssl=true (so request.base_url uses https://) but
# force_ssl=false (to avoid redirect loop with the nginx proxy).
RUN mkdir -p /rails/config/initializers && \
    printf "Rails.application.config.assume_ssl = true\nRails.application.config.force_ssl = false\n" \
    > /rails/config/initializers/assume_ssl.rb

EXPOSE 80 443
