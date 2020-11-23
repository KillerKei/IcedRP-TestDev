irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

irpCore.RegisterServerCallback('wardrobe:getPlayerOutfit', function(source, cb, num)
	local xPlayer  = irpCore.GetPlayerFromId(source)

	TriggerEvent('irp-datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)

RegisterServerEvent('wardrobe:removeOutfit')
AddEventHandler('wardrobe:removeOutfit', function(label)
	local xPlayer = irpCore.GetPlayerFromId(source)

	TriggerEvent('irp-datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local dressing = store.get('dressing') or {}

		table.remove(dressing, label)
		store.set('dressing', dressing)
	end)
end)

irpCore.RegisterServerCallback('wardrobe:getPlayerDressing', function(source, cb)
	local xPlayer  = irpCore.GetPlayerFromId(source)

	TriggerEvent('irp-datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)