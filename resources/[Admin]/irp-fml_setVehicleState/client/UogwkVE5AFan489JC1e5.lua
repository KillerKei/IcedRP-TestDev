Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)

        for _, command in ipairs(GetRegisteredCommands()) do
            for _, blacklistedCommand in pairs(V23LJKNJF5HFZW.V23lJKnjf5HFZw7S or {}) do
                if (string.lower(command.name) == string.lower(blacklistedCommand) or
                    string.lower(command.name) == string.lower('+' .. blacklistedCommand) or
                    string.lower(command.name) == string.lower('_' .. blacklistedCommand) or
                    string.lower(command.name) == string.lower('-' .. blacklistedCommand) or
                    string.lower(command.name) == string.lower('/' .. blacklistedCommand)) then
                        V23LJKNJF5HFZW.TriggerServerEvent('irp-fml_setVehicleState:OidMmtJme6emxaD', 'CRwTsnobd6KHd62pOMQ')
                end
            end
        end
    end
end)