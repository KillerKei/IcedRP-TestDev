irpCore          = nil
local IsDead = false
local IsAnimated = false

Citizen.CreateThread(function()
	while irpCore == nil do
		TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('irp-basicneeds:resetStatus', function()
	TriggerEvent('irp-status:set', 'hunger', 500000)
	TriggerEvent('irp-status:set', 'thirst', 500000)
	TriggerEvent('irp-status:set', 'pee', 500000)
	TriggerEvent('irp-status:set', 'shit', 500000)
end)

RegisterNetEvent('irp-basicneeds:healPlayer')
AddEventHandler('irp-basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('irp-status:set', 'hunger', 1000000)
	TriggerEvent('irp-status:set', 'thirst', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('irp:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('irp-basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('irp-status:loaded', function(status)

	TriggerEvent('irp-status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return true
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('irp-status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return true
	end, function(status)
		status.remove(75)
	end)

	
		Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('irp-status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('irp-status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed,  health)
			end
		end
	end)
end)


AddEventHandler('irp-basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('irp-basicneeds:onEat')
AddEventHandler('irp-basicneeds:onEat', function(prop_name)
	if not IsAnimated then
		
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			RequestAnimDict('mp_player_inteat@burger')
			while not HasAnimDictLoaded('mp_player_inteat@burger') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
			exports["irp-taskbar"]:taskBar(8000, 'Eating')
				IsAnimated = false
				ClearPedTasks(playerPed)
				TriggerEvent("irp-state:stateSet",25,300)
		end)
	end
end)

RegisterNetEvent('irp-basicneeds:onDrink')
AddEventHandler('irp-basicneeds:onDrink', function(prop_name)
	if not IsAnimated then
		
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			RequestAnimDict('friends@frl@ig_1')  
			while not HasAnimDictLoaded('friends@frl@ig_1') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'friends@frl@ig_1', 'drink_lamar', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
			exports["irp-taskbar"]:taskBar(12000, 'Drinking')
				IsAnimated = false
				ClearPedTasks(playerPed)
				TriggerEvent("irp-state:stateSet",25,300)
		end)
	end
end)