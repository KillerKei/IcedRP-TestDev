local irpCore = nil

local CoolDownTimerCargo = {}

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

RegisterServerEvent("irp_cargorobbery:success")
AddEventHandler("irp_cargorobbery:success",function(timer)
	local xPlayer = irpCore.GetPlayerFromId(source)
	local reward = math.random(500,1000)
	if timer >= 600 then
		xPlayer.addMoney(reward)
		TriggerClientEvent("DoLongHudText","You received $" ..reward.. "cash",2)
		Citizen.Wait(1800000)
		local timer = 0
	end
end)

RegisterServerEvent("irp_atmRobbery:CooldownATM")
AddEventHandler("irp_atmRobbery:CooldownATM",function()
	local xPlayer = irpCore.GetPlayerFromId(source)
	table.insert(CoolDownTimerCargo,{CoolDownTimerCargo = GetPlayerIdentifier(source), time = ((Config.RobCooldown * 60000))})
end)

-- Cooldown timer thread:
Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
	Citizen.Wait(1000)
		for k,v in pairs(CoolDownTimerCargo) do
			if v.time <= 0 then
				RemoveCooldownTimer(v.CoolDownTimerCargo)
			else
				v.time = v.time - 1000
			end
		end
	end
end)

function RemoveCooldownTimer(source)
	for k,v in pairs(CoolDownTimerCargo) do
		if v.CoolDownTimerCargo == source then
			table.remove(CoolDownTimerCargo,k)
		end
	end
end
function GetTimeForCooldown(source)
	for k,v in pairs(CoolDownTimerCargo) do
		if v.CoolDownTimerCargo == source then
			return math.ceil(v.time/60000)
		end
	end
end
function CheckCooldownTime(source)
	for k,v in pairs(CoolDownTimerCargo) do
		if v.CoolDownTimerCargo == source then
			return true
		end
	end
	return false
end