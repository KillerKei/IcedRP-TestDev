irpCore = nil


Citizen.CreateThread(function()
	while irpCore == nil do
		TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)
		Citizen.Wait(0)
	end

	while irpCore.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('VehSpawn')
AddEventHandler('VehSpawn', function(vehicle)

	local model = GetHashKey('CHGR')
	local playerPed = PlayerPedId()
	local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 2.0)

	irpCore.Game.SpawnVehicle(model, coords + 3, heading, function(vehicle)
	end)

end)

RegisterCommand('svems', function(source, args, user)
	if (irpCore.GetPlayerData().job.name == 'ambulance') then
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped, false)
		for k,v in pairs(Config.EMSGarage) do 
			if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then

		if tostring(args[1]) == nil then
			return
		else
			if tostring(args[1]) ~= nil then
				local argh = args[1]

				if argh == '1' then
					local model = GetHashKey(Config.Vehlist[1])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 2.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '2' then
					local model = GetHashKey(Config.Vehlist[2])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '3' then
					local model = GetHashKey(Config.Vehlist[3])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '4' then
					local model = GetHashKey(Config.Vehlist[4])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '5' then
					local model = GetHashKey(Config.Vehlist[5])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '6' then
					local model = GetHashKey(Config.Vehlist[6])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '7' then
					local model = GetHashKey(Config.Vehlist[7])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				end
			end
		end

	end
end
end
end)


RegisterCommand('sv', function(source, args, user)
if (irpCore.GetPlayerData().job.name == 'police') then
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsIn(ped, false)
	for k,v in pairs(Config.PoliceGarage) do 
		if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then

		if tostring(args[1]) == nil then
			return
		else
			if tostring(args[1]) ~= nil then
				local argh = args[1]

				if argh == '1' then
					local model = GetHashKey(Config.VehList[1])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 2.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '2' then
					local model = GetHashKey(Config.VehList[2])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '3' then
					local model = GetHashKey(Config.VehList[3])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '4' then
					local model = GetHashKey(Config.VehList[4])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '5' then
					local model = GetHashKey(Config.VehList[5])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '6' then
					local model = GetHashKey(Config.VehList[6])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '7' then
					local model = GetHashKey(Config.VehList[7])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '8' then -- Boat
					local model = GetHashKey(Config.VehList[8])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 2.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '9' then -- Heli
					local model = GetHashKey(Config.VehList[9])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '10' then -- Heli
					local model = GetHashKey(Config.VehList[10])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				elseif argh == '11' then -- Heli
					local model = GetHashKey(Config.VehList[11])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '12' then -- Heli
				local model = GetHashKey(Config.VehList[12])
				local playerPed = PlayerPedId()
				local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
				local heading = GetEntityHeading(playerPed)

				irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
				local plate = GetVehicleNumberPlateText(vehicle)
				exports["irp-carhud"]:SetFuel(vehicle, 100)
				TriggerServerEvent('garage:addKeys', plate)
				TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '13' then -- Heli
					local model = GetHashKey(Config.VehList[13])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '14' then -- Heli
					local model = GetHashKey(Config.VehList[14])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '15' then -- Heli
					local model = GetHashKey(Config.VehList[15])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '16' then -- Heli
					local model = GetHashKey(Config.VehList[16])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '17' then -- Heli
					local model = GetHashKey(Config.VehList[17])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
			elseif argh == '18' then -- Heli
					local model = GetHashKey(Config.VehList[18])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
				end)
			elseif argh == '19' then -- Heli
					local model = GetHashKey(Config.VehList[19])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					irpCore.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["irp-carhud"]:SetFuel(vehicle, 100)
					TriggerServerEvent('garage:addKeys', plate)
					TriggerEvent('DoLongHudText', 'You received keys to the vehicle.', 1)
					end)
				end
			end
		end
	end
end
end
end)

RegisterCommand('impound', function(source)
	if irpCore.GetPlayerData().job.name == 'police' or irpCore.GetPlayerData().job.name == 'mecano' or irpCore.GetPlayerData().job.name == 'ambulance' then
		TriggerEvent('impoundVeh', source)
	end
end)

-- Create blips
Citizen.CreateThread(function()

	for k,v in pairs(Config.PoliceGarage) do
		local blip = AddBlipForCoord(v[1], v[2], v[3])

		SetBlipSprite (blip, 60)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 38)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Police Department')
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()

	for k,v in pairs(Config.EMSGarage) do
		local blip = AddBlipForCoord(v[1], v[2], v[3])

		SetBlipSprite (blip, 61)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Hospital')
		EndTextCommandSetBlipName(blip)
	end
end)


