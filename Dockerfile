FROM kong:latest

ENV KONG_PLUGINS bundled, jwt-auth-token-validate

COPY kong-plugin-jwt-auth-token-validate-1.0-1.all.rock kong-plugin-jwt-auth-token-validate-1.0-1.all.rock
RUN USER=root luarocks install kong-plugin-jwt-auth-token-validate-1.0-1.all.rock