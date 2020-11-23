irpCore = nil
TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

RegisterServerEvent("irp-fleeca:startcheck")
AddEventHandler("irp-fleeca:startcheck", function(bank)
    local _source = source
    local copcount = 0
    local Players = irpCore.GetPlayers()

    for i = 1, #Players, 1 do
        local xPlayer = irpCore.GetPlayerFromId(Players[i])

        if xPlayer.job.name == "police" then
            copcount = copcount + 1
        end
    end
    local xPlayer = irpCore.GetPlayerFromId(_source)
    local item = xPlayer.getInventoryItem("thermite")["count"]

    if copcount >= fleeca.mincops then
        if item >= 1 then
            if not fleeca.Banks[bank].onaction == true then
                if (os.time() - fleeca.cooldown) > fleeca.Banks[bank].lastrobbed then
                    fleeca.Banks[bank].onaction = true
                    xPlayer.removeInventoryItem("thermite", 1)
                    TriggerClientEvent("irp-fleeca:outcome", _source, true, bank)
                    TriggerClientEvent("irp-fleeca:policenotify", -1, bank)
                    TriggerClientEvent('irp-dispatch:bankrobbery', -1)
                    return
                else
                    TriggerClientEvent("irp-fleeca:outcome", _source, false, "This bank recently robbed. You need to wait "..math.floor((fleeca.cooldown - (os.time() - fleeca.Banks[bank].lastrobbed)) / 60)..":"..math.fmod((fleeca.cooldown - (os.time() - fleeca.Banks[bank].lastrobbed)), 60))
                end
            else
                TriggerClientEvent("irp-fleeca:outcome", _source, false, "This bank is currently being robbed.")
            end
        end
    else
        TriggerClientEvent("irp-fleeca:outcome", _source, false, "There is not enough police in the city.")
    end
end)

RegisterServerEvent("irp-fleeca:lootup")
AddEventHandler("irp-fleeca:lootup", function(var, var2)
    TriggerClientEvent("irp-fleeca:lootup_c", -1, var, var2)
end)

RegisterServerEvent("irp-fleeca:openDoor")
AddEventHandler("irp-fleeca:openDoor", function(coords, method)
    TriggerClientEvent("irp-fleeca:openDoor_c", -1, coords, method)
end)

RegisterServerEvent("irp-fleeca:startLoot")
AddEventHandler("irp-fleeca:startLoot", function(data, name, players)
    local _source = source

    for i = 1, #players, 1 do
        TriggerClientEvent("irp-fleeca:startLoot_c", players[i], data, name)
    end
    TriggerClientEvent("irp-fleeca:startLoot_c", _source, data, name)
end)

RegisterServerEvent("irp-fleeca:stopHeist")
AddEventHandler("irp-fleeca:stopHeist", function(name)
    TriggerClientEvent("irp-fleeca:stopHeist_c", -1, name)
end)

RegisterServerEvent("irp-fleeca:rewardCash")
AddEventHandler("irp-fleeca:rewardCash", function()
    local xPlayer = irpCore.GetPlayerFromId(source)
    local reward = math.random(fleeca.mincash, fleeca.maxcash)
    local mathfunc = math.random(200)
    if mathfunc == 15 then
      xPlayer.addInventoryItem('aluminumoxide', 1)
    end
    local matherino = math.random(300)
    if matherino == 15 then
      xPlayer.addInventoryItem('livitherium', 1)
    end
    xPlayer.addMoney(reward)
end)

RegisterServerEvent("irp-fleeca:setCooldown")
AddEventHandler("irp-fleeca:setCooldown", function(name)
    fleeca.Banks[name].lastrobbed = os.time()
    fleeca.Banks[name].onaction = false
    TriggerClientEvent("irp-fleeca:resetDoorState", -1, name)
end)

irpCore.RegisterServerCallback("irp-fleeca:getBanks", function(source, cb)
    cb(fleeca.Banks)
end)

irpCore.RegisterServerCallback("irp-fleeca:checkSecond", function(source, cb)
    local xPlayer = irpCore.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem("bankidcard")["count"]

    if item >= 1 then
        xPlayer.removeInventoryItem("bankidcard", 1)
        cb(true)
    else
        cb(false)
    end
end)