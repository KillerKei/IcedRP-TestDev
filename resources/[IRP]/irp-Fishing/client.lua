irpCore = nil
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if irpCore ~= nil then
		
		else
			irpCore = nil
			TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)
		end
	end
end)

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0

local bait = "none"

local blip = AddBlipForCoord(Config.SellFish.x, Config.SellFish.y, Config.SellFish.z)

			SetBlipSprite (blip, 356)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.7)
			SetBlipColour (blip, 17)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Fish selling")
			EndTextCommandSetBlipName(blip)
			
local blip2 = AddBlipForCoord(Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z)

			SetBlipSprite (blip2, 68)
			SetBlipDisplay(blip2, 4)
			SetBlipScale  (blip2, 0.7)
			SetBlipColour (blip2, 49)
			SetBlipAsShortRange(blip2, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Sea Turtle dealer")
			EndTextCommandSetBlipName(blip2)
			
local blip3 = AddBlipForCoord(Config.SellShark.x, Config.SellShark.y, Config.SellShark.z)

			SetBlipSprite (blip3, 68)
			SetBlipDisplay(blip3, 4)
			SetBlipScale  (blip3, 0.7)
			SetBlipColour (blip3, 49)
			SetBlipAsShortRange(blip3, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Shark meat dealer")
			EndTextCommandSetBlipName(blip3)
			
for _, info in pairs(Config.MarkerZones) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, 455)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.7)
		SetBlipColour(info.blip, 20)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Boat rental")
		EndTextCommandSetBlipName(info.blip)
	end
	
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(Config.MarkerZones) do
		
            DrawMarker(1, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 0, 150, 150, 100, 0, 0, 0, 0)	
		end
    end
end)
			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
Citizen.CreateThread(function()
while true do
	Wait(600)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
end
end)
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if fishing then
			if IsControlJustReleased(0, Keys['E']) then
				 input = 1
			end
			
			
			if IsControlJustReleased(0, Keys['X']) then
				fishing = false
				TriggerEvent('DoLongHudText', 'Stopped Fishing', 2)
			end
			if fishing then
			
				playerPed = GetPlayerPed(-1)
				local pos = GetEntityCoords(GetPlayerPed(-1))
				if pos.z < 2.73 or IsPedInAnyVehicle(GetPlayerPed(-1)) then
					
				else
					fishing = false
					TriggerEvent('DoLongHudText', 'Stopped Fishing', 2)
				end
				if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
					TriggerEvent('DoLongHudText', 'Stopped Fishing', 2)
				end
			end
			
			
			
			if pausetimer > 3 then
				input = 250
			end
			
			if pause and input ~= 0 then
				pause = false
				if input == correct then
					TriggerServerEvent('irp-Fishing:catch', bait)
				else
					TriggerEvent('DoLongHudText', 'Fish got free.', 2)
				end
			end
		end

		
		
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) <= 3 then
			TriggerServerEvent('irp-Fishing:startSelling', "fish")
			Citizen.Wait(4000)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.SellShark.x, Config.SellShark.y, Config.SellShark.z, true) <= 3 then
			TriggerServerEvent('irp-Fishing:startSelling', "shark")
			Citizen.Wait(4000)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z, true) <= 3 then
			TriggerServerEvent('irp-Fishing:startSelling', "turtle")
			Citizen.Wait(4000)
		end
		
	end
end)


				
Citizen.CreateThread(function()
	while true do
		Wait(1)
		
		DrawMarker(27, Config.SellFish.x, Config.SellFish.y, Config.SellFish.z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 0, 70, 250, 100, false, true, 2, false, false, false, false)
		DrawMarker(27, Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 0, 70, 250, 100, false, true, 2, false, false, false, false)
		DrawMarker(27, Config.SellShark.x, Config.SellShark.y, Config.SellShark.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 0, 70, 250, 100, false, true, 2, false, false, false, false)
	end
end)

Citizen.CreateThread(function()
	while true do
		local wait = math.random(Config.FishTime.a , Config.FishTime.b)
		Wait(wait)
			if fishing then
				pause = true
				correct = math.random(1)
				TriggerEvent('DoLongHudText', 'Fish is taking the bait. Press (E) to catch it.', 1)
				input = 0
				pausetimer = 0
			end
			
	end
end)

