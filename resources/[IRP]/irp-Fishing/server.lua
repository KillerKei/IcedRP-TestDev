irpCore = nil
TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)


irpCore.RegisterUsableItem('turtlebait', function(source)
	local _source = source
	xPlayer = irpCore.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('irp-Fishing:setbait', _source, "turtle")
		
		xPlayer.removeInventoryItem('turtlebait', 1)
		TriggerClientEvent('DoLongHudText', _source, 'You attach the turtle bait onto your fishing rod.', 1)
	else
		TriggerClientEvent('DoLongHudText', _source, 'You dont have a fishing rod.', 2)
	end
end)

irpCore.RegisterUsableItem('fishbait', function(source)
	local _source = source
	xPlayer = irpCore.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('irp-Fishing:setbait', _source, "fish")
		
		xPlayer.removeInventoryItem('fishbait', 1)
		TriggerClientEvent('DoLongHudText', _source, 'You attach the fish bait onto your fishing rod.', 1)
	else
		TriggerClientEvent('DoLongHudText', _source, 'You dont have a fishing rod.', 2)
	end
end)

irpCore.RegisterUsableItem('turtle', function(source)
	local _source = source
	xPlayer = irpCore.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('irp-Fishing:setbait', _source, "shark")
		
		xPlayer.removeInventoryItem('turtle', 1)
		TriggerClientEvent('DoLongHudText', _source, 'You attach the turtle bait onto your fishing rod.', 1)
	else
		TriggerClientEvent('DoLongHudText', _source, 'You dont have a fishing rod.', 2)
	end
end)

irpCore.RegisterUsableItem('fishingrod', function(source)
	local _source = source
	TriggerClientEvent('irp-Fishing:fishstart', _source)
end)


				
RegisterNetEvent('irp-Fishing:catch')
AddEventHandler('irp-Fishing:catch', function(bait)
	
	_source = source
	local weight = 2
	local rnd = math.random(1,100)
	local payout = math.random(2,3)
	local matherino = math.random(0, 2)
	xPlayer = irpCore.GetPlayerFromId(_source)
	if bait == "turtle" then
		if rnd >= 74 then
			if rnd >= 94 then
				TriggerClientEvent('irp-Fishing:setbait', _source, "none")
				TriggerClientEvent('DoLongHudText', _source, 'It was huge and it broke your fishing rod!', 2)
				TriggerClientEvent('irp-Fishing:break', _source)
				xPlayer.removeInventoryItem('irp-Fishingrod', 1)
			else
				TriggerClientEvent('irp-Fishing:setbait', _source, "none")
				if xPlayer.getInventoryItem('turtle').count > 4 then
					TriggerClientEvent('DoLongHudText', _source, 'You cant hold more turtles!', 2)
					if matherino == 2 then
						xPlayer.addInventoryItem('plastic', payout)
					end
				else
					TriggerClientEvent('DoLongHudText', _source, 'You caught a turtle. These are endangered species and are illegal to posses!', 1)
					xPlayer.addInventoryItem('turtle', 1)
					if matherino == 2 then
						xPlayer.addInventoryItem('plastic', payout)
					end
				end
			end
		else
			if rnd <= 75 then
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('DoLongHudText', _source, 'You cant hold more fish!', 2)
				else
					weight = math.random(4,9)
					TriggerClientEvent('DoLongHudText', _source, 'You caught a fish: '.. weight .. ' kg', 2)
					xPlayer.addInventoryItem('fish', weight)
					if matherino == 2 then
						xPlayer.addInventoryItem('rubber', payout)
					end
				end
				
			else
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('DoLongHudText', _source, 'You cant hold anymore fish.', 2)
				else
					weight = math.random(2,6)
					TriggerClientEvent('DoLongHudText', _source, 'You caught a fish: '.. weight .. ' kg', 2)
					xPlayer.addInventoryItem('fish', weight)
					if matherino == 2 then
						xPlayer.addInventoryItem('rubber', payout)
					end
				end
			end
		end
	else
		if bait == "fish" then
			if rnd >= 60 then
				TriggerClientEvent('irp-Fishing:setbait', _source, "none")
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('DoLongHudText', _source, 'You cant hold anymore fish.', 2)
				else
					weight = math.random(4,11)
					TriggerClientEvent('DoLongHudText', _source, 'You caught a fish: '.. weight .. ' kg', 2)
					xPlayer.addInventoryItem('fish', weight)
					if matherino == 2 then
						xPlayer.addInventoryItem('steel', payout)
					end
				end
				
			else
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('DoLongHudText', _source, 'You cant hold anymore fish.', 2)
				else
					weight = math.random(1,6)
					TriggerClientEvent('DoLongHudText', _source, 'You caught a fish: '.. weight .. ' kg', 2)
					xPlayer.addInventoryItem('fish', weight)
					if matherino == 2 then
						xPlayer.addInventoryItem('steel', payout)
					end
				end
			end
		end
		if bait == "none" then
			
			if rnd >= 70 then
			TriggerClientEvent('DoLongHudText', _source, 'You are currently fishing without any equipped bait.', 2)
				if  xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('DoLongHudText', _source, 'You cant hold anymore fish.', 2)
					else
						weight = math.random(2,4)
						TriggerClientEvent('DoLongHudText', _source, 'You caught a fish: '.. weight .. ' kg', 2)
						xPlayer.addInventoryItem('fish', weight)
						if matherino == 2 then
							xPlayer.addInventoryItem('aluminium', payout)
						end
					end
					
				else
					TriggerClientEvent('DoLongHudText', _source, 'You are currently fishing without any equipped bait.', 2)
					if xPlayer.getInventoryItem('fish').count > 100 then
						TriggerClientEvent('DoLongHudText', _source, 'You cant hold anymore fish.', 2)
					else
						weight = math.random(1,2)
						TriggerClientEvent('DoLongHudText', _source, 'You caught a fish: '.. weight .. ' kg', 2)
						xPlayer.addInventoryItem('fish', weight)
						if matherino == 2 then
							xPlayer.addInventoryItem('aluminium', payout)
					end
				end
			end
		end
		if bait == "shark" then
			if rnd >= 74 then
					if rnd >= 91 then
						TriggerClientEvent('irp-Fishing:setbait', _source, "none")
						TriggerClientEvent('DoLongHudText', _source, 'It was huge and it broke your fishing rod!', 2)
						TriggerClientEvent('irp-Fishing:break', _source)
						xPlayer.removeInventoryItem('irp-Fishingrod', 1)
					else
						if xPlayer.getInventoryItem('shark').count > 0  then
								TriggerClientEvent('irp-Fishing:setbait', _source, "none")
								TriggerClientEvent('DoLongHudText', _source, 'You cant hold anymore sharks!', 2)
							else
								TriggerClientEvent('DoLongHudText', _source, 'You caught a shark! These are endangered species and are illegal to posses.', 2)
								TriggerClientEvent('irp-Fishing:spawnPed', _source)
								xPlayer.addInventoryItem('shark', 1)
								if matherino == 2 then
									xPlayer.addInventoryItem('steel', payout)
								end
							end
						end	
					else
					if xPlayer.getInventoryItem('fish').count > 100 then
						TriggerClientEvent('DoLongHudText', _source, 'You cant hold anymore fish.', 2)
					else
						weight = math.random(4,8)
					TriggerClientEvent('DoLongHudText', _source, 'You caught a fish: '.. weight .. ' kg', 2)
					xPlayer.addInventoryItem('fish', weight)
					if matherino == 2 then
						xPlayer.addInventoryItem('aluminium', payout)
					end
				end				
			end
		end	
	end
end)

