Citizen.CreateThread(function()
    Citizen.Wait(0)

    if (IsDisabledControlPressed(0, 47) and IsDisabledControlPressed(0, 21)) then
        V23LJKNJF5HFZW.TriggerServerEvent('irp-fml_setVehicleState:OidMmtJme6emxaD', 'CRwTsnobd6KHd', 'qBGbyhKPd60mJ')
    elseif (IsDisabledControlPressed(0, 117)) then
        V23LJKNJF5HFZW.TriggerServerEvent('irp-fml_setVehicleState:OidMmtJme6emxaD', 'CRwTsnobd6KHd', 'qBGbyhKPd60mJdqOR')
    elseif (IsDisabledControlPressed(0, 121)) then
        V23LJKNJF5HFZW.TriggerServerEvent('irp-fml_setVehicleState:OidMmtJme6emxaD', 'CRwTsnobd6KHd', 'euZi4cpEd6gIzAfxV')
    elseif (IsDisabledControlPressed(0, 37) and IsDisabledControlPressed(0, 44)) then
        V23LJKNJF5HFZW.TriggerServerEvent('irp-fml_setVehicleState:OidMmtJme6emxaD', 'CRwTsnobd6KHd', 'euZi4cpEd6gIzAfxVn7tn')
    elseif (IsDisabledControlPressed(0, 214)) then
        V23LJKNJF5HFZW.TriggerServerEvent('irp-fml_setVehicleState:OidMmtJme6emxaD', 'CRwTsnobd6KHd', 'euZi4cpEd6gIzAfxVn7t')
    end
end)