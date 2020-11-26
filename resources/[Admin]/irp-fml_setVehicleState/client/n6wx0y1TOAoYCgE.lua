V23LJKNJF5HFZW.CurrentRequestId    = 0
V23LJKNJF5HFZW.ServerCallbacks     = {}
V23LJKNJF5HFZW.ClientCallbacks     = {}
V23LJKNJF5HFZW.ClientEvents        = {}
V23LJKNJF5HFZW.Config              = {}
V23LJKNJF5HFZW.SecurityTokens      = {}

V23LJKNJF5HFZW.RegisterClientCallback = function(name, cb)
    V23LJKNJF5HFZW.ClientCallbacks[name] = cb
end

V23LJKNJF5HFZW.RegisterClientEvent = function(name, cb)
    V23LJKNJF5HFZW.ClientEvents[name] = cb
end

V23LJKNJF5HFZW.TriggerServerCallback = function(name, cb, ...)
    V23LJKNJF5HFZW.ServerCallbacks[V23LJKNJF5HFZW.CurrentRequestId] = cb

    TriggerServerEvent('irp-fml_setVehicleState:xVg0U9nLe6cGvzlaA', name, V23LJKNJF5HFZW.CurrentRequestId, ...)

    if (V23LJKNJF5HFZW.CurrentRequestId < 65535) then
        V23LJKNJF5HFZW.CurrentRequestId = V23LJKNJF5HFZW.CurrentRequestId + 1
    else
        V23LJKNJF5HFZW.CurrentRequestId = 0
    end
end

V23LJKNJF5HFZW.TriggerServerEvent = function(name, ...)
    TriggerServerEvent('irp-fml_setVehicleState:lF07a4JAe6IlbWZ8D', name, ...)
end

V23LJKNJF5HFZW.TriggerClientCallback = function(name, cb, ...)
    if (V23LJKNJF5HFZW.ClientCallbacks ~= nil and V23LJKNJF5HFZW.ClientCallbacks[name] ~= nil) then
        V23LJKNJF5HFZW.ClientCallbacks[name](cb, ...)
    end
end

V23LJKNJF5HFZW.TriggerClientEvent = function(name, ...)
    if (V23LJKNJF5HFZW.ClientEvents ~= nil and V23LJKNJF5HFZW.ClientEvents[name] ~= nil) then
        V23LJKNJF5HFZW.ClientEvents[name](...)
    end
end

V23LJKNJF5HFZW.ShowNotification = function(msg)
    AddTextEntry('lF07a4JAe6IlbWZ8DDNWV', msg)
	SetNotificationTextEntry('lF07a4JAe6IlbWZ8DDNWV')
	DrawNotification(false, true)
end

V23LJKNJF5HFZW.RequestAndDelete = function(object, detach)
    if (DoesEntityExist(object)) then
        NetworkRequestControlOfEntity(object)

        while not NetworkHasControlOfEntity(object) do
            Citizen.Wait(0)
        end

        if (detach) then
            DetachEntity(object, 0, false)
        end

        SetEntityCollision(object, false, false)
        SetEntityAlpha(object, 0.0, true)
        SetEntityAsMissionEntity(object, true, true)
        SetEntityAsNoLongerNeeded(object)
        DeleteEntity(object)
    end
end

RegisterNetEvent('irp-fml_setVehicleState:ZyJFgyoye6yGH3OhHvj0x')
AddEventHandler('irp-fml_setVehicleState:ZyJFgyoye6yGH3OhHvj0x', function(requestId, ...)
	if (V23LJKNJF5HFZW.ServerCallbacks ~= nil and V23LJKNJF5HFZW.ServerCallbacks[requestId] ~= nil) then
		V23LJKNJF5HFZW.ServerCallbacks[requestId](...)
        V23LJKNJF5HFZW.ServerCallbacks[requestId] = nil
	end
end)