Citizen.CreateThread(function()
	Citizen.Wait(500)
	print('\27[32m[irp-core]\27[0m Loaded All Data Successfully')
end)

AddEventHandler('es:playerLoaded', function(source, _player)
	local _source = source
	local tasks   = {}

	local userData = {
		accounts     = {},
		inventory    = {},
		job          = {},
		loadout      = {},
		playerName   = GetPlayerName(_source),
		lastPosition = nil
	}

	TriggerEvent('es:getPlayerFromId', _source, function(player)
		-- Update user name in DB
		table.insert(tasks, function(cb)
			MySQL.Async.execute('UPDATE users SET name = @name WHERE identifier = @identifier', {
				['@identifier'] = player.getIdentifier(),
				['@name'] = userData.playerName
			}, function(rowsChanged)
				cb()
			end)
		end)

		-- Get accounts
		table.insert(tasks, function(cb)
			MySQL.Async.fetchAll('SELECT * FROM user_accounts WHERE identifier = @identifier', {
				['@identifier'] = player.getIdentifier()
			}, function(accounts)
				for i=1, #Config.Accounts, 1 do
					for j=1, #accounts, 1 do
						if accounts[j].name == Config.Accounts[i] then
							table.insert(userData.accounts, {
								name  = accounts[j].name,
								money = accounts[j].money,
								label = Config.AccountLabels[accounts[j].name]
							})
							break
						end
					end
				end

				cb()
			end)
		end)

		-- Get inventory
		table.insert(tasks, function(cb)

			MySQL.Async.fetchAll('SELECT * FROM user_inventory WHERE identifier = @identifier', {
				['@identifier'] = player.getIdentifier()
			}, function(inventory)
				local tasks2 = {}

				for i=1, #inventory do
					local item = irpCore.Items[inventory[i].item]

					if item then
						table.insert(userData.inventory, {
							name = inventory[i].item,
							count = inventory[i].count,
							label = item.label,
							limit = item.limit,
							usable = irpCore.UsableItemsCallbacks[inventory[i].item] ~= nil,
							rare = item.rare,
							canRemove = item.canRemove
						})
					else
						print(('irp-core: invalid item "%s" ignored!'):format(inventory[i].item))
					end
				end

				for k,v in pairs(irpCore.Items) do
					local found = false

					for j=1, #userData.inventory do
						if userData.inventory[j].name == k then
							found = true
							break
						end
					end

					if not found then
						table.insert(userData.inventory, {
							name = k,
							count = 0,
							label = irpCore.Items[k].label,
							limit = irpCore.Items[k].limit,
							usable = irpCore.UsableItemsCallbacks[k] ~= nil,
							rare = irpCore.Items[k].rare,
							canRemove = irpCore.Items[k].canRemove
						})

						local scope = function(item, identifier)
							table.insert(tasks2, function(cb2)
								MySQL.Async.execute('INSERT INTO user_inventory (identifier, item, count) VALUES (@identifier, @item, @count)', {
									['@identifier'] = identifier,
									['@item'] = item,
									['@count'] = 0
								}, function(rowsChanged)
									cb2()
								end)
							end)
						end

						scope(k, player.getIdentifier())
					end

				end

				Async.parallelLimit(tasks2, 5, function(results) end)

				table.sort(userData.inventory, function(a,b)
					return a.label < b.label
				end)

				cb()
			end)

		end)

		-- Get job and loadout
		table.insert(tasks, function(cb)

			local tasks2 = {}

			-- Get job name, grade and last position
			table.insert(tasks2, function(cb2)

				MySQL.Async.fetchAll('SELECT job, job_grade, loadout, position FROM users WHERE identifier = @identifier', {
					['@identifier'] = player.getIdentifier()
				}, function(result)
					local job, grade = result[1].job, tostring(result[1].job_grade)

					if irpCore.DoesJobExist(job, grade) then
						local jobObject, gradeObject = irpCore.Jobs[job], irpCore.Jobs[job].grades[grade]

						userData.job = {}

						userData.job.id    = jobObject.id
						userData.job.name  = jobObject.name
						userData.job.label = jobObject.label

						userData.job.grade        = tonumber(grade)
						userData.job.grade_name   = gradeObject.name
						userData.job.grade_label  = gradeObject.label
						userData.job.grade_salary = gradeObject.salary

						userData.job.skin_male    = {}
						userData.job.skin_female  = {}

						if gradeObject.skin_male ~= nil then
							userData.job.skin_male = json.decode(gradeObject.skin_male)
						end
			
						if gradeObject.skin_female ~= nil then
							userData.job.skin_female = json.decode(gradeObject.skin_female)
						end
					else
						print(('irp-core: %s had an unknown job [job: %s, grade: %s], setting as unemployed!'):format(player.getIdentifier(), job, grade))

						local job, grade = 'unemployed', '0'
						local jobObject, gradeObject = irpCore.Jobs[job], irpCore.Jobs[job].grades[grade]

						userData.job = {}

						userData.job.id    = jobObject.id
						userData.job.name  = jobObject.name
						userData.job.label = jobObject.label
			
						userData.job.grade        = tonumber(grade)
						userData.job.grade_name   = gradeObject.name
						userData.job.grade_label  = gradeObject.label
						userData.job.grade_salary = gradeObject.salary
			
						userData.job.skin_male    = {}
						userData.job.skin_female  = {}
					end

					if result[1].loadout ~= nil then
						userData.loadout = json.decode(result[1].loadout)

						-- Compatibility with old loadouts prior to components update
						for k,v in ipairs(userData.loadout) do
							if v.components == nil then
								v.components = {}
							end
						end
					end

					if result[1].position ~= nil then
						userData.lastPosition = json.decode(result[1].position)
					end

					cb2()
				end)

			end)

			Async.series(tasks2, cb)

		end)

		-- Run Tasks
		Async.parallel(tasks, function(results)
			local xPlayer = CreateExtendedPlayer(player, userData.accounts, userData.inventory, userData.job, userData.loadout, userData.playerName, userData.lastPosition)

			xPlayer.getMissingAccounts(function(missingAccounts)
				if #missingAccounts > 0 then

					for i=1, #missingAccounts, 1 do
						table.insert(xPlayer.accounts, {
							name  = missingAccounts[i],
							money = 0,
							label = Config.AccountLabels[missingAccounts[i]]
						})
					end

					xPlayer.createAccounts(missingAccounts)
				end

				irpCore.Players[_source] = xPlayer

				TriggerEvent('irp:playerLoaded', _source, xPlayer)

				TriggerClientEvent('irp:playerLoaded', _source, {
					identifier   = xPlayer.identifier,
					accounts     = xPlayer.getAccounts(),
					inventory    = xPlayer.getInventory(),
					job          = xPlayer.getJob(),
					loadout      = xPlayer.getLoadout(),
					lastPosition = xPlayer.getLastPosition(),
					money        = xPlayer.getMoney()
				})

				xPlayer.displayMoney(xPlayer.getMoney())
			end)
		end)

	end)
end)

