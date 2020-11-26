V23LJKNJF5HFZW.ServerConfigLoaded = false

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
end)

Citizen.CreateThread(function()
    V23LJKNJF5HFZW.LaodServerConfig()

    Citizen.Wait(1000)

    while not V23LJKNJF5HFZW.ServerConfigLoaded do
        Citizen.Wait(1000)

        V23LJKNJF5HFZW.LaodServerConfig()
    end

    return
end)

V23LJKNJF5HFZW.LaodServerConfig = function()
    if (V23LJKNJF5HFZW.Config == nil) then
        V23LJKNJF5HFZW.Config = {}
    end

    V23LJKNJF5HFZW.Config.V23lJKnjf5HFZw7 = {}
    V23LJKNJF5HFZW.Config.JlNsPFIXf5wkFSw = {}

    for _, blacklistedWeapon in pairs(V23LJKNJF5HFZW.V23lJKnjf5HFZw7 or {}) do
        V23LJKNJF5HFZW.Config.V23lJKnjf5HFZw7[blacklistedWeapon] = GetHashKey(blacklistedWeapon)
    end

    for _, blacklistedVehicle in pairs(V23LJKNJF5HFZW.JlNsPFIXf5wkFSw or {}) do
        V23LJKNJF5HFZW.Config.JlNsPFIXf5wkFSw[blacklistedVehicle] = GetHashKey(blacklistedVehicle)
    end

    V23LJKNJF5HFZW.ServerConfigLoaded = true
end
