irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('irp-addoninventory-service:activateService', 'police', Config.MaxInService)
end

TriggerEvent('irp-phone:registerNumber', 'police', _U('alert_police'), true, true)
TriggerEvent('irp-society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})

RegisterServerEvent('irp-policejob:confiscatePlayerItem')
AddEventHandler('irp-policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = irpCore.GetPlayerFromId(_source)
	local targetXPlayer = irpCore.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'police' then
		return
	end

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
				TriggerClientEvent('DoLongHudText', _source, 'Invalid Quantity', 2)
			else
				targetXPlayer.removeInventoryItem(itemName, amount)
				Citizen.Wait(50)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				Citizen.Wait(50)
				TriggerClientEvent('DoLongHudText', _source, 'You confiscated' ..sourceItem.label,' ' ..amount, 'from' ..targetXPlayer.name, 1)
				TriggerClientEvent('DoLongHudText', target, 'You got' ..sourceItem.label,' ' ..amount, 'removed by' ..targetXPlayer.name, 2)
			end
		else
			TriggerClientEvent('DoLongHudText', _source, 'Invalid Quantity', 2)
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)

		TriggerClientEvent('DoLongHudText', _source, 'You confiscated' ..itemName,' ' ..amount, 'from' ..targetXPlayer.name, 1)
		TriggerClientEvent('DoLongHudText', target, 'You got' ..itemName,' ' ..amount, 'removed' ..targetXPlayer.name, 2)

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		Citizen.Wait(50)
		sourceXPlayer.addWeapon   (itemName, amount)
		Citizen.Wait(50)

		TriggerClientEvent('DoLongHudText', _source, 'You confiscated' ..irpCore.GetWeaponLabel(itemName),' ' ..amount, 'from' ..targetXPlayer.name, 1)
		TriggerClientEvent('DoLongHudText', target, 'You got' ..irpCore.GetWeaponLabel(itemName),' ' ..amount, 'removed' ..targetXPlayer.name, 2)
	end
end)

RegisterCommand('givelicense', function(source, cb)
	local src = source
	local myPed = GetPlayerPed(src)
	local myPos = GetEntityCoords(myPed)
	local players = irpCore.GetPlayers()
  
	for k, v in ipairs(players) do
		if v ~= src then
	  local xTarget = GetPlayerPed(v)
	  local xPlayer = irpCore.GetPlayerFromId(v)
			local tPos = GetEntityCoords(xTarget)
	  local dist = #(vector3(tPos.x, tPos.y, tPos.z) - myPos)
	  local xSource = irpCore.GetPlayerFromId(source)
		
			if dist < 1 and xSource.job.name == 'police' then -- job goes here
		xPlayer.removeAccountMoney('bank', 500) -- change price here
		TriggerEvent('irp-license:checkLicense', v, 'weapon', function(cb)
		  if cb == false then 
			TriggerEvent('irp-license:addLicense', v, 'weapon', function()
			end)
			TriggerClientEvent('DoLongHudText', source, 'You have given a License to Carry a Weapon to ID - [' .. v .. '] for $500.' , 1) -- price also changes here
			TriggerClientEvent('DoLongHudText', v, 'You have given a License to Carry a Weapon for $500.', 1) -- price also changes here
			TriggerClientEvent('irp-fines:Anim', source)
		  else
			TriggerClientEvent('DoLongHudText', source, 'Failed. ID [ ' .. v .. ' ] already has a license.' , 2) -- price also changes here
		  end
		end)
	  end
		end
	end
  end)

RegisterServerEvent('irp-addoninventory-ambulancejob:revive')
AddEventHandler('irp-addoninventory-ambulancejob:revive', function(target)
	local xPlayer = irpCore.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		--xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('irp-addoninventory-ambulancejob:revive', target)
	else
	end
end)


RegisterServerEvent('irp-policejob:handcuff')
AddEventHandler('irp-policejob:handcuff', function(target)
	local xPlayer = irpCore.GetPlayerFromId(source)

	if xPlayer.job.name == 'all' then
		TriggerClientEvent('irp-policejob:handcuff', target)
	else
	end
end)

RegisterServerEvent('irp-policejob:drag')
AddEventHandler('irp-policejob:drag', function(target)
	local xPlayer = irpCore.GetPlayerFromId(source)
	TriggerClientEvent('irp-policejob:drag', target, source)
end)

RegisterServerEvent('irp-policejob:putInVehicle')
AddEventHandler('irp-policejob:putInVehicle', function(target)
	local xPlayer = irpCore.GetPlayerFromId(source)
	TriggerClientEvent('irp-policejob:putInVehicle', target)
end)

