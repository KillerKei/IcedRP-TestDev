irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

RegisterServerEvent('l79q12-815j:74-8915-811-9814')
AddEventHandler('l79q12-815j:74-8915-811-9814', function()

	local xPlayer = irpCore.GetPlayerFromId(source)

	Citizen.Wait(50)
	xPlayer.addInventoryItem('wood', Config.Wood)
	Citizen.Wait(50)
end)

RegisterServerEvent('l79q12-815j:8975-4329-10-834')
AddEventHandler('l79q12-815j:8975-4329-10-834', function()

	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.addInventoryItem('cutted_wood', 100)
	Citizen.Wait(50)
	xPlayer.removeInventoryItem('wood', 100)
end)

RegisterServerEvent('l79q12-815j:894-45-1648-444')
AddEventHandler('l79q12-815j:894-45-1648-444', function()

	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.addInventoryItem('packaged_plank', 100)
	Citizen.Wait(50)
	xPlayer.removeInventoryItem('cutted_wood', 100)
	Citizen.Wait(50)
end)

RegisterServerEvent('l79q12-815j:41-84-1651-6915')
AddEventHandler('l79q12-815j:41-84-1651-6915', function(quantity)

	local _source = source
	local xPlayer = irpCore.GetPlayerFromId(_source)
	local fattura  = math.floor(quantity * 2.50)

	xPlayer.addMoney(fattura)
	TriggerClientEvent('DoLongHudText', _source, 'You have been paid $'..fattura..' . Keep up the hard work!', 1)
	Citizen.Wait(10)
	xPlayer.removeInventoryItem('packaged_plank', quantity)
	Citizen.Wait(10)
end)

-- irp-lumberjack = l79q12-815j

-- irp-lumberjack:legnatagliata = 74-8915-811-9814
-- irp-lumberjack:venditablip = 41-84-1651-6915
-- irp-lumberjack:tavole = 894-45-1648-444
-- irp-lumberjack:segatura = 8975-4329-10-834