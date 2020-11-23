irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

RegisterServerEvent('irp-motels:cancelRental')
AddEventHandler('irp-motels:cancelRental', function(room)

    local src = source
    local pid = irpCore.GetPlayerFromId(src)
    local playerIdent = pid.identifier

    MySQL.Async.execute("DELETE FROM lsrp_motels WHERE ident=@ident AND motel_id=@roomno", {['@ident'] = playerIdent, ['@roomno'] = room})
	MySQL.Async.execute("DELETE FROM disc_inventory WHERE type=@motels AND owner=@ident", {['@motels'] = "motels", ['@ident'] = playerIdent})
	MySQL.Async.execute("DELETE FROM disc_inventory WHERE type=@motelsbed AND owner=@ident", {['@motelsbed'] = "motelsbed", ['@ident'] = playerIdent})

end)

RegisterServerEvent('irp-motels:rentRoom')
AddEventHandler('irp-motels:rentRoom', function(room)

    local src = source
    local pid = irpCore.GetPlayerFromId(src)
    local playerIdent = pid.identifier

    MySQL.Sync.execute("INSERT INTO lsrp_motels (ident, motel_id) VALUES (@ident, @roomno)", {['@ident'] = playerIdent, ['@roomno'] = room})
    

end)

irpCore.RegisterServerCallback('irp-motels:getMotelRoomID', function(source, cb, room)
    local src = source
    local pid = irpCore.GetPlayerFromId(src)
    local playerIdent = pid.identifier

    MySQL.Async.fetchScalar("SELECT id FROM lsrp_motels WHERE ident=@ident AND motel_id = @room", {['@ident'] = playerIdent, ['@room'] = room}, function(rentalID)
        if rentalID ~= nil then
            cb(rentalID)
        else
            cb(false)
        end
    end)

end)

irpCore.RegisterServerCallback('irp-motels:checkOwnership', function(source, cb)
    local src = source
    local pid = irpCore.GetPlayerFromId(src)

    if pid ~= nil then
        local playerIdent = pid.identifier

        MySQL.Async.fetchScalar("SELECT motel_id FROM lsrp_motels WHERE ident = @ident", {['@ident'] = playerIdent}, function(motelRoom)
            if motelRoom ~= nil then
            cb(motelRoom)
            else
            cb(false)
            end
        end)
    end

end)

irpCore.RegisterServerCallback('irp-motels:getPlayerDressing', function(source, cb)
	local xPlayer  = irpCore.GetPlayerFromId(source)

	TriggerEvent('srp-datastore:getDataStore', 'clothing', xPlayer.identifier, function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)

irpCore.RegisterServerCallback('irp-motels:getPlayerOutfit', function(source, cb, num)
	local xPlayer  = irpCore.GetPlayerFromId(source)

	TriggerEvent('srp-datastore:getDataStore', 'clothing', xPlayer.identifier, function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)

RegisterServerEvent('irp-motels:removeOutfit')
AddEventHandler('irp-motels:removeOutfit', function(label)
	local xPlayer = irpCore.GetPlayerFromId(source)

	TriggerEvent('srp-datastore:getDataStore', 'clothing', xPlayer.identifier, function(store)
		local dressing = store.get('dressing') or {}

		table.remove(dressing, label)
		store.set('dressing', dressing)
	end)
end)

irpCore.RegisterServerCallback('irp-motels:checkIsOwner', function(source, cb, room, owner)
    local xPlayer    = irpCore.GetPlayerFromIdentifier(owner)

    MySQL.Async.fetchScalar("SELECT motel_id FROM lsrp_motels WHERE motel_id = @room AND ident = @id", {
         ['@room'] = room,
         ['@id'] = xPlayer.identifier
		}, function(isOwner)

        if isOwner ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent('irp-motels:SaveMotel')
AddEventHandler('irp-motels:SaveMotel', function(motel, room)
	local xPlayer  = irpCore.GetPlayerFromId(source)
	local motelname = motel
	local roomident = room

	MySQL.Sync.execute('UPDATE users SET last_motel = @motelname, last_motel_room = @lroom WHERE identifier = @identifier',
	{
		['@motelname']        = motelname,
		['@lroom'] 			  = roomident,
		['@identifier'] 	  = xPlayer.identifier
	})
end)

RegisterServerEvent('irp-motels:DelMotel')
AddEventHandler('irp-motels:DelMotel', function()
	local xPlayer  = irpCore.GetPlayerFromId(source)
	MySQL.Sync.execute('UPDATE users SET last_motel = NULL, last_motel_room = NULL WHERE identifier = @identifier',
	{
		['@identifier'] 	  = xPlayer.identifier
	})
end)

irpCore.RegisterServerCallback('irp-motels:getLastMotel', function(source, cb)
	local xPlayer = irpCore.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT last_motel, last_motel_room FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		cb(users[1].last_motel, users[1].last_motel_room)
	end)
end)

function PayRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM lsrp_motels', {}, function (result)
		for i=1, #result, 1 do
			local xPlayer = irpCore.GetPlayerFromIdentifier(result[i].ident)

			-- message player if connected
			if xPlayer then
				xPlayer.removeAccountMoney('bank', Config.PriceRental)
				TriggerClientEvent('DoLongHudText', xPlayer.source, 'You paid $'.. irpCore.Math.GroupDigits(Config.PriceRental) .. ' for your motel room.', 1)
			else -- pay rent either way
				MySQL.Sync.execute('UPDATE users SET bank = bank - @bank WHERE identifier = @identifier',
				{
					['@bank']       = Config.PriceRental,
					['@identifier'] = result[i].owner
				})
			end
		end
	end)
end

Citizen.CreateThread(function()
	if Config.ThirdPartyStorageSystem then
    	TriggerEvent('irp-inventory:RegisterInventory', {
        	name = 'motel',
        	label = 'Motel',
			slots = Config.StorageSlots,
			maxweight = Config.StorageWeight,
    	})
	end
end)

TriggerEvent('cron:runAt', 22, 0, PayRent)