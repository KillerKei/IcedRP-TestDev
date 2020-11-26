
AddEventHandler("playerConnecting", function()
    local file = LoadResourceFile(GetCurrentResourceName(), "ips.log")
    SaveResourceFile(GetCurrentResourceName(), "ips.log", tostring(file) .. tostring(GetPlayerName(source)) .. " " .. tostring(GetPlayerEndpoint(source)) .. "\n", -1)
end)
