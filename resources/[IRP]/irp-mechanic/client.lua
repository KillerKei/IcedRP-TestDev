irpCore                           = nil

Citizen.CreateThread(function()
    while irpCore == nil do
      TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)
      Citizen.Wait(0)
    end
end)

function VehicleInFront()
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
  local a, b, c, d, result = GetRaycastResult(rayHandle)
  return result
end

RegisterCommand('clean', function()
  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)
  local PlayerData = irpCore.GetPlayerData()
  if PlayerData.job.name == 'mecano' then

    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

      local vehicle = nil

      if IsPedInAnyVehicle(playerPed, false) then
        vehicle = GetVehiclePedIsIn(playerPed, false)
      else
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
      end

      if DoesEntityExist(vehicle) then
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
        Citizen.CreateThread(function()
          Citizen.Wait(10000)
          SetVehicleDirtLevel(vehicle, 0)
          ClearPedTasksImmediately(playerPed)
          TriggerEvent('DoLongHudText', 'Vehicle Cleaned', 1)
        end)
      end
    end
  end
end)

local reapiring = false
RegisterNetEvent('irp-mecanojob:onFixkit')
AddEventHandler('irp-mecanojob:onFixkit', function()
  local playerped = PlayerPedId()
  local coordA = GetEntityCoords(playerped, 1)
  local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
  local targetVehicle = getVehicleInDirection(coordA, coordB)


  if targetVehicle ~= 0 then

        local d1,d2 = GetModelDimensions(GetEntityModel(targetVehicle))
        local moveto = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0,d2["y"]+0.5,0.2)
        local dist = #(vector3(moveto["x"],moveto["y"],moveto["z"]) - GetEntityCoords(PlayerPedId()))
        local count = 1000
        local fueltankhealth = GetVehiclePetrolTankHealth(targetVehicle)

        while dist > 1.5 and count > 0 do
            dist = #(vector3(moveto["x"],moveto["y"],moveto["z"]) - GetEntityCoords(PlayerPedId()))
            Citizen.Wait(1)
            count = count - 1
            DrawText3Ds(moveto["x"],moveto["y"],moveto["z"],"Move here to repair.")
        end

        if reapiring then return end
        reapiring = true
        
        local timeout = 20

        NetworkRequestControlOfEntity(targetVehicle)

        while not NetworkHasControlOfEntity(targetVehicle) and timeout > 0 do 
            NetworkRequestControlOfEntity(targetVehicle)
            Citizen.Wait(100)
            timeout = timeout -1
        end


        if dist < 1.5 then
            TriggerEvent("animation:repair",targetVehicle)
            fixingvehicle = true

            local repairlength = 1000
            local finished = exports["irp-taskbarskill"]:taskBar(15000,math.random(10,20))

            if finished ~= 100 then
                fixingvehicle = false
                reapiring = false
                ClearPedTasks(playerped)
                return
            end

            if finished == 100 then
              local finished2 = exports["irp-taskbarskill"]:taskBar(1500, math.random(4,7))
              if finished2 ~= 100 then
                fixingvehicle = false
                reapiring = false
                ClearPedTasks(playerped)
                return
              end

              if finished2 == 100 then
                TriggerServerEvent("inventory:removeItem","fixkit", 1)
                        if GetVehicleEngineHealth(targetVehicle) < 900.0 then
                            SetVehicleEngineHealth(targetVehicle, 900.0)
                        end
                        if GetVehicleBodyHealth(targetVehicle) < 945.0 then
                            SetVehicleBodyHealth(targetVehicle, 945.0)
                        end

                        if fueltankhealth < 3800.0 then
                            SetVehiclePetrolTankHealth(targetVehicle, 3800.0)
                        end
                    end                    

                for i = 0, 5 do
                    SetVehicleTyreFixed(targetVehicle, i) 
                end
              end
            ClearPedTasks(playerped)
        end
        fixingvehicle = false
    end
    reapiring = false
end)


