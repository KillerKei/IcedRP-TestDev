Keys = {
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

local irpCore = nil
local myMotel = false
local curMotel = nil
local curRoom = nil
local curRoomOwner = false
local inRoom = false
local roomOwner = nil
local playerIdent = nil
local inMotel = false
local closeToClothes = false

Citizen.CreateThread(function()
	while irpCore == nil do
		TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)
		Citizen.Wait(0)
	end
	while irpCore.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	irpCore.PlayerData = irpCore.GetPlayerData()
    createBlips()
    playerIdent = irpCore.GetPlayerData().identifier
end)

function createBlips()
    for k,v in pairs(Config.Zones) do
            local blip = AddBlipForCoord(tonumber(v.Pos.x), tonumber(v.Pos.y), tonumber(v.Pos.z))
			SetBlipSprite(blip, v.Pos.sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, v.Pos.size)
			SetBlipColour(blip, v.Pos.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.Name)
			EndTextCommandSetBlipName(blip)
    end
end

function getMyMotel()
irpCore.TriggerServerCallback('irp-motels:checkOwnership', function(owned)
    myMotel = owned
end)
end

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
    if instance.type == 'motelroom' then
        roomOwner = irpCore.GetPlayerData().identifier
		TriggerEvent('instance:enter', instance)
	end
end)

RegisterNetEvent('irp-motels:cancelRental')
AddEventHandler('irp-motels:cancelRental', function(room)
    local motelName = nil
    local motelRoom = nil
    for k,v in pairs(Config.Zones) do
        for kk,vm in pairs(v.Rooms) do       
            if room == vm.instancename then
                motelName = v.Name
                motelRoom = vm.number
            end
        end
    end

    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_CLIPBOARD', 0, true)
    exports["irp-taskbar"]:taskBar(3000, "Cancelling Rental")
        myMotel = false
        TriggerServerEvent("irp-motels:cancelRental", room)
        TriggerEvent('DoLongHudText', 'You have cancelled the rental.', 2)
        Citizen.Wait(750)
        TriggerEvent('DoLongHudText', 'If you had anything stashed, the motel company said that they\'ll hold it for the next couple of minutes!', 1)
        ClearPedTasksImmediately(playerPed)
end)

imClosesToRoom = function()
    local ply = PlayerPedId()
    if closeToClothes then
      return true
    else
      return false
    end
  end