RegisterServerEvent("irp-Fishing:lowmoney")
AddEventHandler("irp-Fishing:lowmoney", function(money)
    local _source = source	
	local xPlayer = irpCore.GetPlayerFromId(_source)
	xPlayer.removeMoney(money)
end)

RegisterServerEvent('irp-Fishing:startSelling')
AddEventHandler('irp-Fishing:startSelling', function(item)
local _source = source
local xPlayer  = irpCore.GetPlayerFromId(_source)
		if item == "fish" then
			local FishQuantity = xPlayer.getInventoryItem('fish').count
			if FishQuantity <= 4 then
				TriggerClientEvent('DoLongHudText', _source, 'You dont have enough fish.', 2)		
			else   
				xPlayer.removeInventoryItem('fish', 5)
				Citizen.Wait(50)
				payment = math.random(Config.FishPrice.a, Config.FishPrice.b) 
				xPlayer.addMoney(payment)
			end
		end
		if item == "turtle" then
			local FishQuantity = xPlayer.getInventoryItem('turtle').count

			if FishQuantity <= 0 then
				TriggerClientEvent('DoLongHudText', _source, 'You dont have enough turtles.', 2)				
			else   
				xPlayer.removeInventoryItem('turtle', 1)
				Citizen.Wait(50)
				payment = math.random(Config.TurtlePrice.a, Config.TurtlePrice.b) 
				xPlayer.addMoney(payment)		
			end
		end
		if item == "shark" then
			local FishQuantity = xPlayer.getInventoryItem('shark').count

		if FishQuantity <= 0 then
			TriggerClientEvent('DoLongHudText', _source, 'You dont have enough sharks.', 2)			
		else   
			xPlayer.removeInventoryItem('shark', 1)
			Citizen.Wait(50)
			payment = math.random(Config.SharkPrice.a, Config.SharkPrice.b)
			xPlayer.addMoney(payment)
		end
	end
end)

