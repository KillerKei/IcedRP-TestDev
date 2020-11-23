irpCore               = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

irpCore.RegisterUsableItem('blowtorch', function(source)
    local xPlayer = irpCore.GetPlayerFromId(source)
    local blowtorch = xPlayer.getInventoryItem('blowtorch')

    xPlayer.removeInventoryItem('blowtorch', 1)
    TriggerClientEvent('irp-blowtorch:startblowtorch', source)
end)

