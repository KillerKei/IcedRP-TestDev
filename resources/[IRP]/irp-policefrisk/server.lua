irpCore = nil

TriggerEvent("irp:getSharedObject", function(obj) irpCore = obj end)

RegisterServerEvent("irp-policefrisk:closestPlayer")
AddEventHandler("irp-policefrisk:closestPlayer", function(closestPlayer)
    _source = source
    target = closestPlayer

    TriggerClientEvent("irp-policefrisk:friskPlayer", target)
end)

RegisterServerEvent("irp-policefrisk:notifyMessage")
AddEventHandler("irp-policefrisk:notifyMessage", function(frisk)
    if frisk == true then
        TriggerClientEvent('chat:addMessage', _source, { 
            template = '<div class="chat-message jail"><div class="<div class="chat-message jail"><b> {0}</b> {1}</div>',
            args = { "Information: ",  "I could feel something that reminds of a firearm"},  
        })
        return
    elseif frisk == false then
        TriggerClientEvent('chat:addMessage', _source, { 
            template = '<div class="chat-message jail"><div class="<div class="chat-message jail"><b> {0}</b> {1}</div>',
            args = { "Information: ",  "I could not feel anything"},  
        })
        return
    end
end)