Citizen.CreateThread(function()
    while true do
        for a = 1, #TaxiConfig.TaxiDepos do
            local ped = GetPlayerPed(PlayerId())
            local pedPos = GetEntityCoords(ped, false)
            local distance = Vdist(pedPos.x, pedPos.y, pedPos.z, TaxiConfig.TaxiDepos[a].x, TaxiConfig.TaxiDepos[a].y, TaxiConfig.TaxiDepos[a].z)
            if distance <= 15.0 then
                DrawMarker(1, TaxiConfig.TaxiDepos[a].x, TaxiConfig.TaxiDepos[a].y, TaxiConfig.TaxiDepos[a].z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 150, 61, 61, 1.0, 0, 0, 0, 0, 0, 0, 0)
                if distance <= 1.2 then
                    if taxicab == nil then
                        Draw3DText(TaxiConfig.TaxiDepos[a].x, TaxiConfig.TaxiDepos[a].y, TaxiConfig.TaxiDepos[a].z, tostring("[E] - Acquire a taxicab"))
                    else
                        Draw3DText(TaxiConfig.TaxiDepos[a].x, TaxiConfig.TaxiDepos[a].y, TaxiConfig.TaxiDepos[a].z, tostring("[E] - Return your taxicab"))
                    end
                    if IsControlJustPressed(1, 38) and attachedVehicle == nil then
                        if taxicab == nil then
                            Acquiretaxicab(TaxiConfig.TaxiDepos[a].spawn)
                        else
                            Returntaxicab()
                        end
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)

function Acquiretaxicab(spawn)
    local model = GetHashKey(TaxiConfig.TaxiModel)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    local spawned = CreateVehicle(model, spawn.x, spawn.y, spawn.z, spawn.h, 1, 1)
    PlaceObjectOnGroundProperly(spawned)
    SetEntityAsMissionEntity(spawned, 1, 1)
    SetEntityAsNoLongerNeeded(spawned)
    taxicab = spawned
end

function Returntaxicab()
    DeleteEntity(taxicab)
    if not DoesEntityExist(taxicab) then
        taxicab = nil
    end
end

function Draw3DText(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextDropshadow(0, 0, 0, 0, 155)
	SetTextEdge(1, 0, 0, 0, 250)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end