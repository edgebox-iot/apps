
# Base image to base the app container on
FROM nginxdemos/hello:0.4
LABEL org.opencontainers.image.description Hello is a scaffolding edgeapp template.

# Add / Replace Files in the Container
ADD ./src/build/hello.conf /etc/nginx/conf.d/

# Port to expose from the container into the host
EXPOSE 80