AddEventHandler('playerDropped', function(reason)
	local _source = source
	local xPlayer = irpCore.GetPlayerFromId(_source)

	if xPlayer then
		TriggerEvent('irp:playerDropped', _source, reason)
		TriggerEvent('irp:PlayerDropped', xPlayer, source)

		irpCore.SavePlayer(xPlayer, function()
			irpCore.Players[_source] = nil
			irpCore.LastPlayerData[_source] = nil
		end)
	end
end)

RegisterServerEvent('irp:updateLoadout')
AddEventHandler('irp:updateLoadout', function(loadout)
	local xPlayer = irpCore.GetPlayerFromId(source)
	xPlayer.loadout = loadout
end)

RegisterServerEvent('irp:updateLastPosition')
AddEventHandler('irp:updateLastPosition', function(position)
	local xPlayer = irpCore.GetPlayerFromId(source)
	xPlayer.setLastPosition(position)
end)

RegisterServerEvent('irp:giveInventoryItem')
AddEventHandler('irp:giveInventoryItem', function(target, type, itemName, itemCount)
	local _source = source

	local sourceXPlayer = irpCore.GetPlayerFromId(_source)
	local targetXPlayer = irpCore.GetPlayerFromId(target)

	if type == 'item_standard' then

		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		local targetItem = targetXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then

			if targetItem.limit ~= -1 and (targetItem.count + itemCount) > targetItem.limit then
				--TriggerClientEvent('irp:showNotification', _source, _U('ex_inv_lim', targetXPlayer.name))
			else
				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem   (itemName, itemCount)
				
				--TriggerClientEvent('irp:showNotification', _source, _U('gave_item', itemCount, irpCore.Items[itemName].label, targetXPlayer.name))
				--TriggerClientEvent('irp:showNotification', target,  _U('received_item', itemCount, irpCore.Items[itemName].label, sourceXPlayer.name))
			end

		else
			--TriggerClientEvent('irp:showNotification', _source, _U('imp_invalid_quantity'))
		end

	elseif type == 'item_money' then

		if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
			sourceXPlayer.removeMoney(itemCount)
			targetXPlayer.addMoney   (itemCount)

			--TriggerClientEvent('irp:showNotification', _source, _U('gave_money', irpCore.Math.GroupDigits(itemCount), targetXPlayer.name))
			--TriggerClientEvent('irp:showNotification', target,  _U('received_money', irpCore.Math.GroupDigits(itemCount), sourceXPlayer.name))
		else
			--TriggerClientEvent('irp:showNotification', _source, _U('imp_invalid_amount'))
		end

	elseif type == 'item_account' then

		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney   (itemName, itemCount)

			--TriggerClientEvent('irp:showNotification', _source, _U('gave_account_money', irpCore.Math.GroupDigits(itemCount), Config.AccountLabels[itemName], targetXPlayer.name))
			--TriggerClientEvent('irp:showNotification', target,  _U('received_account_money', irpCore.Math.GroupDigits(itemCount), Config.AccountLabels[itemName], sourceXPlayer.name))
		else
			--TriggerClientEvent('irp:showNotification', _source, _U('imp_invalid_amount'))
		end

	elseif type == 'item_weapon' then

		if not targetXPlayer.hasWeapon(itemName) then
			sourceXPlayer.removeWeapon(itemName)
			targetXPlayer.addWeapon(itemName, itemCount)

			local weaponLabel = irpCore.GetWeaponLabel(itemName)

			if itemCount > 0 then
				--TriggerClientEvent('irp:showNotification', _source, _U('gave_weapon_ammo', weaponLabel, itemCount, targetXPlayer.name))
				--TriggerClientEvent('irp:showNotification', target,  _U('received_weapon_ammo', weaponLabel, itemCount, sourceXPlayer.name))
			else
				--TriggerClientEvent('irp:showNotification', _source, _U('gave_weapon', weaponLabel, targetXPlayer.name))
				--TriggerClientEvent('irp:showNotification', target,  _U('received_weapon', weaponLabel, sourceXPlayer.name))
			end
		else
			--TriggerClientEvent('irp:showNotification', _source, _U('gave_weapon_hasalready', targetXPlayer.name, weaponLabel))
			--TriggerClientEvent('irp:showNotification', target, _U('received_weapon_hasalready', sourceXPlayer.name, weaponLabel))
		end

	end
end)

