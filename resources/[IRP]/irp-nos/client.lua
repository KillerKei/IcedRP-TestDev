local currentVehicle = 0
local ready = true
local cooldown = 20
local nosAmount = 0
local nosBoost = 50.0
local showFlames = false
local prevVehicle = nil


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(1, 47) and currentVehicle ~= 0 then
            if ready then
                local localPed = GetPlayerPed(-1)
                if GetVehicleCurrentRpm(currentVehicle) > 0.3 then
                    if IsPedSittingInAnyVehicle(localPed) then
                        if (GetPedInVehicleSeat(currentVehicle, -1) == localPed) then
                            if nosAmount > 0 then
                                if IsToggleModOn(currentVehicle, 18) then
                                    TriggerServerEvent("takeNOSFromInventory")
                                    ready = false
                                    prevVehicle = currentVehicle
                                    TriggerServerEvent("eff_sound_start", VehToNet(currentVehicle))
                                    showFlames = true

                                    SetVehicleEnginePowerMultiplier(currentVehicle, nosBoost)
                                    SetVehicleEngineTorqueMultiplier(currentVehicle, nosBoost)
                                    Citizen.Wait(1000)
                                    showFlames = false
                                    Citizen.Wait(7000)

                                    SetVehicleEnginePowerMultiplier(currentVehicle, 1.0)
                                    SetVehicleEngineTorqueMultiplier(currentVehicle, 1.0)
                                    TriggerServerEvent("eff_sound_stop", VehToNet(currentVehicle))
                                else
                                    TriggerEvent("DoLongHudText","You do not have a turbo installed.",1)
                                end
                                
                            end
                            
                        else
                            TriggerEvent("DoLongHudText","You have to be in the car.",1)
                        end
                    end
                end
            end
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        if showFlames then
            TriggerServerEvent("flameEffect", VehToNet(currentVehicle))
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if not ready then
            if cooldown > 0 then
                cooldown = cooldown - 1
            elseif cooldown <= 0 then
                cooldown = 0
                ready = true
                cooldown = 20
            end
        end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
		currentVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        if currentVehicle ~= 0 then
            TriggerServerEvent("checkNOS")
        elseif currentVehicle == nil or currentVehicle == 0 then
            if prevVehicle ~= nil and prevVehicle ~= 0 then
                SetVehicleEnginePowerMultiplier(prevVehicle, 1.0)
                SetVehicleEngineTorqueMultiplier(prevVehicle, 1.0)
                TriggerServerEvent("eff_sound_stop", VehToNet(prevVehicle))
                prevVehicle = nil
            end
        end
	end
end)

function notification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(true, false)
end


RegisterNetEvent("returnNOS")
AddEventHandler("returnNOS", function (amount)
    nosAmount = amount
end)

RegisterNetEvent("c_eff_sound_start")
AddEventHandler("c_eff_sound_start", function(c_veh)
	SetVehicleBoostActive(NetToVeh(c_veh), 1)
end)

RegisterNetEvent("c_eff_sound_stop")
AddEventHandler("c_eff_sound_stop", function(c_veh)
	SetVehicleBoostActive(NetToVeh(c_veh), 0)
end)

RegisterNetEvent("cFlameEffect")
AddEventHandler("cFlameEffect", function(c_veh)
    flameLocations = { "exhaust", "exhaust_2" }
	for _,bones in pairs(flameLocations) do
		UseParticleFxAssetNextCall("core")
		createdPart = StartParticleFxLoopedOnEntityBone("veh_backfire", NetToVeh(c_veh), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(NetToVeh(c_veh), bones), 2.0, 0.0, 0.0, 0.0)
		StopParticleFxLooped(createdPart, 1)
	end
end)