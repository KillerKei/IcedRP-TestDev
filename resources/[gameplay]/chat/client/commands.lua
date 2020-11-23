-- StarBlazt Chat

irpCore = nil
local PlayerData              = {}
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


RegisterCommand('911', function(source, args, rawCommand)
    local source = GetPlayerServerId(PlayerId())
    local name = GetPlayerName(PlayerId())
    local caller = GetPlayerServerId(PlayerId())
    local msg = rawCommand:sub(4)
    TriggerEvent('phone:call1', source)
    TriggerServerEvent('chat:server:911source', source, caller, msg)
    TriggerServerEvent('911', source, caller, msg)
end, false)

RegisterCommand('311', function(source, args, rawCommand)
    local source = GetPlayerServerId(PlayerId())
    local name = GetPlayerName(PlayerId())
    local caller = GetPlayerServerId(PlayerId())
    local msg = rawCommand:sub(4)
    TriggerEvent('phone:call1', source)
    TriggerServerEvent(('chat:server:311source'), source, caller, msg)
    TriggerServerEvent('311', source, caller, msg)
end, false)


RegisterNetEvent('chat:EmergencySend911r')
AddEventHandler('chat:EmergencySend911r', function(fal, caller, msg)
    if irpCore.GetPlayerData().job.name == 'police' or irpCore.GetPlayerData().job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message emergency">911 RESPONSE: Sent to: {0}: {2} </div>',
        args = {caller, fal, msg}
        });
    end
end)

RegisterNetEvent('chat:EmergencySend311r')
AddEventHandler('chat:EmergencySend311r', function(fal, caller, msg)
    if irpCore.GetPlayerData().job.name == 'police' or irpCore.GetPlayerData().job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message nonemergency">311 RESPONSE: Sent to: {0}: {2} </div>',
        args = {caller, fal, msg}
        });
    end
end)

RegisterNetEvent('chat:EmergencySend911')
AddEventHandler('chat:EmergencySend911', function(fal, caller, msg)
    if irpCore.GetPlayerData().job.name == 'police' or irpCore.GetPlayerData().job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message emergency">[911] ( Caller ID: {0} | {1} ) {2} </div>',
        args = {caller, fal, msg}
        });
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
    end
end)

RegisterNetEvent('chat:EmergencySend311')
AddEventHandler('chat:EmergencySend311', function(fal, caller, msg)
    if irpCore.GetPlayerData().job.name == 'police' or irpCore.GetPlayerData().job.name == 'ambulance' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message nonemergency">[311] ( Caller ID: {0} | {1} ) {2} </div>',
        args = {caller, fal, msg}
        });
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
    end
end)

RegisterCommand('911r', function(target, args, rawCommand)
    if irpCore.GetPlayerData().job.name == 'police' or irpCore.GetPlayerData().job.name == 'ambulance' then
        local source = GetPlayerServerId(PlayerId())
        local target = tonumber(args[1])
        local msg = rawCommand:sub(8)
        TriggerServerEvent(('chat:server:911r'), target, source, msg)
        TriggerServerEvent('911r', target, source, msg)
    end
end, false)

RegisterCommand('311r', function(target, args, rawCommand)
    if irpCore.GetPlayerData().job.name == 'police' or irpCore.GetPlayerData().job.name == 'ambulance' then 
        local source = GetPlayerServerId(PlayerId())
        local target = tonumber(args[1])
        local msg = rawCommand:sub(8)
        TriggerServerEvent(('chat:server:311r'), target, source, msg)
        TriggerServerEvent('311r', target, source, msg)
    end
end, false)



RegisterNetEvent('phone:call1')
AddEventHandler('phone:call1', function()
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		while not HasAnimDictLoaded('cellphone@') do
			RequestAnimDict('cellphone@')
			Citizen.Wait(10)
		end
		ClearPedTasksImmediately(GetPlayerPed(-1))
		TaskPlayAnim(GetPlayerPed(-1), 'cellphone@', 'cellphone_call_listen_base', 8.0, 1.0, 3000, 49, 1.0, 0, 0, 0)
	end
end)