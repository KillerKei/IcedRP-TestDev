function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 200)
end

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

irpCore = nil

 Citizen.CreateThread(function()
  while irpCore == nil do
      TriggerEvent('irp:getSharedObject', function(obj)
          irpCore = obj
      end)
      Citizen.Wait(7)
  end
end)

function OpenDressing()

    irpCore.UI.Menu.Open('default', GetCurrentResourceName(), 'room',
	{
		title    = 'Player Clothing',
		align    = 'top-left',
		elements = {
            {label = 'Change Clothes', value = 'player_dressing'},
	        {label = 'Remove Clothes', value = 'remove_cloth'}
        }
	}, function(data, menu)

		if data.current.value == 'player_dressing' then 
            menu.close()
			irpCore.TriggerServerCallback('wardrobe:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				irpCore.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
				{
					title    = 'Player Clothes',
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)

					TriggerEvent('skinchanger:getSkin', function(skin)
						irpCore.TriggerServerCallback('wardrobe:getPlayerOutfit', function(clothes)
							TriggerEvent('skinchanger:loadClothes', skin, clothes)
							TriggerEvent('irp-skin:setLastSkin', skin)

							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('irp-skin:save', skin)
							end)
						end, data2.current.value)
					end)

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		elseif data.current.value == 'remove_cloth' then
            menu.close()
			irpCore.TriggerServerCallback('wardrobe:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				irpCore.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
					title    = 'Remove Clothes',
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('wardrobe:removeOutfit', data2.current.value)
                    TriggerEvent('DoLongHudText', 'Outfit Removed', 2)
				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
        menu.close()
	end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local distance = GetDistanceBetweenCoords(coords, -811.59, 175.24, 76.75, true)
        if distance < 1.0 then
            DrawText3Ds(-811.59, 175.24, 76.75, '[E] - Change Outfits')
            if IsControlJustReleased(0, Keys['E']) then
                OpenDressing()
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, -1171.53, -892.43, 13.91, true) < 3 then
            DrawText3Ds(-1171.53, -892.43, 13.91, "[E] - Call Delivery Vehicle")
            if IsControlJustPressed(0, Keys['E']) then
                if irpCore.GetPlayerData().job.name == 'burgershot' then
                    irpCore.Game.SpawnVehicle('stalion2', vector3(-1171.53, -892.43, 13.91), 26.01, function(vehicle)
                        SetVehicleOnGroundProperly(vehicle)
                        Citizen.Wait(10)
                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                        local plate = GetVehicleNumberPlateText(vehicle)
                        TriggerServerEvent('garage:addKeys', plate)
                        TriggerEvent('DoLongHudText', 'You received keys for this vehicle', 1)
                    end)
                else
                    TriggerEvent('DoLongHudText', 'You are not a Burger Shot Employee', 2)
                end
            end
        end
        if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, -1166.91, -894.63, 13.99, true) < 3 then
            DrawText3Ds(-1166.91, -894.63, 13.99, "[E] - Return Delivery Vehicle")
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            if IsControlJustPressed(0, Keys['E']) then
                if irpCore.GetPlayerData().job.name == 'burgershot' then
                    irpCore.Game.DeleteVehicle(vehicle)
                else
                    TriggerEvent('DoLongHudText', 'You are not a Burger shot Employeee', 2)
                end
            end
        end
    end
end)