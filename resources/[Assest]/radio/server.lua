irpCore               = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

irpCore.RegisterUsableItem('radio', function(source)

	local xPlayer = irpCore.GetPlayerFromId(source)
	TriggerClientEvent('radioGui', source)

end)