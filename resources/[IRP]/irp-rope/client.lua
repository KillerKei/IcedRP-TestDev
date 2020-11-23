irpCore = nil

Citizen.CreateThread(function()
	while irpCore == nil do
		TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('irp:playerLoaded')
AddEventHandler('irp:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

local cuffed = false
local dict = "mp_arresting"
local anim = "idle"
local flags = 49
local ped = PlayerPedId()
local changed = false
local prevMaleVariation = 0
local prevFemaleVariation = 0
local femaleHash = GetHashKey("mp_f_freemode_01")
local maleHash = GetHashKey("mp_m_freemode_01")
local IsLockpicking    = false

RegisterNetEvent('irp-rope:cuff')
AddEventHandler('irp-rope:cuff', function()
    ped = GetPlayerPed(-1)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

        if GetEntityModel(ped) == femaleHash then
            prevFemaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 25, 0, 0)
        elseif GetEntityModel(ped) == maleHash then
            prevMaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 41, 0, 0)
        end

        SetEnablerope(ped, true)
        TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)

    cuffed = not cuffed
    changed = true
end)

RegisterNetEvent('irp-rope:uncuff')
AddEventHandler('irp-rope:uncuff', function()
    ped = GetPlayerPed(-1)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

        ClearPedTasks(ped)
        SetEnablerope(ped, false)
        UncuffPed(ped)

        if GetEntityModel(ped) == femaleHash then -- mp female
            SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
        elseif GetEntityModel(ped) == maleHash then -- mp male
            SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
        end
    cuffed = not cuffed

    changed = true
end)

RegisterNetEvent('irp-rope:cuffcheck')
AddEventHandler('irp-rope:cuffcheck', function()
    local player, distance = irpCore.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        TaskPlayAnim(ped,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0, 130)
        TriggerEvent('DoLongHudText', 'You have used your rope', 1)
		Wait(8000)
		TriggerServerEvent('irp-policejob:rope', GetPlayerServerId(player))
        TriggerEvent('DoLongHudText', 'Person dragged/UnDragged', 1)
    else
        TriggerEvent('DoLongHudText', 'No players nearby', 2)
	end
end)

RegisterNetEvent('irp-rope:ropecheck')
AddEventHandler('irp-rope:ropecheck', function()
    local player, distance = irpCore.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
		TaskPlayAnim(ped,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0, 130)
        TriggerEvent('DoLongHudText', 'You have used your rope', 1)
		Wait(8000)
		TriggerServerEvent('irp-policejob:drag', GetPlayerServerId(player))
        TriggerEvent('DoLongHudText', 'Person Dragged/Undragged', 1)
    else
        TriggerEvent('DoLongHudText', 'No players nearby', 2)
    end
end)

RegisterNetEvent('irp-rope:nyckelcheck')
AddEventHandler('irp-rope:nyckelcheck', function()
	local player, distance = irpCore.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
        TriggerServerEvent('irp-rope:unlocking', GetPlayerServerId(player))
    else
        TriggerEvent('DoLongHudText', 'No players nearby', 2)
	end
end)

RegisterNetEvent('irp-rope:unlockingcuffs')
AddEventHandler('irp-rope:unlockingcuffs', function()
    local player, distance = irpCore.Game.GetClosestPlayer()
	local ped = GetPlayerPed(-1)

	if IsLockpicking == false then
		irpCore.UI.Menu.CloseAll()
		FreezeEntityPosition(player,  true)
		FreezeEntityPosition(ped,  true)

		TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", 0, true)

		IsLockpicking = true

		Wait(30000)

		IsLockpicking = false

		FreezeEntityPosition(player,  false)
		FreezeEntityPosition(ped,  false)

		ClearPedTasksImmediately(ped)

		TriggerServerEvent('irp-policejob:rope', GetPlayerServerId(player))
		TriggerEvent('DoLongHudText', 'rope unlocked', 1)
	else
		TriggerEvent('DoLongHudText', 'Your are already lockpicking rope', 2)
	end
end)

-- ??
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not changed then
            ped = PlayerPedId()
            local IsCuffed = IsPedCuffed(ped)
            if IsCuffed and not IsEntityPlayingAnim(PlayerPedId(), dict, anim, 3) then
                Citizen.Wait(0)
                TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
            end
        else
            changed = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        ped = PlayerPedId()
        if cuffed then
        end
    end
end)
