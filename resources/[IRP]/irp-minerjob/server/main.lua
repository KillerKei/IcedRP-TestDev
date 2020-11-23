 irpCore               = nil
TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

RegisterNetEvent("irp-minerjob:givestone")
AddEventHandler("irp-minerjob:givestone", function(item, count)
    local _source = source
    local xPlayer  = irpCore.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('stones').count < 100 then
                xPlayer.addInventoryItem('stones', 5)
                TriggerClientEvent('DoLongHudText', _source, 'You received 5 stone.', 1)
            end
        end
    end)

    
RegisterNetEvent("irp-minerjob:washing")
AddEventHandler("irp-minerjob:washing", function(item, count)
    local _source = source
    local xPlayer  = irpCore.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('stones').count > 9 then
                TriggerClientEvent("irp-minerjob:washing", source)
                xPlayer.addInventoryItem('washedstones', 10)
                Citizen.Wait(50)
                xPlayer.removeInventoryItem("stones", 10)
            elseif xPlayer.getInventoryItem('stones').count < 10 then
                TriggerClientEvent('DoLongHudText', _source, 'You do not have any stone.', 2)
            end
        end
    end)

RegisterNetEvent("irp-minerjob:remelting")
AddEventHandler("irp-minerjob:remelting", function(item, count)
    local _source = source
    local xPlayer  = irpCore.GetPlayerFromId(_source)
    local randomChance = math.random(1, 100)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('washedstones').count > 9 then
                TriggerClientEvent("irp-minerjob:remelting", source)
                Citizen.Wait(15900)
                if randomChance < 25 then
                    Citizen.Wait(50)
                    xPlayer.addInventoryItem("copper", 5)
                    Citizen.Wait(50)
                    xPlayer.removeInventoryItem("washedstones", 10)
                    TriggerClientEvent('DoLongHudText', _source, 'You got copper for washed stones.', 1)
                elseif randomChance < 30 then
                    Citizen.Wait(50)
                    xPlayer.addInventoryItem("gold", 5)
                    Citizen.Wait(50)
                    xPlayer.removeInventoryItem("washedstones", 10)
                    TriggerClientEvent('DoLongHudText', _source, 'You got gold for washed stones.', 1)
                elseif randomChance > 35 then
                    Citizen.Wait(50)
                    xPlayer.addInventoryItem("iron", 1)
                    Citizen.Wait(50)
                    xPlayer.removeInventoryItem("washedstones", 10)
                    TriggerClientEvent('DoLongHudText', _source, 'You got iron for washed stones.', 1)
                elseif randomChance > 50 then
                    Citizen.Wait(50)
                    xPlayer.addInventoryItem("silver", 20)
                    Citizen.Wait(50)
                    xPlayer.removeInventoryItem("washedstones", 10)
                    TriggerClientEvent('DoLongHudText', _source, 'You got silver for washed stones.', 1)
                end
            elseif xPlayer.getInventoryItem('stones').count < 10 then
                TriggerClientEvent('DoLongHudText', _source, 'You do not have stones.', 2)
            end
        end
    end)
    
    RegisterNetEvent("irp-minerjob:sellsilver")
    AddEventHandler("irp-minerjob:sellsilver", function(item, count)
        local _source = source
        local xPlayer  = irpCore.GetPlayerFromId(_source)
            if xPlayer ~= nil then
                if xPlayer.getInventoryItem('silver').count > 4 then
                    local pieniadze = Config.SilverPrice
                    xPlayer.removeInventoryItem('silver', 5)
                    xPlayer.addMoney(pieniadze)
                    TriggerClientEvent('DoLongHudText', _source, 'You selled 5 silver.', 1)
                elseif xPlayer.getInventoryItem('silver').count < 5 then
                    TriggerClientEvent('DoLongHudText', _source, 'You do not have silver. You need 5 you sell!', 2)
                end
            end
        end)
    
    RegisterNetEvent("irp-minerjob:selliron")
    AddEventHandler("irp-minerjob:selliron", function(item, count)
        local _source = source
        local xPlayer  = irpCore.GetPlayerFromId(_source)
            if xPlayer ~= nil then
                if xPlayer.getInventoryItem('iron').count > 4 then
                    local pieniadze = Config.IronPrice
                    xPlayer.removeInventoryItem('iron', 5)
                    xPlayer.addMoney(pieniadze)
                    TriggerClientEvent('DoLongHudText', _source, 'You selled 5 iron.', 1)
                elseif xPlayer.getInventoryItem('iron').count < 5 then
                    TriggerClientEvent('DoLongHudText', _source, 'You do not have iron. You need 5 you sell!', 2)
                end
            end
        end)

    RegisterNetEvent("irp-minerjob:sellcopper")
    AddEventHandler("irp-minerjob:sellcopper", function(item, count)
        local _source = source
        local xPlayer  = irpCore.GetPlayerFromId(_source)
            if xPlayer ~= nil then
                if xPlayer.getInventoryItem('copper').count > 4 then
                    local pieniadze = Config.CopperPrice
                    xPlayer.removeInventoryItem('copper', 5)
                    xPlayer.addMoney(pieniadze)
                    TriggerClientEvent('DoLongHudText', _source, 'You selled 5 copper.', 1)
                elseif xPlayer.getInventoryItem('copper').count < 5 then
                    TriggerClientEvent('DoLongHudText', _source, 'You do not have copper. You need 5 you sell!', 2)
                end
            end
        end)
