FROM kong:latest

ENV KONG_PLUGINS bundled, jwt-auth-token-validate

RUN luarocks install kong-plugin-jwt-auth-token-validate
RUN USER=root luarocks install kong-plugin-jwt-auth-token-validate-2.0-1.all.rock
