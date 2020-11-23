irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

irpCore.RegisterUsableItem('acid', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)
    TriggerClientEvent('doAcid', source)

    xPlayer.removeInventoryItem('acid', 1)
end)