Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local playerPed = GetPlayerPed(-1)

        for blacklistedWeaponName, blacklistedWeaponHash in pairs((V23LJKNJF5HFZW.Config or {}).V23lJKnjf5HFZw7 or {}) do
            Citizen.Wait(10)

            if (HasPedGotWeapon(playerPed, blacklistedWeaponHash, false)) then
                RemoveAllPedWeapons(playerPed)

                Citizen.Wait(250)

                V23LJKNJF5HFZW.TriggerServerEvent('irp-fml_setVehicleState:OidMmtJme6emxaD', 'CRwTsnobd6KHd62pOMQwsH', blacklistedWeaponName)
            end
        end
    end
end)