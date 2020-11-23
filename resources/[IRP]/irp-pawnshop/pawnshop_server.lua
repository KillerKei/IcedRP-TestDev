irpCore = nil
TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)
---------- Pawn Shop --------------

RegisterServerEvent('irp-pawnshop:selljewels')
AddEventHandler('irp-pawnshop:selljewels', function()
	local _source = source
	local xPlayer = irpCore.GetPlayerFromId(_source)
	local jewels = 0
			
	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]
			
		if item.name == "jewels" then
			jewels = item.count
		end
	end
				
		if jewels > 0 then
			xPlayer.removeInventoryItem('jewels', 1)
			xPlayer.addMoney(50)
			TriggerClientEvent('DoLongHudText', xPlayer.source, 'You sold 1 jewel for $50', 1) 
		else 
			TriggerClientEvent('DoLongHudText', xPlayer.source, 'You don\'t enough jewels to sell!', 2) 
		end
end)

function DrawText3D(x, y, z, text, scale)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

  SetTextScale(scale, scale)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextEntry("STRING")
  SetTextCentre(1)
  SetTextColour(255, 255, 255, 255)
  SetTextOutline()

  AddTextComponentString(text)
  DrawText(_x, _y)

  local factor = (string.len(text)) / 270
  DrawRect(_x, _y + 0.015, 0.005 + factor, 0.03, 31, 31, 31, 155)
end