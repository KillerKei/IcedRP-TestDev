irpCore                = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)


irpCore.RegisterUsableItem('fixkit', function(source)
  local _source = source
  TriggerClientEvent('irp-mecanojob:onFixkit', _source)
end)

irpCore.RegisterUsableItem('fixkit2', function(source)
  local _source = source
  TriggerClientEvent('irp-mecanojob:onFixkit2', _source)
end)

RegisterCommand('hire', function(source, args, raw)
  local PlayerData = irpCore.GetPlayerFromId(source)
  if PlayerData.job.name == 'mecano' and PlayerData.job.grade_name == 'boss' then
    if tonumber(args[1]) then
		  local xPlayer = irpCore.GetPlayerFromId(args[1])

		  if xPlayer then
			  if irpCore.DoesJobExist('mecano', 0) then
			  	xPlayer.setJob('mecano', 0)
        end
      end
    end
  end
end)

RegisterCommand('promote', function(source, args, raw)
  local PlayerData = irpCore.GetPlayerFromId(source)
  if PlayerData.job.name == 'mecano' and PlayerData.job.grade_name == 'boss' then
    if tonumber(args[1]) and tonumber(args[2]) then
      local xPlayer = irpCore.GetPlayerFromId(args[1])

      if xPlayer then
        if irpCore.DoesJobExist('mecano', args[2]) then
          xPlayer.setJob('mecano', args[2])
        end
      end
    end
  end
end)

RegisterServerEvent('towtruck:giveCash')
AddEventHandler('towtruck:giveCash', function(cash)
  local source = source
  local xPlayer  = irpCore.GetPlayerFromId(source)
  xPlayer.addMoney(cash)
end)

RegisterServerEvent('irp-imp:mechCar')
AddEventHandler('irp-imp:mechCar', function(plate)
	local user = irpCore.GetPlayerFromId(source)
    local characterId = user.identifier
	garage = 'Impound Lot'
	state = 'Normal Impound'
	MySQL.Async.execute("UPDATE owned_vehicles SET garage = @garage, state = @state WHERE plate = @plate", {['garage'] = garage, ['state'] = state, ['plate'] = plate})
end)
