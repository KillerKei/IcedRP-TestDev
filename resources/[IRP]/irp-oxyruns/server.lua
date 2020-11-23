irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)


RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function(money)
    local source = source
    local xPlayer = irpCore.GetPlayerFromId(source)
    if xPlayer.getMoney() >= money then
        xPlayer.removeMoney(money)
        TriggerClientEvent('oxydelivery:startDealing', source)
        TriggerClientEvent('oxydelivery:client', source)
    else
        TriggerClientEvent('DoLongHudText', source, 'You do not have enough money to start', 2)
    end
end)

RegisterServerEvent('drugdelivery:server')
AddEventHandler('drugdelivery:server', function(amount)
    local source = source
    local xPlayer = irpCore.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('vicodin').count >= 12 then
        xPlayer.removeInventoryItem('vicodin', 1)
        Citizen.Wait(5)
        xPlayer.removeInventoryItem('vicodin', 1)
        Citizen.Wait(5)
        xPlayer.removeInventoryItem('vicodin', 1)
        Citizen.Wait(5)
        xPlayer.removeInventoryItem('vicodin', 1)
        Citizen.Wait(5)
        xPlayer.removeInventoryItem('vicodin', 1)
        Citizen.Wait(5)
        xPlayer.removeInventoryItem('vicodin', 1)
        Citizen.Wait(5)
        xPlayer.removeInventoryItem('vicodin', 1)
        Citizen.Wait(5)
        xPlayer.removeInventoryItem('vicodin', 1)
        Citizen.Wait(5)
        xPlayer.removeInventoryItem('vicodin', 1)
        Citizen.Wait(5)
        xPlayer.removeInventoryItem('vicodin', 1)
        Citizen.Wait(5)
        xPlayer.removeInventoryItem('vicodin', 1)
        Citizen.Wait(5)
        xPlayer.removeInventoryItem('vicodin', 1)
        Citizen.Wait(5)
        xPlayer.addMoney(math.random(400, 700))

        TriggerClientEvent('DoLongHudText', source, 'Thanks for the oxy, holla at me another time', 2)
    else
        TriggerClientEvent('DoLongHudText', source, "I don't want that shit homes", 2)
    end
end)