function PlayerDressings()

    irpCore.UI.Menu.Open('default', GetCurrentResourceName(), 'room',
	{
		title    = 'Player Clothing',
		align    = 'bottom-right',
		elements = {
            {label = _U('player_clothes'), value = 'player_dressing'},
	        {label = _U('remove_cloth'), value = 'remove_cloth'}
        }
    }, function(data, menu)

		if data.current.value == 'player_dressing' then 
            menu.close()
			irpCore.TriggerServerCallback('irp-motels:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				irpCore.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
				{
					title    = _U('player_clothes'),
					align    = 'bottom-right',
					elements = elements
				}, function(data2, menu2)

					TriggerEvent('skinchanger:getSkin', function(skin)
						irpCore.TriggerServerCallback('irp-motels:getPlayerOutfit', function(clothes)
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
			irpCore.TriggerServerCallback('irp-motels:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				irpCore.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
					title    = _U('remove_cloth'),
					align    = 'bottom-right',
					elements = elements
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('irp-motels:removeOutfit', data2.current.value)
                    TriggerEvent('DoLongHudText', 'You have removed and outfit from your wardrobe.', 2)
				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
        menu.close()
	end)
end

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(instance)
    if instance.type == 'motelroom' then
        
        local property = instance.data.property
        local motel = instance.data.motel
        local isHost   = GetPlayerFromServerId(instance.host) == PlayerId()
            Citizen.Wait(1000)
        local networkChannel = instance.data.vid
        NetworkSetVoiceChannel(networkChannel)
	end
end)

AddEventHandler('instance:loaded', function()
    TriggerEvent('instance:registerType', 'motelroom', function(instance)
        EnterProperty(instance.data.property, instance.data.owner, instance.data.motel, instance.data.room)
    end, function(instance)
        Citizen.InvokeNative(0xE036A705F989E049)
		ExitProperty(instance.data.property, instance.data.motel, instance.data.room)
	end)
end)

function EnterProperty(name, owner, motel, room)
    curMotel      = motel
    curRoom       = room
    inRoom        = true
    inMotel       = true
    local playerPed     = PlayerPedId() 
    TriggerServerEvent('irp-motels:SaveMotel', curMotel, curRoom)
    Citizen.CreateThread(function()
        TriggerEvent('dooranim')
		DoScreenFadeOut(800)
		while not IsScreenFadedOut() do
			Citizen.Wait(0)
        end
        for k,v in pairs(Config.Zones) do     
                if curMotel == k then
                    SetEntityCoords(playerPed, v.roomLoc.x, v.roomLoc.y, v.roomLoc.z)
                end
        end
        TriggerEvent('InteractSound_CL:PlayOnOne', 'doorenter', 0.8)
        TriggerEvent('DoLongHudText', 'Please wait!', 1)
        Citizen.Wait(10000)
        DoScreenFadeIn(800)
	end)
end

RegisterNetEvent('irp-motels:enterRoom')
AddEventHandler('irp-motels:enterRoom', function(room, motel)
    local roomID = nil
    local playerPed = PlayerPedId()
    local roomIdent = room
    local reqmotel = motel
    irpCore.TriggerServerCallback('irp-motels:getMotelRoomID', function(roomno)
    roomID = roomno
    end, room)
    Citizen.Wait(500)
    if roomID ~= nil then
    local instanceid = 'motel'..roomID..''..roomIdent
        TriggerEvent('instance:create', 'motelroom', {property = instanceid, owner = irpCore.GetPlayerData().identifier, motel = reqmotel, room = roomIdent, vid = roomID})
    end
end)

RegisterNetEvent('irp-motels:exitRoom')
AddEventHandler('irp-motels:exitRoom', function(motel, room)
    local roomID = room
    local playerPed = PlayerPedId()
    Citizen.Wait(500)
    roomOwner = nil
    TriggerEvent('dooranim')
    TriggerEvent('InteractSound_CL:PlayOnOne', 'doorexit', 0.8)
   
    Citizen.Wait(500)
    DoScreenFadeOut(270)
    Citizen.Wait(1200)
    TriggerEvent('instance:leave')
    SetEntityVisible(playerPed, 1)
end)

RegisterNetEvent('irp-motels:roomOptions')
AddEventHandler('irp-motels:roomOptions', function(room, motel)
    local motelName = nil
    local motelRoom = nil
    for k,v in pairs(Config.Zones) do
        for kk,vm in pairs(v.Rooms) do       
            if room == vm.instancename then
                motelName = v.Name
                motelRoom = vm.number
            end
        end
    end
    irpCore.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'irp-motels',
        {
            title    = motelName..' Room '..motelRoom,
            align    = 'bottom-right',
            elements = { 
                { label = 'Enter Room', value = 'enter' },
                { label = 'Cancel Rental', value = 'cancel' }
            }
        },
    function(data, entry)
        local value = data.current.value

        if value == 'enter' then
            entry.close()
            TriggerEvent("irp-motels:enterRoom", room, motel)

        elseif value == 'cancel' then
            entry.close()
            TriggerEvent("irp-motels:cancelRental", room)
        end

    end,
    function(data, entry)
        entry.close()
    end)
end)


RegisterNetEvent('irp-motels:roomMenu')
AddEventHandler('irp-motels:roomMenu', function(room, motel)
    local motelName = nil
    local motelRoom = nil
    local roomID = nil
    local owner = irpCore.GetPlayerData().identifier
    for k,v in pairs(Config.Zones) do
        for kk,vm in pairs(v.Rooms) do       
            if room == vm.instancename then
                motelName = v.Name
                motelRoom = vm.number
            end
        end
    end
   
        options = {}

        if roomOwner == playerIdent then
        table.insert(options, {label = 'Open Room Inventory', value = 'inventory'})
        table.insert(options, {label = 'Invite Citizen', value = 'inviteplayer'})
        end
        
        

    irpCore.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'irp-motels',
        {
            title    = motelName..' Room '..motelRoom,
            align    = 'bottom-right',
            elements = options
        },
    function(data, menu)
        local value = data.current.value
        if value == 'inventory' then
            menu.close()

            owner = irpCore.GetPlayerData().identifier
        if roomOwner == owner then
            exports["irp-taskbar"]:taskBar(2000, "Opening Stash")
                TriggerEvent('InteractSound_CL:PlayOnOne', 'Stash', 0.8)
                OpenPropertyInventoryMenu('motels', owner)
                TriggerEvent("irp-motels:openInventory") 
        else
            TriggerEvent('DoLongHudText', 'Accessible by Motel Owner only!', 2)
        end
        elseif value == 'inviteplayer' then
            local myInstance = nil
            local roomIdent = room
            local reqmotel = motel
            
            for k,v in pairs(Config.Zones) do
                for kk,vm in pairs(v.Rooms) do       
                    if room == vm.instancename then
                        playersInArea = irpCore.Game.GetPlayersInArea(vm.entry, 5.0)
                    end
                end
            end
             
			local elements      = {}
            if playersInArea ~= nil then
                for i=1, #playersInArea, 1 do
                    if playersInArea[i] ~= PlayerId() then
                        table.insert(elements, {label = GetPlayerName(playersInArea[i]), value = playersInArea[i]})
                    end
                end
            else
                table.insert(elements, {label = 'No Citizens Outside.'})
            end

			irpCore.UI.Menu.Open('default', GetCurrentResourceName(), 'room_invite',
			{
				title    = motelName..' Room '..motelRoom .. ' - ' .. _U('invite') ..' Citizen',
				align    = 'bottom-right',
				elements = elements,
            }, function(data2, menu2)
                irpCore.TriggerServerCallback('irp-motels:getMotelRoomID', function(roomno)
                    roomID = roomno
                    end, room)
                myInstance = 'motel'..roomID..''..roomIdent
				TriggerEvent('instance:invite', 'motelroom', GetPlayerServerId(data2.current.value), {property = myInstance, owner = irpCore.GetPlayerData().identifier, motel = reqmotel, room = roomIdent, vid = roomID})
                TriggerEvent('DoLongHudText', 'You invited '.. GetPlayerName(data2.current.value) .. ' to your hotel room.', 1)
			end, function(data2, menu2)
				menu2.close()
			end)
        end
    end,
    function(data, menu)
        menu.close()
    end)
end)

RegisterNetEvent('irp-motels:rentRoom')
AddEventHandler('irp-motels:rentRoom', function(room)
    local motelName = nil
    local motelRoom = nil
    for k,v in pairs(Config.Zones) do
        for kk,vm in pairs(v.Rooms) do       
            if room == vm.instancename then
                motelName = v.Name
                motelRoom = vm.number
            end
        end
    end

    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_CLIPBOARD', 0, true)
    exports["irp-taskbar"]:taskBar(3000, "Renting Room")
        TriggerServerEvent('irp-motels:rentRoom', room)
        TriggerEvent('DoLongHudText', 'You have rented room '..motelRoom, 2)
        Citizen.Wait(750)
        ClearPedTasksImmediately(playerPed)
end)

function roomMarkers()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)

    -- Room Menu Marker
    for k,v in pairs(Config.Zones) do
        distance = GetDistanceBetweenCoords(coords, v.Menu.x, v.Menu.y, v.Menu.z, true)
        if distance < 1.0 then
            DrawText3D(v.Menu.x, v.Menu.y, v.Menu.z + 0.35, 'Press [~g~E~s~] to access menu.')
                if IsControlJustReleased(0, Keys['E']) then
                    TriggerEvent('irp-motels:roomMenu', curRoom, curMotel)
                end
        end
    end


    for k,v in pairs(Config.Zones) do
        distance = GetDistanceBetweenCoords(coords, v.roomExit.x, v.roomExit.y, v.roomExit.z, true)
        if distance < 1.0 then
            if roomOwner == playerIdent then
            DrawText3D(v.roomExit.x, v.roomExit.y, v.roomExit.z + 0.35, 'Press [~g~E~s~] to exit.')
                if IsControlJustReleased(0, Keys['E']) then
                    TriggerEvent('irp-motels:exitRoom', curRoom, curMotel)
                end
            end
        end
    end


    -- Clothing Menu
    for k,v in pairs(Config.Zones) do
        distance = GetDistanceBetweenCoords(coords, v.Inventory.x, v.Inventory.y, v.Inventory.z, true)
        if distance < 1.0 then
            closeToClothes = true
            if roomOwner == playerIdent then
                DrawText3D(v.Inventory.x, v.Inventory.y, v.Inventory.z + 0.35, '/outfits')
            end
        else
            closeToClothes = false
        end
    end

