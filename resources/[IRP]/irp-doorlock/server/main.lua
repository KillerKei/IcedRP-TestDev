irpCore				= nil
local DoorInfo	= {}

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

RegisterServerEvent('irp-doorlock:updateState')
AddEventHandler('irp-doorlock:updateState', function(doorID, state)
	local xPlayer = irpCore.GetPlayerFromId(source)

	if type(doorID) ~= 'number' then
		return
	end

	

	-- make each door a table, and clean it when toggled
	DoorInfo[doorID] = {}

	-- assign information
	DoorInfo[doorID].state = state
	DoorInfo[doorID].doorID = doorID

	TriggerClientEvent('irp-doorlock:setState', -1, doorID, state)
end)

irpCore.RegisterUsableItem('keycard3', function(source)
	TriggerClientEvent('irp-doorlock:UseRedKeycard',source)
	local xPlayer = irpCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('keycard3', 1)
end)

RegisterServerEvent("irp-doorlock:jailbreak")
AddEventHandler("irp-doorlock:jailbreak", function()
    local _source = source
    local xPlayer = irpCore.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem("thermite")["count"]
	
     if item >= 1 then
		xPlayer.removeInventoryItem("thermite", 1)
		TriggerClientEvent('irp-doorlock:UseRedKeycard2',source)
    end
end)

RegisterServerEvent("irp-doorlock:jailbreak2")
AddEventHandler("irp-doorlock:jailbreak2", function()
    local _source = source
    local xPlayer = irpCore.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem("thermite")["count"]
	
     if item >= 1 then
		xPlayer.removeInventoryItem("thermite", 1)
		TriggerClientEvent('irp-doorlock:UseRedKeycard3',source)
    end
end)

RegisterServerEvent("irp-doorlock:jailbreak3")
AddEventHandler("irp-doorlock:jailbreak3", function()
    local _source = source
    local xPlayer = irpCore.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem("thermite")["count"]
	
     if item >= 1 then
		xPlayer.removeInventoryItem("thermite", 1)
		TriggerClientEvent('irp-doorlock:UseRedKeycard4',source)
    end
end)

RegisterServerEvent("irp-doorlock:jewrob")
AddEventHandler("irp-doorlock:jewrob", function()
    local _source = source
    local xPlayer = irpCore.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem("gruppe63")["count"]
	
     if item >= 1 then
		xPlayer.removeInventoryItem("gruppe63", 1)
		TriggerClientEvent('irp-doorlock:jewrobbery', _source)
	 else
		TriggerClientEvent('DoLongHudText', _source, 'You do not have a Purple G6 Card!', 2)
    end
end)



irpCore.RegisterServerCallback('irp-doorlock:getDoorInfo', function(source, cb)
	cb(DoorInfo, #DoorInfo)
end)

function IsAuthorized(jobName, doorID)
	for i=1, #doorID.authorizedJobs, 1 do
		if doorID.authorizedJobs[i] == jobName then
			return true
		end
	end

	return false
end