irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

irpCore.RegisterUsableItem('redbandana', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:redbandana', source)
end)

irpCore.RegisterUsableItem('greenbandana', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:greenbandana', source)
end)

irpCore.RegisterUsableItem('purplebandana', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:purplebandana', source)
end)

irpCore.RegisterUsableItem('yellowbandana', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:yellowbandana', source)
end)

irpCore.RegisterUsableItem('bluebandana', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:bluebandana', source)
end)

irpCore.RegisterUsableItem('whitebandana', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:whitebandana', source)
end)

irpCore.RegisterUsableItem('blackbandana', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:blackbandana', source)
end)

irpCore.RegisterUsableItem('orangebandana', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:orangebandana', source)
end)