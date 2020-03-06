local responses = require "kong.tools.responses"
local jwt_decoder = require "kong.plugins.jwt.jwt_parser"
local ngx_re_gmatch = ngx.re.gmatch



local function retrieve_token(authorization_header, conf)

--    local authorization_header = request.get_headers()["authorization"]
    if authorization_header then
        local iterator, iter_err = ngx_re_gmatch(authorization_header, "\\s*[Bb]earer\\s+(.+)")
        if not iterator then
            return nil, iter_err
        end
        local m, err = iterator()
        if err then
          return nil, err
        end
        if m and #m > 0 then
            return m[1]
        end
    end 
end

local _M = {}


function _M:validation(authorization_header,conf)
    if authorization_header == nil then
        return responses.send_HTTP_UNAUTHORIZED("Request is nil")
    end

    local token, err = retrieve_token(authorization_header, conf)
    if err and not continue_on_error then
      return responses.send_HTTP_INTERNAL_SERVER_ERROR(err)
    end
  
    if not token and not continue_on_error then
      return responses.send_HTTP_UNAUTHORIZED()
    end
  
    local jwt, err = jwt_decoder:new(token)

    if err and not continue_on_error then
      return responses.send_HTTP_INTERNAL_SERVER_ERROR()
    end

    local claims = jwt.claims
    local issuer = conf.issuer
    local audience = conf.audience

    if claims["iss"] == nil then
        return responses.send_HTTP_UNAUTHORIZED("JSON Web Token has null issuer")
    end
    if claims["iss"]~=issuer then
        return responses.send_HTTP_UNAUTHORIZED("JSON Web Token has invalid issuer '"..claims["iss"].."'")
    end
    if claims["aud"] == nil then
        return responses.send_HTTP_UNAUTHORIZED("JSON Web Token has null audience")
    end
    if claims["aud"]~=audience then
        return responses.send_HTTP_UNAUTHORIZED("JSON Web Token has invalid audience '"..claims["aud"].."'")
    end
end


return _M