end


function enteredMarker()
   
    local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

if myMotel then 
    for k,v in pairs(Config.Zones) do
        for km,vm in pairs(v.Rooms) do
            if vm.instancename == myMotel then
                distance = GetDistanceBetweenCoords(coords, vm.entry.x, vm.entry.y, vm.entry.z, true)
                if (distance < v.Boundries) then
                DrawMarker(20, vm.entry.x, vm.entry.y, vm.entry.z+0.15, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 43, 196, 253, 200, false, true, 2, 1, nil, nil, false)	
                end
                if (distance < 1.0) then
                    DrawText3D(vm.entry.x, vm.entry.y, vm.entry.z + 0.35, 'Press [~g~E~s~] for options.')
                    if IsControlJustReleased(0, Keys['E']) then
                        TriggerEvent("irp-motels:roomOptions", vm.instancename, k)
                    end
                end
            end
        end
    end
else
        for k,v in pairs(Config.Zones) do
            distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
            if (distance < v.Boundries) then
                for km,vm in pairs(v.Rooms) do
                    distance = GetDistanceBetweenCoords(coords, vm.entry.x, vm.entry.y, vm.entry.z, true)
                    if (distance < 1.0) then
                        DrawText3D(vm.entry.x, vm.entry.y, vm.entry.z + 0.35, 'Press [~g~E~s~] to rent Room ~b~'..vm.number..' ~w~for $~b~'..Config.PriceRental)
                        if IsControlJustReleased(0, Keys['E']) then
                            TriggerEvent('irp-motels:rentRoom', vm.instancename)
                        end
                    end
                end
            end
        end    
    end

