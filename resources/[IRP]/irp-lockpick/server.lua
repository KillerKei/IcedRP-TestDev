function lockpicking:GetLockpickCount(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = irpCore.GetPlayerFromId(source); end
  local item = xPlayer.getInventoryItem('lockpick')
  return item.count or 0
end

function lockpicking:MinigameComplete(source,didWin)
  if not didWin then
    local xPlayer = irpCore.GetPlayerFromId(source)
    while not xPlayer do Citizen.Wait(0); xPlayer = irpCore.GetPlayerFromId(source); end
    xPlayer.removeInventoryItem('lockpick',1)
    local xPlayers = irpCore.GetPlayers()
    for i=1, #xPlayers, 1 do
      local xPlayer = irpCore.GetPlayerFromId(xPlayers[i])
      if xPlayer.job.name == 'police' then
        local type = 'police'
        local data = {["code"] = '10-31B', ["name"] = 'Burglary in Progress', ["loc"] = 'Left ALT for Location'}
        TriggerClientEvent('irp-outlawalert:outlawNotify', -1, type, data)
        return
      end
    end
  end
end

RegisterNetEvent('lockpicking:MinigameComplete')
AddEventHandler('lockpicking:MinigameComplete', function(didWin) lockpicking:MinigameComplete(source,didWin); end)

irpCore.RegisterServerCallback('lockpicking:GetLockpickCount', function(source,cb) cb(lockpicking:GetLockpickCount(source)); end)