irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

irpCore.RegisterUsableItem('bread', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 200000)
end)

irpCore.RegisterUsableItem('sportlunch', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sportlunch', 1)

	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 300000)
end)

irpCore.RegisterUsableItem('water', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	
	TriggerClientEvent('irp-basicneeds:onDrink', source)
	Citizen.Wait(12000)
	TriggerClientEvent('irp-status:add', source, 'thirst', 200000)
end)

---New Items

irpCore.RegisterUsableItem('prunejuice', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('prunejuice', 1)

	
	TriggerClientEvent('irp-basicneeds:onDrink', source)
	Citizen.Wait(12000)
	TriggerClientEvent('irp-status:add', source, 'thirst', 230000)
end)

irpCore.RegisterUsableItem('chips', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('chips', 1)
	
	
	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 100000)
end)

irpCore.RegisterUsableItem('cocacola', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cocacola', 1)
	
	TriggerClientEvent('irp-basicneeds:onDrink', source)
	Citizen.Wait(12000)
	TriggerClientEvent('irp-status:add', source, 'thirst', 250000)
end)

irpCore.RegisterUsableItem('irpepper', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('irpepper', 1)
	
	TriggerClientEvent('irp-basicneeds:onDrink', source)
	Citizen.Wait(12000)
	TriggerClientEvent('irp-status:add', source, 'thirst', 250000)
end)

irpCore.RegisterUsableItem('icetea', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('icetea', 1)
	
	TriggerClientEvent('irp-basicneeds:onDrink', source)
	Citizen.Wait(12000)
	TriggerClientEvent('irp-status:add', source, 'thirst', 250000)
end)


irpCore.RegisterUsableItem('chocolate', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('chocolate', 1)

	
	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 50000)
end)

irpCore.RegisterUsableItem('energy', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('energy', 1)

	
	TriggerClientEvent('irp-basicneeds:onDrink', source)
	Citizen.Wait(12000)
	TriggerClientEvent('irp-status:add', source, 'thirst', 150000)
end)

irpCore.RegisterUsableItem('bacon-burger', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bacon-burger', 1)

	
	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 300000)
end)

irpCore.RegisterUsableItem('heartattack', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('heartattack', 1)

	
	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 500000)
end)


irpCore.RegisterUsableItem('hamburger', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hamburger', 1)

	
	TriggerClientEvent('irp-basicneeds:onEat', source)
	Citizen.Wait(8000)
	TriggerClientEvent('irp-status:add', source, 'hunger', 250000)
end)



TriggerEvent('es:addGroupCommand', 'heal', 'admin', function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local target = tonumber(args[1])
		
		-- is the argument a number?
		if target ~= nil then
			
			-- is the number a valid player?
			if GetPlayerName(target) then
				TriggerClientEvent('irp-basicneeds:healPlayer', target)
				TriggerClientEvent('chatMessage', target, "HEAL", {223, 66, 244}, "You have been healed!")
			else
				TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Player not found!")
			end
		else
			TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Incorrect syntax! You must provide a valid player ID")
		end
	else
		-- heal source
		TriggerClientEvent('irp-basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Insufficient Permissions.")
end, {help = "Heal a player, or yourself - restores thirst, hunger and health."})