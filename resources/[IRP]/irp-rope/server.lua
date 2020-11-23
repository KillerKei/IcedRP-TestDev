irpCore               = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

----
irpCore.RegisterUsableItem('rope', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)

	TriggerClientEvent('irp-rope:ropecheck', source)
end)

----

RegisterServerEvent('irp-rope:unlocking')
AddEventHandler('irp-rope:unlocking', function(source)
  TriggerClientEvent('irp-rope:unlockingcuffs', source)
end)
---