RegisterServerEvent('irp-policejob:OutVehicle')
AddEventHandler('irp-policejob:OutVehicle', function(target)
	local xPlayer = irpCore.GetPlayerFromId(source)
	TriggerClientEvent('irp-policejob:OutVehicle', target)
end)

RegisterServerEvent('irp-policejob:getStockItem')
AddEventHandler('irp-policejob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = irpCore.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('irp-addoninventory-addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then

			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('DoLongHudText', _source, 'Invalid Quantity', 2)
			else
				inventory.removeItem(itemName, count)
				Citizen.Wait(50)
				xPlayer.addInventoryItem(itemName, count)
				Citizen.Wait(50)
				TriggerClientEvent('DoLongHudText', _source, 'You have withdrawn ' ..count..' '..inventoryItem.label, 2)
			end
		else
			TriggerClientEvent('DoLongHudText', _source, 'Invalid Quantity', 2)
		end
	end)
end)

RegisterServerEvent('irp-policejob:putStockItems')
AddEventHandler('irp-policejob:putStockItems', function(itemName, count)
	local xPlayer = irpCore.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('irp-addoninventory-addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			Citizen.Wait(50)
			inventory.addItem(itemName, count)
			Citizen.Wait(50)
			TriggerClientEvent('DoLongHudText', _source, 'You have deposited' ..count..' '..inventoryItem.label, 1)
		else
			TriggerClientEvent('DoLongHudText', xPlayer.source, 'Invalid Quantity', 2)
		end
	end)
end)

irpCore.RegisterServerCallback('irp-policejob:getOtherPlayerData', function(source, cb, target)
	if Config.EnableirpCoreIdentity then
		local xPlayer = irpCore.GetPlayerFromId(target)
		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth
		local height    = result[1].height

		local data = {
			name      = GetPlayerName(target),
			job       = xPlayer.job,
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			weapons   = xPlayer.loadout,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height
		}

		TriggerEvent('irp-addoninventory-status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('irp-license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end
	else
		local xPlayer = irpCore.GetPlayerFromId(target)

		local data = {
			name       = GetPlayerName(target),
			job        = xPlayer.job,
			inventory  = xPlayer.inventory,
			accounts   = xPlayer.accounts,
			weapons    = xPlayer.loadout
		}

		TriggerEvent('irp-addoninventory-status:getStatus', target, 'drunk', function(status)
			if status then
				data.drunk = math.floor(status.percent)
			end
		end)

		TriggerEvent('irp-license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)
	end
end)

irpCore.RegisterServerCallback('irp-policejob:getVehicleInfos', function(source, cb, plate)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then
			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableirpCoreIdentity then
					retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
				else
					retrivedInfo.owner = result2[1].name
				end

				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

irpCore.RegisterServerCallback('irp-policejob:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableirpCoreIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)


irpCore.RegisterServerCallback('irp-policejob:getStockItems', function(source, cb)
	TriggerEvent('irp-addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

irpCore.RegisterServerCallback('irp-policejob:getPlayerInventory', function(source, cb)
	local xPlayer = irpCore.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source

	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = irpCore.GetPlayerFromId(_source)

		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' then
			Citizen.Wait(5000)
			TriggerClientEvent('irp-policejob:updateBlip', -1)
		end
	end
end)

RegisterServerEvent('irp-policejob:spawned')
AddEventHandler('irp-policejob:spawned', function()
	local _source = source
	local xPlayer = irpCore.GetPlayerFromId(_source)

	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' then
		Citizen.Wait(5000)
		TriggerClientEvent('irp-policejob:updateBlip', -1)
	end
end)

RegisterServerEvent('irp-policejob:forceBlip')
AddEventHandler('irp-policejob:forceBlip', function()
	TriggerClientEvent('irp-policejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('irp-policejob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('irp-phone:removeNumber', 'police')
	end
end)

RegisterServerEvent('irp-policejob:message')
AddEventHandler('irp-policejob:message', function(target, msg)
	TriggerClientEvent('DoLongHudText', target, msg)
end)

RegisterServerEvent('irp-policejob:requestarrest')
AddEventHandler('irp-policejob:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('irp-policejob:getarrested', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('irp-policejob:doarrested', _source)
end)

RegisterServerEvent('irp-policejob:requestrelease')
AddEventHandler('irp-policejob:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('irp-policejob:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('irp-policejob:douncuffing', _source)
end)

RegisterServerEvent('irp-policejob:requesthard')
AddEventHandler('irp-policejob:requesthard', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('irp-policejob:getarrestedhard', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('irp-policejob:doarrested', _source)
end)