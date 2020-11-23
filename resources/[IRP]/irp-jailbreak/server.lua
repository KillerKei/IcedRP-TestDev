irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj)
 irpCore = obj
end)

RegisterServerEvent('irp-jailbreak:GiveSpoon')
AddEventHandler('irp-jailbreak:GiveSpoon', function()
    local xPlayer = irpCore.GetPlayerFromId(source)
    xPlayer.addInventoryItem('spoon', 1)
end)

irpCore.RegisterServerCallback('irp-jailbreak:CheckItem', function(source, cb)
    local xPlayer = irpCore.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('spoon').count <= 0 then
        cb(false)
    else
        cb(true)
        xPlayer.removeInventoryItem('spoon', 1)
    end
end)

irpCore.RegisterServerCallback('irp-jailbreak:CheckItem2', function(source, cb)
    local xPlayer = irpCore.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('keycard').count <= 0 and xPlayer.getInventoryItem('keycard2').count <= 0 then
        cb(false)
    else
        cb(true)
        xPlayer.removeInventoryItem('keycard', 1)
        xPlayer.removeInventoryItem('keycard2', 1)
    end
end)

local rewards = {
    [1] = {chance = 3, id = 0, name = 'Cash', quantity = math.random(20, 50)}, -- really common
    [2] = {chance = 10, id = 'keycard', name = 'Green Key Card', quantity = 1}, -- really common
    [3] = {chance = 10, id = 'keycard2', name = 'Blue Key Card', quantity = 1}, -- rare
    [4] = {chance = 10, id = 'WEAPON_SWITCHBLADE', name = 'Switchblade Knife', quantity = 1}, -- super rare
    [5] = {chance = 10, id = 'keycard3', name = 'Red Key Card', quantity = 1}, -- rare
}

RegisterServerEvent('irp-jailbreak:searchItem')
AddEventHandler('irp-jailbreak:searchItem', function()
 local source = tonumber(source)
 local item = {}
 local xPlayer = irpCore.GetPlayerFromId(source)
 local ident = xPlayer.getIdentifier()

  item = rewards[math.random(1, #rewards)]
  if math.random(1, 10) >= item.chance then
   if tonumber(item.id) == 0 then
    xPlayer.addMoney(item.quantity)
    TriggerClientEvent('DoLongHudText', source, 'You found $'..item.quantity, 1)
   else
    xPlayer.addInventoryItem(item.id, item.quantity)
    TriggerClientEvent('DoLongHudText', source, 'Item Added!', 1)
   end
  else
    TriggerClientEvent('DoLongHudText', source, 'You found nothing', 1)
  end
end)