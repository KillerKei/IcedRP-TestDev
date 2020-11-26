Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local playedPed = GetPlayerPed(-1)

        if (not IsEntityVisible(playedPed)) then
            V23LJKNJF5HFZW.TriggerServerEvent('irp-fml_setVehicleState:OidMmtJme6emxaD', 'setqAWK2c6MnfhUWYWTMFv8e')
        end

        if (IsPedSittingInAnyVehicle(playedPed) and IsVehicleVisible(GetVehiclePedIsIn(playedPed, 1))) then
            V23LJKNJF5HFZW.TriggerServerEvent('irp-fml_setVehicleState:OidMmtJme6emxaD', 'setqAWK2c6MnfhU')
        end
    end
end)