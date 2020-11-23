irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

RegisterServerEvent('CrashTackle')
AddEventHandler('CrashTackle', function(target)
	TriggerClientEvent("playerTackled", target)
end)

--Citizen Card

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end

irpCore.RegisterUsableItem('citizencard', function(source)
	local src = source
	local xPlayer = irpCore.GetPlayerFromId(src)
	local sex
	local name = getIdentity(src)
	if name.sex == 'f' then
		sex = 'Female'
	elseif name.sex == 'm' then
		sex = 'Male'
	end		
    TriggerClientEvent('Do3DText', -1, 'Name: ' .. name.firstname .. ' ' .. name.lastname .. ' | Date of Birth: ' .. name.dateofbirth .. ' | Sex: ' .. sex .. ' | Height: ' .. name.height .. ' cm', source)
end)

--TPM

irpCore.RegisterServerCallback("tpm:fetchUserRank", function(source, cb)
    local player = irpCore.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

--- SUPTIME ---

Citizen.CreateThread(function()
	local starttick = GetGameTimer()
	while true do
		Citizen.Wait(15000) -- check all 15 seconds
		local tick = GetGameTimer()
		local uptimeDay = math.floor((tick-starttick)/86400000)
        local uptimeHour = math.floor((tick-starttick)/3600000) % 24
		local uptimeMinute = math.floor((tick-starttick)/60000) % 60
		local uptimeSecond = math.floor((tick-starttick)/1000) % 60
		ExecuteCommand(string.format("sets Uptime \"%2d Days %2d Hours %2d Minutes %2d Seconds\"", uptimeDay, uptimeHour, uptimeMinute, uptimeSecond))
	end
end)

--Alcohol

irpCore.RegisterUsableItem('vodka', function(source)
	local source = source
	TriggerClientEvent('alcohol:anim', source, "vodka")
	TriggerClientEvent('irp-status:add', source, 'thirst', 100000)
    TriggerClientEvent("fx:run", source, "alcohol", 180, 1.0)
end)

irpCore.RegisterUsableItem('whiskey', function(source)
	local source = source
	TriggerClientEvent('alcohol:anim', source, "whiskey")
	TriggerClientEvent('irp-status:add', source, 'thirst', 100000)
    TriggerClientEvent("fx:run", source, "alcohol", 180, 1.0)
end)

irpCore.RegisterUsableItem('beer', function(source)
	local source = source
	TriggerClientEvent('alcohol:anim', source, "beer")
	TriggerClientEvent('irp-status:add', source, 'thirst', 100000)
    TriggerClientEvent("fx:run", source, "alcohol", 180, 0.2)
end)

irpCore.RegisterUsableItem('whiteclaw', function(source)
	local source = source
	TriggerClientEvent('alcohol:anim', source, "whiteclaw")
	TriggerClientEvent('irp-status:add', source, 'thirst', 100000)
    TriggerClientEvent("fx:run", source, "alcohol", 180, 0.1)
end)