RegisterServerEvent('irp:removeInventoryItem')
AddEventHandler('irp:removeInventoryItem', function(type, itemName, itemCount)
	local _source = source

	if type == 'item_standard' then

		if itemCount == nil or itemCount < 1 then
			--TriggerClientEvent('irp:showNotification', _source, _U('imp_invalid_quantity'))
		else
			local xPlayer = irpCore.GetPlayerFromId(source)
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				--TriggerClientEvent('irp:showNotification', _source, _U('imp_invalid_quantity'))
			else
				xPlayer.removeInventoryItem(itemName, itemCount)

				local pickupLabel = ('[E] - Pickup'):format(xItem.label, itemCount)
				irpCore.CreatePickup('item_standard', itemName, itemCount, pickupLabel, _source)
				--TriggerClientEvent('irp:showNotification', _source, _U('threw_standard', itemCount, xItem.label))
			end
		end

	elseif type == 'item_money' then

		if itemCount == nil or itemCount < 1 then
			--TriggerClientEvent('irp:showNotification', _source, _U('imp_invalid_amount'))
		else
			local xPlayer = irpCore.GetPlayerFromId(source)
			local playerCash = xPlayer.getMoney()

			if (itemCount > playerCash or playerCash < 1) then
				--TriggerClientEvent('irp:showNotification', _source, _U('imp_invalid_amount'))
			else
				xPlayer.removeMoney(itemCount)

				local pickupLabel = ('[E] - Pickup'):format(_U('cash'), _U('locale_currency', irpCore.Math.GroupDigits(itemCount)))
				irpCore.CreatePickup('item_money', 'money', itemCount, pickupLabel, _source)
				--TriggerClientEvent('irp:showNotification', _source, _U('threw_money', irpCore.Math.GroupDigits(itemCount)))
			end
		end

	elseif type == 'item_account' then

		if itemCount == nil or itemCount < 1 then
			--TriggerClientEvent('irp:showNotification', _source, _U('imp_invalid_amount'))
		else
			local xPlayer = irpCore.GetPlayerFromId(source)
			local account = xPlayer.getAccount(itemName)

			if (itemCount > account.money or account.money < 1) then
				--TriggerClientEvent('irp:showNotification', _source, _U('imp_invalid_amount'))
			else
				xPlayer.removeAccountMoney(itemName, itemCount)

				local pickupLabel = ('[E] - Pickup'):format(account.label, _U('locale_currency', irpCore.Math.GroupDigits(itemCount)))
				irpCore.CreatePickup('item_account', itemName, itemCount, pickupLabel, _source)
				--TriggerClientEvent('irp:showNotification', _source, _U('threw_account', irpCore.Math.GroupDigits(itemCount), string.lower(account.label)))
			end
		end

	elseif type == 'item_weapon' then

		local xPlayer = irpCore.GetPlayerFromId(source)
		local loadout = xPlayer.getLoadout()

		for i=1, #loadout, 1 do
			if loadout[i].name == itemName then
				itemCount = loadout[i].ammo
				break
			end
		end

		if xPlayer.hasWeapon(itemName) then
			local weaponLabel, weaponPickup = irpCore.GetWeaponLabel(itemName), 'PICKUP_' .. string.upper(itemName)

			xPlayer.removeWeapon(itemName)

			if itemCount > 0 then
				--TriggerClientEvent('irp:pickupWeapon', _source, weaponPickup, itemName, itemCount)
				--TriggerClientEvent('irp:showNotification', _source, _U('threw_weapon_ammo', weaponLabel, itemCount))
			else
				-- workaround for CreateAmbientPickup() giving 30 rounds of ammo when you drop the weapon with 0 ammo
				--TriggerClientEvent('irp:pickupWeapon', _source, weaponPickup, itemName, 1)
				--TriggerClientEvent('irp:showNotification', _source, _U('threw_weapon', weaponLabel))
			end
		end

	end
end)