RegisterNetEvent('irp-Fishing:message')
AddEventHandler('irp-Fishing:message', function(message)
	irpCore.ShowNotification(message)
end)
RegisterNetEvent('irp-Fishing:break')
AddEventHandler('irp-Fishing:break', function()
	fishing = false
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('irp-Fishing:spawnPed')
AddEventHandler('irp-Fishing:spawnPed', function()
	
	RequestModel( GetHashKey( "A_C_SharkTiger" ) )
		while ( not HasModelLoaded( GetHashKey( "A_C_SharkTiger" ) ) ) do
			Citizen.Wait( 1 )
		end
	local pos = GetEntityCoords(GetPlayerPed(-1))
	
	local ped = CreatePed(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
end)

RegisterNetEvent('irp-Fishing:setbait')
AddEventHandler('irp-Fishing:setbait', function(bool)
	bait = bool
	print(bait)
end)

RegisterNetEvent('irp-Fishing:fishstart')
AddEventHandler('irp-Fishing:fishstart', function()
	playerPed = GetPlayerPed(-1)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	--print('started irp-Fishing' .. pos)
	if IsPedInAnyVehicle(playerPed) then
		TriggerEvent('DoLongHudText', 'You can not fish from a vehicle.', 2)
	else
		if pos.y >= 7700 or pos.y <= -720 or pos.x <= -3700 or pos.x >= -3315 then
			TriggerEvent('DoLongHudText', 'Fishing Started', 1)
			TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
			fishing = true
		else
			TriggerEvent('DoLongHudText', 'You need to go further away from the store.', 2)
		end
	end
	
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	
        for k in pairs(Config.MarkerZones) do
        	local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped, false)
            local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z)
            if distance <= 1.40 then

					DisplayHelpText('Press E to rent a boat')
					
					if IsControlJustPressed(0, Keys['E']) and IsPedOnFoot(ped) then
						OpenBoatsMenu(Config.MarkerZones[k].xs, Config.MarkerZones[k].ys, Config.MarkerZones[k].zs)
					end 
			elseif distance < 1.45 then
				irpCore.UI.Menu.CloseAll()
            end
        end
    end
end)

function OpenBoatsMenu(x, y , z)
	local ped = PlayerPedId()
	PlayerData = irpCore.GetPlayerData()
	local elements = {}
	
	
		table.insert(elements, {label = '<span style="color:green;">Dinghy</span> <span style="color:red;">2500$</span>', value = 'boat'})
		table.insert(elements, {label = '<span style="color:green;">Suntrap</span> <span style="color:red;">3500$</span>', value = 'boat6'}) 
		table.insert(elements, {label = '<span style="color:green;">Jetmax</span> <span style="color:red;">4500$</span>', value = 'boat5'}) 	
		table.insert(elements, {label = '<span style="color:green;">Toro</span> <span style="color:red;">5500$</span>', value = 'boat2'}) 
		table.insert(elements, {label = '<span style="color:green;">Marquis</span> <span style="color:red;">6000$</span>', value = 'boat3'}) 
		table.insert(elements, {label = '<span style="color:green;">Tug boat</span> <span style="color:red;">7500$</span>', value = 'boat4'})
		
	--If user has police job they will be able to get free Police Predator boat
	if PlayerData.job.name == "police" then
		table.insert(elements, {label = '<span style="color:green;">Police Predator</span>', value = 'police'})
	end
	
	irpCore.UI.Menu.CloseAll()

	irpCore.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'client',
    {
		title    = 'Rent a boat',
		align    = 'bottom-right',
		elements = elements,
    },
	
	
	function(data, menu)

	if data.current.value == 'boat' then
		irpCore.UI.Menu.CloseAll()

		TriggerServerEvent("irp-Fishing:lowmoney", 2500) 
		TriggerEvent("chatMessage", 'You rented a boat for', {255,0,255}, '$' .. 2500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('irp:spawnVehicle', "dinghy4")
	end
	
	if data.current.value == 'boat2' then
		irpCore.UI.Menu.CloseAll()

		TriggerServerEvent("irp-Fishing:lowmoney", 5500) 
		TriggerEvent("chatMessage", 'You rented a boat for', {255,0,255}, '$' .. 5500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('irp:spawnVehicle', "TORO")
	end
	
	if data.current.value == 'boat3' then
		irpCore.UI.Menu.CloseAll()

		TriggerServerEvent("irp-Fishing:lowmoney", 6000) 
		TriggerEvent("chatMessage", 'You rented a boat for', {255,0,255}, '$' .. 6000)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('irp:spawnVehicle', "MARQUIS")
	end

	if data.current.value == 'boat4' then
		irpCore.UI.Menu.CloseAll()

		TriggerServerEvent("irp-Fishing:lowmoney", 7500) 
		TriggerEvent("chatMessage", 'You rented a boat for', {255,0,255}, '$' .. 7500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('irp:spawnVehicle', "tug")
	end
	
	if data.current.value == 'boat5' then
		irpCore.UI.Menu.CloseAll()

		TriggerServerEvent("irp-Fishing:lowmoney", 4500) 
		TriggerEvent("chatMessage", 'You rented a boat for', {255,0,255}, '$' .. 4500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('irp:spawnVehicle', "jetmax")
	end
	
	if data.current.value == 'boat6' then
		irpCore.UI.Menu.CloseAll()

		TriggerServerEvent("irp-Fishing:lowmoney", 3500) 
		TriggerEvent("chatMessage", 'You rented a boat for', {255,0,255}, '$' .. 3500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('irp:spawnVehicle', "suntrap")
	end
	
	
	if data.current.value == 'police' then
		irpCore.UI.Menu.CloseAll()

		TriggerEvent("chatMessage", 'You took out a boat')
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('irp:spawnVehicle', "predator")
	end
	irpCore.UI.Menu.CloseAll()
	

    end,
	function(data, menu)
		menu.close()
		end
	)
end
