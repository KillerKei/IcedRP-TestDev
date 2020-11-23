local rob = false
local randomJackpot = math.random(1, 50)
local robbers = {}
irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('irp-holdupbank:toofar')
AddEventHandler('irp-holdupbank:toofar', function(robb)
	local source = source
	local xPlayers = irpCore.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = irpCore.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			TriggerClientEvent('irp:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Banks[robb].nameofbank)
			TriggerClientEvent('irp-holdupbank:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('irp-holdupbank:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('irp:showNotification', source, _U('robbery_has_cancelled') .. Banks[robb].nameofbank)
	end
end)

RegisterServerEvent('irp-holdupbank:toofarhack')
AddEventHandler('irp-holdupbank:toofarhack', function(robb)
	local source = source
	local xPlayers = irpCore.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = irpCore.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			TriggerClientEvent('irp:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Banks[robb].nameofbank)
			TriggerClientEvent('irp-holdupbank:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('irp-holdupbank:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('irp:showNotification', source, _U('robbery_has_cancelled') .. Banks[robb].nameofbank)
	end
end)

RegisterServerEvent('irp-holdupbank:rob')
AddEventHandler('irp-holdupbank:rob', function(robb)

	local source = source
	local xPlayer = irpCore.GetPlayerFromId(source)
	local xPlayers = irpCore.GetPlayers()
	
	if Banks[robb] then

		local bank = Banks[robb]

		if (os.time() - bank.lastrobbed) < 7200 and bank.lastrobbed ~= 0 then

			TriggerClientEvent('irp:showNotification', source, _U('already_robbed') .. (21600 - (os.time() - bank.lastrobbed)) .. _U('seconds'))
			return
		end


		local cops = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = irpCore.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end


		if rob == false then
		
			 if xPlayer.getInventoryItem('blowtorch').count >= 1 then
				xPlayer.removeInventoryItem('blowtorch', 1)

				if(cops >= Config.NumberOfCopsRequired)then

					rob = true
					for i=1, #xPlayers, 1 do
						local xPlayer = irpCore.GetPlayerFromId(xPlayers[i])
						if xPlayer.job.name == 'police' then
								TriggerClientEvent('irp:showNotification', xPlayers[i], _U('rob_in_prog') .. bank.nameofbank)							
								TriggerClientEvent('irp-holdupbank:setblip', xPlayers[i], Banks[robb].position)
						end
					end

					TriggerClientEvent('irp:showNotification', source, _U('started_to_rob') .. bank.nameofbank .. _U('do_not_move'))
					TriggerClientEvent('irp:showNotification', source, _U('alarm_triggered'))
					TriggerClientEvent('irp:showNotification', source, _U('hold_pos'))
					TriggerClientEvent('irp-holdupbank:currentlyrobbing', source, robb)
					TriggerClientEvent('irp-blowtorch:startblowtorch', source)
					Banks[robb].lastrobbed = os.time()
					robbers[source] = robb
					local savedSource = source
					SetTimeout(300000, function()

						if(robbers[savedSource])then

							rob = false
							TriggerClientEvent('irp-holdupbank:robberycomplete', savedSource, job)
							if(xPlayer)then
								
								xPlayer.addInventoryItem('livitherium', math.random(2, 4))

								xPlayer.addMoney(bank.reward)
								local xPlayers = irpCore.GetPlayers()
								for i=1, #xPlayers, 1 do
									local xPlayer = irpCore.GetPlayerFromId(xPlayers[i])
									if xPlayer.job.name == 'police' then
											TriggerClientEvent('irp:showNotification', xPlayers[i], _U('robbery_complete_at') .. bank.nameofbank)
											TriggerClientEvent('irp-holdupbank:killblip', xPlayers[i])
									end
								end
							end
						end
					end)
				else
			end
				TriggerClientEvent('irp:showNotification', source, _U('min_two_police')..Config.NumberOfCopsRequired)
			 else
				 TriggerClientEvent('irp:showNotification', source, _U('blowtorch_needed'))
			 end

		else
			TriggerClientEvent('irp:showNotification', source, _U('robbery_already'))
		end
	end
end)

RegisterServerEvent('irp-holdupbank:ChatAlert')
AddEventHandler('irp-holdupbank:ChatAlert', function()
	local xPlayers = irpCore.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = irpCore.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			local type = 'police'
			local data = {["code"] = '10-90', ["name"] = 'Robbery in Progress', ["loc"] = 'Bank: Principal Bank'}
			TriggerClientEvent('irp-outlawalert:outlawNotify', -1, type, data)
			return
		end
	end
end)

RegisterServerEvent('irp-holdupbank:hack')
AddEventHandler('irp-holdupbank:hack', function(robb)

	local source = source
	local xPlayer = irpCore.GetPlayerFromId(source)
	local xPlayers = irpCore.GetPlayers()
	
	if Banks[robb] then

		local bank = Banks[robb]

		if (os.time() - bank.lastrobbed) < 600 and bank.lastrobbed ~= 0 then

			TriggerClientEvent('irp:showNotification', source, _U('already_robbed') .. (1800 - (os.time() - bank.lastrobbed)) .. _U('seconds'))
			return
		end


		local cops = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = irpCore.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end



			if(cops >= Config.NumberOfCopsRequired)then

				if xPlayer.getInventoryItem('rasperry').count >= 1 then

					TriggerClientEvent('irp:showNotification', source, _U('started_to_hack') .. bank.nameofbank .. _U('do_not_move'))
					TriggerClientEvent('irp:showNotification', source, _U('hold_pos_hack'))
					TriggerClientEvent('irp-holdupbank:currentlyhacking', source, robb, Banks[robb])



				else
					TriggerClientEvent('irp:showNotification', source, _U('rasperry_needed'))
				end
			else
				TriggerClientEvent('irp:showNotification', source, _U('min_two_police'))
			end
	end
end)

RegisterServerEvent('irp-holdupbank:RemoveKit')
AddEventHandler('irp-holdupbank:RemoveKit', function()
	local xPlayer = irpCore.GetPlayerFromId(source)
	if xPlayer.getInventoryItem('rasperry').count >= 1 then
		xPlayer.removeInventoryItem('rasperry', 1)
	end
end)

-- Plant a bomb

RegisterServerEvent('irp-holdupbank:plantbomb')
AddEventHandler('irp-holdupbank:plantbomb', function(robb)

    local source = source
    local xPlayer = irpCore.GetPlayerFromId(source)
    local xPlayers = irpCore.GetPlayers()

    if Banks[robb] then

        local bank = Banks[robb]

        if (os.time() - bank.lastrobbed) < 600 and bank.lastrobbed ~= 0 then

            TriggerClientEvent('irp:showNotification', source, _U('already_robbed') .. (1800 - (os.time() - bank.lastrobbed)) .. _U('seconds'))
            return
        end


        local cops = 0
        for i=1, #xPlayers, 1 do
            local xPlayer = irpCore.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == 'police' then
                cops = cops + 1
            end
        end


        if(cops >= Config.NumberOfCopsRequired)then

			if xPlayer.getInventoryItem('c4_bank').count >= 1 then
				xPlayer.removeInventoryItem('c4_bank', 1)
				for i=1, #xPlayers, 1 do
				local xPlayer = irpCore.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'police' then
						TriggerClientEvent('irp:showNotification', xPlayers[i], _U('rob_in_prog') .. bank.nameofbank)
						--TriggerClientEvent('irp-holdupbank:setblip', xPlayers[i], Banks[robb].position)
					end
				end

				TriggerClientEvent('irp:showNotification', source, _U('started_to_plantbomb') .. bank.nameofbank .. _U('do_not_move'))

				TriggerClientEvent('irp:showNotification', source, _U('hold_pos_plantbomb'))
				TriggerClientEvent('irp-holdupbank:plantingbomb', source, robb, Banks[robb])

				robbers[source] = robb
				local savedSource = source

				SetTimeout(20000, function()

					if(robbers[savedSource])then

						rob = false
						TriggerClientEvent('irp-holdupbank:plantbombcomplete', savedSource, Banks[robb])
						if(xPlayer)then

							TriggerClientEvent('irp:showNotification', xPlayer, _U('bombplanted_run'))
							local xPlayers = irpCore.GetPlayers()
							for i=1, #xPlayers, 1 do
								local xPlayer = irpCore.GetPlayerFromId(xPlayers[i])
								if xPlayer.job.name == 'police' then
									TriggerClientEvent('irp:showNotification', xPlayers[i], _U('bombplanted_at') .. bank.nameofbank)

								end
							end
						end
					end
				end)
			else
				TriggerClientEvent('irp:showNotification', source, _U('c4_needed'))
			end
        else
            TriggerClientEvent('irp:showNotification', source, _U('min_two_police'))
        end

    end
end)

RegisterServerEvent('irp-holdupbank:clearweld')
AddEventHandler('irp-holdupbank:clearweld', function(x,y,z)

	TriggerClientEvent('irp-blowtorch:clearweld', -1, x,y,z)
end)

RegisterServerEvent('irp-holdupbank:opendoor')
AddEventHandler('irp-holdupbank:opendoor', function(x,y,z, doortype)

	TriggerClientEvent('irp-holdupbank:opendoors', -1, x,y,z, doortype)
end)

RegisterServerEvent('irp-holdupbank:plantbombtoall')
AddEventHandler('irp-holdupbank:plantbombtoall', function(x,y,z, doortype)
    SetTimeout(20000, function()
        TriggerClientEvent('irp-holdupbank:plantedbomb', -1, x,y,z, doortype)
    end)
end)

RegisterServerEvent('irp-holdupbank:finishclear')
AddEventHandler('irp-holdupbank:finishclear', function()
	TriggerClientEvent('irp-blowtorch:finishclear', -1)
end)

RegisterServerEvent('irp-holdupbank:closedoor')
AddEventHandler('irp-holdupbank:closedoor', function()

	TriggerClientEvent('irp-holdupbank:closedoor', -1)
end)

RegisterServerEvent('irp-holdupbank:plantbomb')
AddEventHandler('irp-holdupbank:plantbomb', function()
    TriggerClientEvent('irp-holdupbank:plantbomb', -1)
end)
