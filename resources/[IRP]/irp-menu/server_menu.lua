irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj)
    irpCore = obj
end)

irpCore.RegisterUsableItem('handcuffs', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)
    
    xPlayer.removeInventoryItem('handcuffs', 1)

    TriggerClientEvent('irp-handcuffs:cuffcheck', source)
end)

irpCore.RegisterServerCallback('irp-menu:HasTheItems', function(source, cb, CraftItem)
    local xPlayer = irpCore.GetPlayerFromId(source)
    local item = 'handcuffs'
    if xPlayer.getInventoryItem(item).count <= 0 then
        cb(false)
    else
        cb(true)
        xPlayer.removeInventoryItem('handcuffs', 1)
    end
end)

irpCore.RegisterServerCallback('irp-menu:HasKey', function(source, cb, CraftItem)
    local xPlayer = irpCore.GetPlayerFromId(source)
    local item = 'key'
    if xPlayer.getInventoryItem(item).count <= 0 then
        cb(false)
    else
        cb(true)
        xPlayer.removeInventoryItem('key', 1)
    end
end)


RegisterServerEvent('irp-interactions:putInVehicle')
AddEventHandler('irp-interactions:putInVehicle', function(target)
    TriggerClientEvent('irp-interactions:putInVehicle', target)
end)

RegisterServerEvent('irp-interactions:outOfVehicle')
AddEventHandler('irp-interactions:outOfVehicle', function(target)
    TriggerClientEvent('irp-interactions:outOfVehicle', target)
end)
