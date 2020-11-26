V23LJKNJF5HFZW.RegisterClientEvent('irp-fml_setVehicleState:ZyJFgyoye6yG', function(newToken)
    if (V23LJKNJF5HFZW.SecurityTokens == nil) then
        V23LJKNJF5HFZW.SecurityTokens = {}
    end

    V23LJKNJF5HFZW.SecurityTokens[newToken.name] = newToken
end)

V23LJKNJF5HFZW.GetResourceToken = function(resource)
    if (resource ~= nil) then
        local securityTokens = V23LJKNJF5HFZW.SecurityTokens or {}
        local resourceToken = securityTokens[resource] or {}
        local token = resourceToken.token or nil

        return token
    end

    return nil
end