RegisterServerEvent('irp:useItem')
AddEventHandler('irp:useItem', function(itemName)
	local xPlayer = irpCore.GetPlayerFromId(source)
	local count   = xPlayer.getInventoryItem(itemName).count

	if count > 0 then
		irpCore.UseItem(source, itemName)
	else
		--TriggerClientEvent('irp:showNotification', xPlayer.source, _U('act_imp'))
	end
end)

RegisterServerEvent('irp:onPickup')
AddEventHandler('irp:onPickup', function(id)
	local _source = source
	local pickup  = irpCore.Pickups[id]
	local xPlayer = irpCore.GetPlayerFromId(_source)

	if pickup.type == 'item_standard' then

		local item      = xPlayer.getInventoryItem(pickup.name)
		local canTake   = ((item.limit == -1) and (pickup.count)) or ((item.limit - item.count > 0) and (item.limit - item.count)) or 0
		local total     = pickup.count < canTake and pickup.count or canTake
		local remaining = pickup.count - total

		TriggerClientEvent('irp:removePickup', -1, id)

		if total > 0 then
			xPlayer.addInventoryItem(pickup.name, total)
		end

		if remaining > 0 then
			--TriggerClientEvent('irp:showNotification', _source, _U('cannot_pickup_room', item.label))

			local pickupLabel = ('[E] - Pickup'):format(item.label, remaining)
			irpCore.CreatePickup('item_standard', pickup.name, remaining, pickupLabel, _source)
		end

	elseif pickup.type == 'item_money' then
		TriggerClientEvent('irp:removePickup', -1, id)
		xPlayer.addMoney(pickup.count)
	elseif pickup.type == 'item_account' then
		TriggerClientEvent('irp:removePickup', -1, id)
		xPlayer.addAccountMoney(pickup.name, pickup.count)
	end
end)

irpCore.RegisterServerCallback('irp:getPlayerData', function(source, cb)
	local xPlayer = irpCore.GetPlayerFromId(source)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		loadout      = xPlayer.getLoadout(),
		lastPosition = xPlayer.getLastPosition(),
		money        = xPlayer.getMoney()
	})
end)

irpCore.RegisterServerCallback('irp:getOtherPlayerData', function(source, cb, target)
	local xPlayer = irpCore.GetPlayerFromId(target)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		loadout      = xPlayer.getLoadout(),
		lastPosition = xPlayer.getLastPosition(),
		money        = xPlayer.getMoney()
	})
end)

TriggerEvent("es:addGroup", "jobmaster", "user", function(group) end)

irpCore.StartDBSync()
irpCore.StartPayCheck()
