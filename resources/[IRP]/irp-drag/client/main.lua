irpCore = nil
dragStatus = {}
dragStatus.isDragged = false
isInVehicle = false
InVehicle = nil
local vehicle

Citizen.CreateThread(function()
    while irpCore == nil do
        TriggerEvent('irp:getSharedObject', function(obj)
            irpCore = obj
        end)
        Citizen.Wait(0)
    end

    while irpCore.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    irpCore.PlayerData = irpCore.GetPlayerData()
end)

RegisterNetEvent('irp:setJob')
AddEventHandler('irp:setJob', function(job)
    irpCore.PlayerData.job = job
end)

function CanDoJob()
    for k, v in pairs(Config.Jobs.AllowedJobs) do
        if v == irpCore.PlayerData.job.name then
            return true
        end
    end
    return false
end

function DragMe()

    if Config.Jobs.LimitJobs and not CanDoJob() then
        return
    end

    local closestPlayer, closestDistance = irpCore.Game.GetClosestPlayer()
    local targetPed = GetPlayerPed(closestPlayer)
    local isInCar = IsPedSittingInAnyVehicle(PlayerPedId())
    if closestPlayer ~= -1 and closestDistance <= 3.0 and not isInCar and CanDoWhileDead(targetPed) then
        TriggerServerEvent('dragme:drag', GetPlayerServerId(closestPlayer))
    end
end

RegisterNetEvent('civDrag')
AddEventHandler('civDrag', function()
    local closestPlayer, closestDistance = irpCore.Game.GetClosestPlayer()
    local targetPed = GetPlayerPed(closestPlayer)
    local isInCar = IsPedSittingInAnyVehicle(PlayerPedId())
    if closestPlayer ~= -1 and closestDistance <= 3.0 and not isInCar and CanDoWhileDead(targetPed) then
        TriggerServerEvent('dragme:drag', GetPlayerServerId(closestPlayer))
	else
        TriggerEvent('DoLongHudText', 'There is no player(s) nearby!', 2)
	end
end)

function CanDoWhileDead(targetPed)
    if Config.OnlyWhileDead then
        return IsPedDeadOrDying(targetPed)
    else
        return true
    end
end

RegisterCommand("drag", function(src, args, raw)
    if Config.EnableCommands then
        DragMe()
    end
end)

RegisterNetEvent('dragme:drag')
AddEventHandler('dragme:drag', function(draggerId)
    dragStatus.isDragged = not dragStatus.isDragged
    dragStatus.draggerId = draggerId
    isInVehicle = false
    vehicle = nil
end)

RegisterNetEvent('dragme:detach')
AddEventHandler('dragme:detach', function()
    dragStatus.isDragged = false
    isInVehicle = false
    vehicle = nil
end)

Citizen.CreateThread(function()
    local playerPed
    local targetPed

    while true do
        Citizen.Wait(0)

        if true then
            playerPed = PlayerPedId()

            if not CanDoWhileDead(playerPed) then
                isInVehicle = false
            end

            if dragStatus.isDragged then
                targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.draggerId))

                -- undrag if target is in an vehicle
                if not IsPedSittingInAnyVehicle(targetPed) and not IsPedSittingInAnyVehicle(playerPed) and CanDoWhileDead(playerPed) and not isInVehicle then
                    AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                else
                    dragStatus.isDragged = false
                    DetachEntity(playerPed, true, false)
                end

                if IsPedDeadOrDying(targetPed, true) then
                    dragStatus.isDragged = false
                    DetachEntity(playerPed, true, false)
                end
            elseif isInVehicle then
                DisableAllControlActions(0)
                EnableControlAction(0, 1)
                EnableControlAction(0, 2)
                AttachEntityToEntity(playerPed, InVehicle, -1, 0.0, 0.0, 0.4, 0.0, 0.0, 0.0, false, false, true, true, 2, true)
            elseif not exports['irp-trunk']:isInTrunk() and not isInVehicle then
                isInVehicle = false
                DetachEntity(playerPed, true, false)
            end
        else
            Citizen.Wait(500)
        end
    end
end)