RegisterNetEvent('irp-mecanojob:onFixkit2')
AddEventHandler('irp-mecanojob:onFixkit2', function()
  local playerped = PlayerPedId()
  local coordA = GetEntityCoords(playerped, 1)
  local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
  local targetVehicle = getVehicleInDirection(coordA, coordB)


  if targetVehicle ~= 0 then

        local d1,d2 = GetModelDimensions(GetEntityModel(targetVehicle))
        local moveto = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0,d2["y"]+0.5,0.2)
        local dist = #(vector3(moveto["x"],moveto["y"],moveto["z"]) - GetEntityCoords(PlayerPedId()))
        local count = 1000
        local fueltankhealth = GetVehiclePetrolTankHealth(targetVehicle)
        local chance = math.random(1,3)

        while dist > 1.5 and count > 0 do
            dist = #(vector3(moveto["x"],moveto["y"],moveto["z"]) - GetEntityCoords(PlayerPedId()))
            Citizen.Wait(1)
            count = count - 1
            DrawText3Ds(moveto["x"],moveto["y"],moveto["z"],"Move here to repair.")
        end

        if reapiring then return end
        reapiring = true
        
        local timeout = 20

        NetworkRequestControlOfEntity(targetVehicle)

        while not NetworkHasControlOfEntity(targetVehicle) and timeout > 0 do 
            NetworkRequestControlOfEntity(targetVehicle)
            Citizen.Wait(100)
            timeout = timeout -1
        end


        if dist < 1.5 then
            TriggerEvent("animation:repair",targetVehicle)
            fixingvehicle = true

            local repairlength = 1000
            local finished = exports["irp-taskbarskill"]:taskBar(15000,math.random(10,20))

            if finished ~= 100 then
                fixingvehicle = false
                reapiring = false
                ClearPedTasks(playerped)
                return
            end

            if finished == 100 then
              local finished2 = exports["irp-taskbarskill"]:taskBar(1500, math.random(6,10))
              if finished2 ~= 100 then
                fixingvehicle = false
                reapiring = false
                ClearPedTasks(playerped)
                return
              end

              if finished2 == 100 then
                      if GetVehicleEngineHealth(targetVehicle) < 200.0 then
                            SetVehicleEngineHealth(targetVehicle, 200.0)
                        end
                        if GetVehicleBodyHealth(targetVehicle) < 245.0 then
                            SetVehicleBodyHealth(targetVehicle, 245.0)
                        end

                        if fueltankhealth < 2800.0 then
                            SetVehiclePetrolTankHealth(targetVehicle, 2800.0)
                        end
                        if chance == 1 then
                          TriggerServerEvent("inventory:removeItem","fixkit2", 1)
                          TriggerEvent('DoLongHudText', 'Your repair kit broke!', 2)
                        else
                        if chance == 2 or chance == 3 then
                          TriggerEvent('DoLongHudText', 'Success', 1)
                        end
                    end                    

                for i = 0, 5 do
                    SetVehicleTyreFixed(targetVehicle, i) 
                end
              end
            end
            ClearPedTasks(playerped)
        end
        fixingvehicle = false
    end
    reapiring = false
end)


local towtruck = nil
local attachedVehicle = nil
local createdBlips = {}

---------------------------------------------------------------------------
-- Starter Blips
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    for a = 1, #XTowConfig.TruckDepos do
        local blip = AddBlipForCoord(XTowConfig.TruckDepos[a].x, XTowConfig.TruckDepos[a].y, XTowConfig.TruckDepos[a].z)
        SetBlipSprite(blip, 357)
        SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.7)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Impound Lot")
        EndTextCommandSetBlipName(blip)
    end
end)

---------------------------------------------------------------------------
-- TRUCK DEPOS
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        for a = 1, #XTowConfig.TruckDepos do
            local ped = GetPlayerPed(PlayerId())
            local pedPos = GetEntityCoords(ped, false)
            local distance = Vdist(pedPos.x, pedPos.y, pedPos.z, XTowConfig.TruckDepos[a].x, XTowConfig.TruckDepos[a].y, XTowConfig.TruckDepos[a].z)
            if distance <= 15.0 then
                DrawMarker(1, XTowConfig.TruckDepos[a].x, XTowConfig.TruckDepos[a].y, XTowConfig.TruckDepos[a].z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 150, 61, 61, 1.0, 0, 0, 0, 0, 0, 0, 0)
                if distance <= 1.2 then
                    if towtruck == nil then
                        Draw3DText(XTowConfig.TruckDepos[a].x, XTowConfig.TruckDepos[a].y, XTowConfig.TruckDepos[a].z, tostring("[E] - Acquire a towtruck"))
                    else
                        Draw3DText(XTowConfig.TruckDepos[a].x, XTowConfig.TruckDepos[a].y, XTowConfig.TruckDepos[a].z, tostring("[E] - Return your towtruck"))
                    end
                    if IsControlJustPressed(1, 38) and attachedVehicle == nil then
                        if towtruck == nil then
                            AcquireTowtruck(XTowConfig.TruckDepos[a].spawn)
                            TriggerServerEvent("TokoVoip:addPlayerToRadio", 7.0, GetPlayerServerId(PlayerId()))
                        else
                            ReturnTowtruck()
                            TriggerServerEvent("TokoVoip:removePlayerFromAllRadio",GetPlayerServerId(PlayerId()))
                        end
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)

