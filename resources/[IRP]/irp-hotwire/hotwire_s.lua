local vehicleKeys = {}
local myVehicleKeys = {}

irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj)
  irpCore = obj
end)

local robbableItems = {
 [1] = {chance = 3, id = 0, name = 'Cash', quantity = math.random(25, 100)}, -- really common
 [2] = {chance = 6, id = 1, name = 'Keys', isWeapon = false}, -- rare
 [3] = {chance = 3, id = 'chips', name = 'Chips', quantity = 1}, -- really common
 [4] = {chance = 5, id = 'vicodin', name = 'Vicodin', quantity = 1}, -- rare
 [5] = {chance = 8, id = 'WEAPON_KNIFE', name = 'Knife', quantity = 1}, -- super rare
 [6] = {chance = 7, id = 'binoculars', name = 'Binoculars', quantity = 1}, -- rare
 [7] = {chance = 8, id = 'highgrademaleseed', name = 'Male seed', quantity = math.random(1,2)}, -- rare
 [9] = {chance = 10, id = 'highgradefemaleseed', name = 'Female seed', quantity = math.random(1,2)}, -- rare
 [10] = {chance = 6, id = 'scrapmetal', name = 'Scrap Metal', quantity = math.random(1,5)},
 [11] = {chance = 4, id = 'rubber', name = 'Rubber', quantity = math.random(1,7)},
 [12] = {chance = 5, id = 'steel', name = 'Steel', quantity = math.random(1,5)},
 [13] = {chance = 8, id = 'drugbags', name = 'Baggies', quantity = math.random(1, 6)},
 [14] = {chance = 7, id = 'joint2g', name = '2g Joint', quantity = math.random(1, 3)},
 --[15] = {chance = 6, id = 'rolex', name = 'Rolex', quantity = math.random(1, 5)},
 [16] = {chance = 8, id = 'drugbags', name = 'Baggies', quantity = math.random(1, 6)},
}

RegisterServerEvent('garage:searchItem')
AddEventHandler('garage:searchItem', function(plate)
  local source = tonumber(source)
  local item = {}
  local xPlayer = irpCore.GetPlayerFromId(source)
  local ident = xPlayer.getIdentifier()

  item = robbableItems[math.random(1, #robbableItems)]
  if math.random(1, 10) >= item.chance then
   if tonumber(item.id) == 0 then
    xPlayer.addMoney(item.quantity)
    TriggerClientEvent('DoLongHudText', source, 'You found $'..item.quantity, 1)
   elseif tonumber(item.id) == 1 then
    TriggerClientEvent('DoLongHudText', source, 'You have found the keys to the vehicle!', 1)
    vehicleKeys[plate] = {}
    table.insert(vehicleKeys[plate], {id = ident})
    TriggerClientEvent('garage:updateKeys', source, vehicleKeys, ident)
    TriggerClientEvent('vehicle:start', source)
   else
    xPlayer.addInventoryItem(item.id, item.quantity)
    TriggerClientEvent('DoLongHudText', source, 'Item Added!', 1)
   end
  else
    TriggerClientEvent('DoLongHudText', source, 'You found nothing', 1)
  end
end)


irpCore.RegisterServerCallback('disc-hotwire:checkOwner', function(source, cb, plate)
  local player = irpCore.GetPlayerFromId(source)
  MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
      ['@identifier'] = player.identifier,
      ['@plate'] = plate
  }, function(results)
      cb(#results == 1)
  end)
end)

RegisterServerEvent('garage:giveKey')
AddEventHandler('garage:giveKey', function(target, plate)
  local targetSource = tonumber(target)
  local xPlayer = irpCore.GetPlayerFromId(targetSource)
  local ident = xPlayer.getIdentifier()
  local xPlayer2 = irpCore.GetPlayerFromId(source)
  local ident2 = xPlayer2.getIdentifier()
  local plate = tostring(plate)

  vehicleKeys[plate] = {}
  table.insert(vehicleKeys[plate], {id = ident})
  TriggerClientEvent('DoLongHudText', targetSource, 'You just recieved keys to a vehicle', 1)
  TriggerClientEvent('garage:updateKeys', targetSource, vehicleKeys, ident)
  --re-enable to only have one set of keys
  --TriggerClientEvent('garage:updateKeys', source, vehicleKeys, ident2)
end)

RegisterServerEvent('garage:addKeys')
AddEventHandler('garage:addKeys', function(plate)
  local source = tonumber(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  local ident = xPlayer.getIdentifier()
  while plate == nil do
    Citizen.Wait(5)
  end

  if vehicleKeys[plate] ~= nil then
    table.insert(vehicleKeys[plate], {id = ident})
    TriggerClientEvent('garage:updateKeys', source, vehicleKeys, ident)
  else
    vehicleKeys[plate] = {}
    table.insert(vehicleKeys[plate], {id = ident})
    TriggerClientEvent('garage:updateKeys', source, vehicleKeys, ident)
  end
end)


RegisterServerEvent('garage:removeKeys')
AddEventHandler('garage:removeKeys', function(plate)
 local source = tonumber(source)
 local xPlayer = irpCore.GetPlayerFromId(source)
 local ident = xPlayer.getIdentifier()
 if vehicleKeys[plate] ~= nil then
  for id,v in pairs(vehicleKeys[plate]) do
   if v.id == ident then
    table.remove(vehicleKeys[plate], id)
   end
  end
 end
 TriggerClientEvent('garage:updateKeys', source, vehicleKeys, ident)
end)

RegisterServerEvent('removelockpick')
AddEventHandler('removelockpick', function()
  local source = tonumber(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  if math.random(1, 20) == 1 then
    xPlayer.removeInventoryItem("lockpick", 1)
    TriggerClientEvent('DoLongHudText', source, 'The lockpick bent out of shape.', 1)
  end
end)
