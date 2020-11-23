irpCore = nil 

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

irpCore.RegisterUsableItem('silencieux', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('silencieux', 1)
    TriggerClientEvent('nfw_wep:silencieux', source)
end)

irpCore.RegisterUsableItem('flashlight', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('flashlight', 1)
    TriggerClientEvent('nfw_wep:flashlight', source)
end)

irpCore.RegisterUsableItem('grip', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('grip', 1)
    TriggerClientEvent('nfw_wep:grip', source)
end)

irpCore.RegisterUsableItem('yusuf', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('yusuf', 1)
    TriggerClientEvent('nfw_wep:yusuf', source)
end)

irpCore.RegisterUsableItem('SmallArmor', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('SmallArmor', 1)
    TriggerClientEvent('nfw_wep:SmallArmor', source)
end)

irpCore.RegisterUsableItem('MedArmor', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('MedArmor', 1)
    TriggerClientEvent('nfw_wep:MedArmor', source)
end)

irpCore.RegisterUsableItem('HeavyArmor', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('HeavyArmor', 1)
    TriggerClientEvent('nfw_wep:HeavyArmor', source)
end)

--[[irpCore.RegisterUsableItem('HeavyArmor', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('HeavyArmor', 1)
    TriggerClientEvent('nfw_wep:HeavyArmor', source)
end)]]

irpCore.RegisterUsableItem('lowrider', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('lowrider', 1)
    TriggerClientEvent('nfw_wep:lowrider', source)
end)

irpCore.RegisterUsableItem('pAmmo', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('pAmmo', 1)
    TriggerClientEvent('nfw_wep:pAmmo', source)
end)

irpCore.RegisterUsableItem('fAmmo', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('fAmmo', 1)
    TriggerClientEvent('nfw_wep:fAmmo', source)
end)

irpCore.RegisterUsableItem('mgAmmo', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('mgAmmo', 1)
    TriggerClientEvent('nfw_wep:mgAmmo', source)
end)

irpCore.RegisterUsableItem('arAmmo', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('arAmmo', 1)
    TriggerClientEvent('nfw_wep:arAmmo', source)
end)

irpCore.RegisterUsableItem('sgAmmo', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('sgAmmo', 1)
    TriggerClientEvent('nfw_wep:sgAmmo', source)
end)

RegisterNetEvent('returnItem')
AddEventHandler('returnItem', function(item)
    local xPlayer = irpCore.GetPlayerFromId(source)

    xPlayer.addInventoryItem(item, 1)
end)