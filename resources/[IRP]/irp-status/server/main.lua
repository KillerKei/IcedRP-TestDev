irpCore                    = nil
local RegisteredStatus = {}

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

AddEventHandler('irp:playerLoaded', function(source)
	local _source        = source
	local xPlayer        = irpCore.GetPlayerFromId(_source)

	MySQL.Async.fetchAll(
		'SELECT * FROM users WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local data = {}

			if result[1].status ~= nil then
				data = json.decode(result[1].status)
			end

			xPlayer.set('status', data)

			TriggerClientEvent('irp-status:load', _source, data)

		end
	)

end)

AddEventHandler('irp:playerDropped', function(source)
	local _source = source
	local xPlayer = irpCore.GetPlayerFromId(_source)

	local data   = {}
	local status = xPlayer.get('status')

	MySQL.Async.execute(
		'UPDATE users SET status = @status WHERE identifier = @identifier',
		{
			['@status']     = json.encode(status),
			['@identifier'] = xPlayer.identifier
		}
	)

end)

AddEventHandler('irp-status:getStatus', function(playerId, statusName, cb)
	local xPlayer = irpCore.GetPlayerFromId(playerId)
	local status  = xPlayer.get('status')

	for i=1, #status, 1 do
		if status[i].name == statusName then
			cb(status[i])
			break
		end
	end

end)

RegisterServerEvent('irp-status:update')
AddEventHandler('irp-status:update', function(status)
	local _source = source
	local xPlayer = irpCore.GetPlayerFromId(_source)
	
	if xPlayer ~= nil then
		xPlayer.set('status', status)
	end
end)

function SaveData()
	local xPlayers = irpCore.GetPlayers()
	
	for i=1, #xPlayers, 1 do

		local xPlayer = irpCore.GetPlayerFromId(xPlayers[i])
		local data    = {}
		local status  = xPlayer.get('status')

		MySQL.Async.execute(
			'UPDATE users SET status = @status WHERE identifier = @identifier',
		 	{
		 		['@status']     = json.encode(status),
		 		['@identifier'] = xPlayer.identifier
		 	}
		)
	
	end

	SetTimeout(10 * 60 * 1000, SaveData)
end

SaveData()