---------------------------------------------------------------------------
-- IMPOUNDS
---------------------------------------------------------------------------
local busy = false
Citizen.CreateThread(function()
    while true do
      while busy do
        Citizen.Wait(0)
      end
        if towtruck ~= nil then
            for a = 1, #XTowConfig.Impounds do
                local vehPos = GetEntityCoords(towtruck, false)
                local distance = Vdist(vehPos.x, vehPos.y, vehPos.z, XTowConfig.Impounds[a].x, XTowConfig.Impounds[a].y, XTowConfig.Impounds[a].z)
                    if distance <= 10.0 then
                        if attachedVehicle ~= nil then
                            Draw3DText(XTowConfig.Impounds[a].x, XTowConfig.Impounds[a].y, XTowConfig.Impounds[a].z, tostring("[E] - Impound Vehicle"))
                        else
                            Draw3DText(XTowConfig.Impounds[a].x, XTowConfig.Impounds[a].y, XTowConfig.Impounds[a].z, tostring("You have no vehicle to impound"))
                        end
                        if IsControlJustPressed(1, 38) and attachedVehicle ~= nil then
                          if not IsPedInAnyVehicle(PlayerPedId(), false) then
                            busy = true
                            ImpoundVehicle()
                          else
                            TriggerEvent('DoLongHudText', 'Must be outside of towtruck to impound', 2)
                          end
                        end
                    end
            end
        end
        Citizen.Wait(0)
    end
end)

---------------------------------------------------------------------------
-- VEHICLE FLIPPED LOGIC
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if towtruck ~= nil then
            if attachedVehicle ~= nil then
                if IsEntityUpsidedown(towtruck) then
                    DetachEntity(attachedVehicle, false, false)
                    attachedVehicle = nil
                end
            end
        end
        Citizen.Wait(0)
    end
end)

---------------------------------------------------------------------------
-- TOWTRUCK LOGIC
--------------------------------------------------------------------------- TOWTRUCK HEIGHT - 1.0866451263428
RegisterCommand("tow", function()
    if towtruck ~= nil then
        if attachedVehicle == nil then
            local frontVehicle = GetVehicleInFront()
            if frontVehicle ~= towtruck then
                if CheckBlacklist(frontVehicle) == false then
                  local playerped = PlayerPedId()
                  local coordA = GetEntityCoords(playerped, 1)
		              local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
		              local targetVehicle = getVehicleInDirection(coordA, coordB)
                  local d1,d2 = GetModelDimensions(GetEntityModel(towtruck))
			            local back = GetOffsetFromEntityInWorldCoords(towtruck, 0.0,d1["y"]-1.0,0.0)

		            	local aDist = #(back - GetEntityCoords(targetVehicle))
	        
	                if aDist > 3.5 then
	                	local count = 1000
		                while count > 0 do
		                  Citizen.Wait(1)
		                  count = count - 1
		                  Draw3DText(back["x"],back["y"],back["z"],"Vehicle must be here to tow.")
		                end
		                return
                  end
                  busy = true
                    AttachVehicle(frontVehicle)
                else
                    TriggerEvent('DoLongHudText', 'That is a blacklisted vehicle. You can\'t attach that', 2)
                end
            end
        else
          busy = true
            DetachVehicle()
        end
    end
end, false)

function getVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

---------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------
function AcquireTowtruck(spawn)
    local model = GetHashKey(XTowConfig.TruckModel)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    local spawned = CreateVehicle(model, spawn.x, spawn.y, spawn.z, spawn.h, 1, 1)
    PlaceObjectOnGroundProperly(spawned)
    SetEntityAsMissionEntity(spawned, 1, 1)
    SetEntityAsNoLongerNeeded(spawned)
    towtruck = spawned

    -- Create Blips
    for a = 1, #XTowConfig.Impounds do
        local blip = AddBlipForCoord(XTowConfig.Impounds[a].x, XTowConfig.Impounds[a].y, XTowConfig.Impounds[a].z)
        SetBlipSprite(blip, 398)
        SetBlipColour(blip, 71)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 1.0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Towtruck Impound")
        EndTextCommandSetBlipName(blip)
        table.insert(createdBlips, blip)
    end
