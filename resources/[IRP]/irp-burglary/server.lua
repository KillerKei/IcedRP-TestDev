local irpCore = nil
local robbableItems = {
 [1] = {chance = 3, id = 0, name = 'Cash', quantity = math.random(50, 800)}, -- really common
 [2] = {chance = 4, id = 'plastic', name = 'Plastic', quantity = math.random(1, 5)}, -- rare
 [3] = {chance = 3, id = 'joint2g', name = '2g Joint', quantity = math.random(1, 3)}, -- really common
 [4] = {chance = 5, id = 'coke1g', name = 'Crack Cocaine', quantity = 1}, -- rare
 [5] = {chance = 10, id = 'bankidcard', name = 'Bank ID Card', quantity = 1}, -- rare
 [6] = {chance = 14, id = 'keycard', name = 'Keycard', quantity = 1}, -- rare
 [7] = {chance = 13, id = 'keycard2', name = 'Keycard', quantity = 1}, -- rare
 [8] = {chance = 11, id = 'keycard3', name = 'Keycard', quantity = 1}, -- rare
 [10] = {chance = 10, id = 'thermite', name = 'Thermite', quantity = 1},
 [11] = {chance = 8, id = 'highgradefemaleseed', name = 'Female Seed', quantity = math.random(1, 3)},
 [12] = {chance = 10, id = 'drugItem', name = 'Black USB-C', quantity = 1}, -- rare
 [13] = {chance = 8, id = 'drugbags', name = 'Baggies', quantity = math.random(1, 6)},
 [14] = {chance = 7, id = 'highgrademaleseed', name = 'Male Seed', quantity = math.random(1, 4)},
 --[15] = {chance = 6, id = 'rolex', name = 'Rolex', quantity = math.random(1, 5)},
 [16] = {chance = 4, id = 'acid', name = 'Acid Tablets', quantity = math.random(1, 2)},
 [17] = {chance = 4, id = 'rubber', name = 'Rubber', quantity = math.random(1, 5)},
}

--[[chance = 1 is very common, the higher the value the less the chance]]--

TriggerEvent('irp:getSharedObject', function(obj)
 irpCore = obj
end)

irpCore.RegisterUsableItem('advancedlockpick', function(source) --Hammer high time to unlock but 100% call cops
 local source = tonumber(source)
 local xPlayer = irpCore.GetPlayerFromId(source)
 TriggerClientEvent('houseRobberies:attempt', source, xPlayer.getInventoryItem('advancedlockpick').count)
end)

irpCore.RegisterUsableItem('lockpick', function(source)
	TriggerClientEvent('lockpick:vehicleUse', source)
end)

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
 local source = tonumber(source)
 local xPlayer = irpCore.GetPlayerFromId(source)
 xPlayer.removeInventoryItem('advancedlockpick', 1)
 TriggerClientEvent('DoLongHudText',  source, 'The lockpick bent out of shape' , 1)
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
 local source = tonumber(source)
 local xPlayer = irpCore.GetPlayerFromId(source)
 local cash = math.random(200, 500)
 xPlayer.addMoney(cash)
 TriggerClientEvent('DoLongHudText',  source, 'You found $'..cash , 1)
end)


RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
 local source = tonumber(source)
 local item = {}
 local xPlayer = irpCore.GetPlayerFromId(source)
 local gotID = {}

 for i=1, math.random(1, 2) do
  item = robbableItems[math.random(1, #robbableItems)]
  if math.random(1, 15) >= item.chance then
    if tonumber(item.id) == 0 and not gotID[item.id] then
        gotID[item.id] = true
        xPlayer.addMoney(item.quantity)
        TriggerClientEvent('DoLongHudText',  source, 'You found $'..item.quantity , 1)
    elseif item.isWeapon and not gotID[item.id] then
        gotID[item.id] = true
        xPlayer.addWeapon(item.id, 50)
        TriggerClientEvent('DoLongHudText', source, 'Item Added!', 1)
    elseif not gotID[item.id] then
        gotID[item.id] = true
        xPlayer.addInventoryItem(item.id, item.quantity)
        TriggerClientEvent('DoLongHudText', source, 'Item Added!', 1)
    end
  else
    TriggerClientEvent('DoLongHudText', source, 'You found nothing', 1)
  end
end
end)
