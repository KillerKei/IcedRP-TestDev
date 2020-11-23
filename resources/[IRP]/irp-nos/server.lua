irpCore = nil

RegisterServerEvent("checkNOS")
AddEventHandler("checkNOS", function()
    local xPlayer = irpCore.GetPlayerFromId(source)
    while not xPlayer do Citizen.Wait(0); xPlayer = irpCore.GetPlayerFromId(source); end
    local item = xPlayer.getInventoryItem('nitro')
    return item.count or 0
  end)

RegisterServerEvent('takeNOSFromInventory')
AddEventHandler('takeNOSFromInventory', function()
    local xPlayer = irpCore.GetPlayerFromId(source)
    while not xPlayer do Citizen.Wait(0); xPlayer = irpCore.GetPlayerFromId(source); end
    xPlayer.removeInventoryItem('nitro',1)
end)

RegisterServerEvent("eff_sound_start")
AddEventHandler("eff_sound_start", function(entity)
	TriggerClientEvent("c_eff_sound_start", -1, entity)
end)

RegisterServerEvent("eff_sound_stop")
AddEventHandler("eff_sound_stop", function(entity)
	TriggerClientEvent("c_eff_sound_stop", -1, entity)
end)

RegisterServerEvent("flameEffect")
AddEventHandler("flameEffect", function(entity)
	TriggerClientEvent("cFlameEffect", -1, entity)
end)