RegisterCommand("extra", function(source, args, rawCommand)
  local PlayerData = irpCore.GetPlayerData()
  if PlayerData.job.name == 'police' then
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local extraID = tonumber(args[1])
    local extra = args[1]
	local toggle = tostring(args[2])
	for k,v in pairs(Config.PoliceGarage) do 
	if IsPedInAnyVehicle(ped, true) then
	local veh = GetVehiclePedIsIn(ped, false)
		if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
    	if toggle == "true" then
        	toggle = 0
			TriggerEvent('DoLongHudText', 'Engine Toggled', 1)
    		end
    	if veh ~= nil and veh ~= 0 and veh ~= 1 then
      
        if extra == "all" then
          SetVehicleExtra(veh, 1, toggle)
          SetVehicleExtra(veh, 2, toggle)
          SetVehicleExtra(veh, 3, toggle)
          SetVehicleExtra(veh, 4, toggle)
          SetVehicleExtra(veh, 5, toggle)       
          SetVehicleExtra(veh, 6, toggle)
          SetVehicleExtra(veh, 7, toggle)
          SetVehicleExtra(veh, 8, toggle)
          SetVehicleExtra(veh, 9, toggle)               
          SetVehicleExtra(veh, 10, toggle)
          SetVehicleExtra(veh, 11, toggle)
          SetVehicleExtra(veh, 12, toggle)
          SetVehicleExtra(veh, 13, toggle)
          SetVehicleExtra(veh, 14, toggle)
          SetVehicleExtra(veh, 15, toggle)
          SetVehicleExtra(veh, 16, toggle)
          SetVehicleExtra(veh, 17, toggle)
          SetVehicleExtra(veh, 18, toggle)
          SetVehicleExtra(veh, 19, toggle)
          SetVehicleExtra(veh, 20, toggle)
		  TriggerEvent('DoLongHudText', 'Extra All Toggled', 1)
        elseif extraID == extraID then
          SetVehicleExtra(veh, extraID, toggle)
		 end
	    end
	  end
	 end
	end
  end
end, false)

RegisterCommand("emsextra", function(source, args, rawCommand)
	local PlayerData = irpCore.GetPlayerData()
	if PlayerData.job.name == 'ambulance' then
	  local ped = PlayerPedId()
	  local veh = GetVehiclePedIsIn(ped, false)
	  local extraID = tonumber(args[1])
	  local extra = args[1]
	  local toggle = tostring(args[2])
	  for k,v in pairs(Config.EMSGarage) do 
	  if IsPedInAnyVehicle(ped, true) then
	  local veh = GetVehiclePedIsIn(ped, false)
		  if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
		  if toggle == "true" then
			  toggle = 0
			  TriggerEvent('DoLongHudText', 'Extra Toggled', 1)
			  end
		  if veh ~= nil and veh ~= 0 and veh ~= 1 then
		
		  if extra == "all" then
			SetVehicleExtra(veh, 1, toggle)
			SetVehicleExtra(veh, 2, toggle)
			SetVehicleExtra(veh, 3, toggle)
			SetVehicleExtra(veh, 4, toggle)
			SetVehicleExtra(veh, 5, toggle)       
			SetVehicleExtra(veh, 6, toggle)
			SetVehicleExtra(veh, 7, toggle)
			SetVehicleExtra(veh, 8, toggle)
			SetVehicleExtra(veh, 9, toggle)               
			SetVehicleExtra(veh, 10, toggle)
			SetVehicleExtra(veh, 11, toggle)
			SetVehicleExtra(veh, 12, toggle)
			SetVehicleExtra(veh, 13, toggle)
			SetVehicleExtra(veh, 14, toggle)
			SetVehicleExtra(veh, 15, toggle)
			SetVehicleExtra(veh, 16, toggle)
			SetVehicleExtra(veh, 17, toggle)
			SetVehicleExtra(veh, 18, toggle)
			SetVehicleExtra(veh, 19, toggle)
			SetVehicleExtra(veh, 20, toggle)
			TriggerEvent('DoLongHudText', 'Extra All Toggled', 1)
		  elseif extraID == extraID then
			SetVehicleExtra(veh, extraID, toggle)
		   end
		  end
		end
	   end
	  end
	end
  end, false)
  


RegisterCommand('fix', function(source)
	if irpCore.GetPlayerData().job.name == 'police' then
		policeFix()
	end
end,false)


function policeFix()
	local ped = GetPlayerPed(-1)
	for k,v in pairs(Config.PoliceGarage) do 
		if IsPedInAnyVehicle(ped, true) then
			local veh = GetVehiclePedIsIn(ped, false)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
				TriggerEvent('DoLongHudText', 'Your vehicle is being repaired please wait', 1)
				FreezeEntityPosition(veh, false)
				exports["irp-taskbar"]:taskBar(5000, "Completing Task")
				TriggerEvent('DoLongHudText', 'Your vehicle has been repaired', 1)
				SetVehicleFixed(veh)
				SetVehicleDirtLevel(veh, 0.0)
				exports["irp-carhud"]:SetFuel(veh, 100)
				FreezeEntityPosition(veh, false)
			end
		end
	end
end

RegisterNetEvent('impoundVeh')
AddEventHandler('impoundVeh', function()

	local vehicle, attempt = irpCore.Game.GetVehicleInDirection(), 0


	while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
		Citizen.Wait(100)
		NetworkRequestControlOfEntity(vehicle)
		attempt = attempt + 1
	end

	if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
		exports["irp-taskbar"]:taskBar(3000, "Impounding")
		irpCore.Game.DeleteVehicle(vehicle)
		TriggerEvent('DoLongHudText', 'vehicle impounded', 1)
	end
end)
