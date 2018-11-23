package = "kong-plugin-jwt-auth-token-validate"
version = "1.0-1"
source = {
   url = "git+https://github.com/ellull/kong-validate.git"
}
description = {
   summary = "A Kong plugin to validate JWT access tokens issuer and audience claim values",
   homepage = "https://github.com/ellull/kong-validate",
   license = "MIT"
}
dependencies = {
   "lua ~> 5.1"
}
build = {
   type = "builtin",
   modules = {
      ["kong.plugins.jwt-auth-token-validate.handler"] = "handler.lua",
      ["kong.plugins.jwt-auth-token-validate.schema"] = "schema.lua"
   }
}