end

function ReturnTowtruck()
    DeleteEntity(towtruck)
    if not DoesEntityExist(towtruck) then
        towtruck = nil
    end

    for a = 1, #createdBlips do
        RemoveBlip(createdBlips[a])
    end
    createdBlips = {}
end

local towingProcess = false
RegisterNetEvent('animation:tow')
AddEventHandler('animation:tow', function()
	towingProcess = true
    local lPed = PlayerPedId()
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end
    while towingProcess do

        if not IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3) then
            ClearPedSecondaryTask(lPed)
            TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasks(lPed)
end)

function AttachVehicle(vehicle)
  TriggerEvent('animation:tow')
  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'towtruck2', 0.5)
  TaskTurnPedToFaceEntity(PlayerPedId(), towtruck, 1.0)
  exports["irp-taskbar"]:taskBar(15000, "Hooking up vehicle")
    local towOffset = GetOffsetFromEntityInWorldCoords(towtruck, 0.0, -2.2, 0.4)
    local towRot = GetEntityRotation(towtruck, 1)
    local vehicleHeightMin, vehicleHeightMax = GetModelDimensions(GetEntityModel(vehicle))
    print(vehicleHeightMin, vehicleHeightMax)

    AttachEntityToEntity(vehicle, towtruck, GetEntityBoneIndexByName(towtruck, "bodyshell"), 0, -2.2, 0.4 - vehicleHeightMin.z, 0, 0, 0, 1, 1, 0, 1, 0, 1)
    attachedVehicle = vehicle
    towingProcess = false
    busy = false
end

function DetachVehicle()
  TriggerEvent('animation:tow')
  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'towtruck', 0.5)
  TaskTurnPedToFaceEntity(PlayerPedId(), towtruck, 1.0)
  exports["irp-taskbar"]:taskBar(7000, "Unloading Vehicle")
    local towOffset = GetOffsetFromEntityInWorldCoords(towtruck, 0.0, -10.0, 0.0)
    DetachEntity(attachedVehicle, false, false)
    SetEntityCoords(attachedVehicle, towOffset.x, towOffset.y, towOffset.z, 1, 0, 0, 1)
    PlaceObjectOnGroundProperly(attachedVehicle)
    attachedVehicle = nil
    towingProcess = false
    busy = false
end

function ImpoundVehicle()
  TriggerEvent('animation:tow')
  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'towtruck', 0.5)
  TaskTurnPedToFaceEntity(PlayerPedId(), towtruck, 1.0)
  exports["irp-taskbar"]:taskBar(7000, "Unloading Vehicle")
  licensePlate = GetVehicleNumberPlateText(attachedVehicle)
  TriggerServerEvent("irp-imp:mechCar", licensePlate)
    DeleteEntity(attachedVehicle)
    if not DoesEntityExist(attachedVehicle) then
        attachedVehicle = nil
    end
    TriggerServerEvent('towtruck:giveCash', math.ceil(math.random(50, 120)))
    towingProcess = false
    busy = false
end

function CheckBlacklist(vehicle)
    for a = 1, #XTowConfig.BlacklistedVehicles do
        if GetHashKey(XTowConfig.BlacklistedVehicles[a]) == GetEntityModel(vehicle) then
            return true
        end
    end
    return false
end

function Draw3DText(x, y, z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextDropshadow(0, 0, 0, 0, 155)
  SetTextEdge(1, 0, 0, 0, 250)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

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
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)

end


function GetVehicleInFront()
    local plyCoords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local plyOffset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 5.0, 0.0)
    local rayHandle = StartShapeTestCapsule(plyCoords.x, plyCoords.y, plyCoords.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 10, GetPlayerPed(PlayerId()), 7)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    return vehicle
end

-- Animations
RegisterNetEvent('animation:load')
AddEventHandler('animation:load', function(dict)
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end)

RegisterNetEvent('animation:repair')
AddEventHandler('animation:repair', function(veh)
    SetVehicleDoorOpen(veh, 4, 0, 0)
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    TaskTurnPedToFaceEntity(PlayerPedId(), veh, 1.0)
    Citizen.Wait(1000)

    while fixingvehicle do
        local anim3 = IsEntityPlayingAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 3)
        if not anim3 then
            TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    SetVehicleDoorShut(veh, 4, 1, 1)
end)