end



function ExitProperty(name, motel, room)
	local property  = name
    local playerPed = PlayerPedId()
    inRoom          = false
    inMotel         = false
    TriggerServerEvent('irp-motels:DelMotel')
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)
		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end
        for k,v in pairs(Config.Zones) do
            for km,vm in pairs(v.Rooms) do
                if room == vm.instancename then
                SetEntityCoords(playerPed, vm.entry.x, vm.entry.y, vm.entry.z)
                end
            end
        end
		DoScreenFadeIn(800)
	end)
end

Citizen.CreateThread(function()
    Citizen.Wait(0)
    while true do
       Citizen.Wait(0)
       enteredMarker() 
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(0)
        while true do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            local coords    = GetEntityCoords(playerPed)

            if inRoom then
                roomMarkers()
            end 

            if not inMotel then
                for k,v in pairs(Config.Zones) do
                    distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
                    if (distance < v.Boundries) then
                        getMyMotel()
                        Citizen.Wait(3000)
                    end
                end
            end
        end
end)


function OpenPropertyInventoryMenu(owner)
    owner = irpCore.GetPlayerData().identifier
    if Config.ThirdPartyStorageSystem then
        TriggerEvent("irp-inventory:openInventory", {
            type = "motel",
            owner = owner
        })
    end
end


RegisterNetEvent('dooranim')
AddEventHandler('dooranim', function()
 ClearPedSecondaryTask(GetPlayerPed(-1))
 loadAnimDict("anim@heists@keycard@")
 TaskPlayAnim( GetPlayerPed(-1), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
 Citizen.Wait(850)
 ClearPedTasks(GetPlayerPed(-1))
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

DrawText3D = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	local scale = 0.45
	if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
    
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
	end
end