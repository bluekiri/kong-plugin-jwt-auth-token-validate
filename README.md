kong-plugin-jwt-auth-token-validate
===================================

Install
-------

Clone the repository and then from the cloned directory, as root:
```
# luarocks make --pack-binary-rock kong-plugin-jwt-auth-token-validate-1.0-1.rockspec
```

### Docker
Build image:
```
# docker build -t kong:latest .
```
Start Kong 
```
docker run -d --name kong   --network=kong-net   -e 'KONG_DATABASE=postgres'   -e 'KONG_PG_HOST=kong-database'   -e 'KONG_PROXY_ACCESS_LOG=/dev/stdout'   -e 'KONG_ADMIN_ACCESS_LOG=/dev/stdout'   -e 'KONG_PROXY_ERROR_LOG=/dev/stderr'   -e 'KONG_ADMIN_ERROR_LOG=/dev/stderr'   -e 'KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl'   -p 8000:8000   -p 8443:8443   -p 8001:8001   -p 8444:8444   kong:latest
```
### Configuration

Post via curl
```
curl -X POST http://localhost:8001/services/<my_service_id>/plugins \
--data 'name=jwt-auth-token-validate' \
--data 'config.issuer=<my_issuer_url>' \
--data 'config.audience=<my_audience_id>'
```
