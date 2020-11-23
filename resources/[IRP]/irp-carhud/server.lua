irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

RegisterServerEvent('carfill:pay')
AddEventHandler('carfill:pay', function(cash)
    local source = source
    local xPlayer = irpCore.GetPlayerFromId(source)
    if cash > 0 then
        xPlayer.removeMoney(cash)
    end
end)