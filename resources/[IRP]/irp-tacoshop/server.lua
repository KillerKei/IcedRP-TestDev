irpCore                = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

RegisterServerEvent('weed:checkmoney')
AddEventHandler('weed:checkmoney', function()
    local source = source
    local xPlayer  = irpCore.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('weed4g').count >= 1 then
        TriggerClientEvent('weed:successStart', source)
    else
        TriggerClientEvent('DoLongHudText', source, "The taco did not seem dank enough.", 2)
    end
end)

RegisterServerEvent('player:receiveItem')
AddEventHandler('player:receiveItem', function(item, count)
    local source = source
    local xPlayer  = irpCore.GetPlayerFromId(source)
    Citizen.Wait(5)
    xPlayer.addInventoryItem(item, tonumber(count))
    TriggerClientEvent('irp-inventory:refreshInventory', source)
    return
end)

RegisterServerEvent('inventory:removeItem')
AddEventHandler('inventory:removeItem', function(item, count)
    local source = source
    local xPlayer  = irpCore.GetPlayerFromId(source)
    Citizen.Wait(500)
    xPlayer.removeInventoryItem(item, count)
    TriggerClientEvent('irp-inventory:refreshInventory', source)
end)

RegisterServerEvent('mission:finished')
AddEventHandler('mission:finished', function(money)
    local source = source
    local xPlayer  = irpCore.GetPlayerFromId(source)
    if money ~= nil then
        xPlayer.addMoney(money)
    end
end)

irpCore.RegisterUsableItem('weedtaco', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('weedtaco', 1)

	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 375000)
end)
-------------
irpCore.RegisterUsableItem('icecream', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('icecream', 1)

	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 275000)
end)

irpCore.RegisterUsableItem('donut', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('donut', 1)

	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 275000)
end)

irpCore.RegisterUsableItem('sandwich', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sandwich', 1)

	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 350000)
end)

irpCore.RegisterUsableItem('taco', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('taco', 1)

	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 375000)
end)

irpCore.RegisterUsableItem('fishtaco', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fishtaco', 1)

	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 375000)
end)

irpCore.RegisterUsableItem('churro', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('churro', 1)

	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 350000)
end)

irpCore.RegisterUsableItem('eggsbacon', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('eggsbacon', 1)

	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 375000)
end)

irpCore.RegisterUsableItem('hotdog', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hotdog', 1)

	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 350000)
end)

irpCore.RegisterUsableItem('coffee', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('coffee', 1)

	TriggerClientEvent('irp-basicneeds:onDrink', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'thirst', 350000)
end)

irpCore.RegisterUsableItem('mshake', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('mshake', 1)

	TriggerClientEvent('irp-basicneeds:onDrink', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'thirst', 350000)
end)

irpCore.RegisterUsableItem('greencow', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('greencow', 1)

	TriggerClientEvent('irp-basicneeds:onDrink', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'thirst', 375000)
end)

irpCore.RegisterUsableItem('burrito', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('burrito', 1)

	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 375000)
end)


local counter = 0
RegisterServerEvent('delivery:status')
AddEventHandler('delivery:status', function(status)
    if status == -1 then
        counter = 0
    elseif status == 1 then
        counter = 2
    end
    TriggerClientEvent('delivery:deliverables', -1, counter, math.random(1,14))
end)