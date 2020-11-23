
TriggerServerEvent("particles:player:ready") -- Optional, only needed if no other resource keeps track of connected players server side

function LoadParticleDictionary(dictionary)
	if not HasNamedPtfxAssetLoaded(dictionary) then
		RequestNamedPtfxAsset(dictionary)
		while not HasNamedPtfxAssetLoaded(dictionary) do
			Citizen.Wait(0)
		end
	end
end

RegisterNetEvent("particle:sync:coord")
AddEventHandler("particle:sync:coord", function(ptDict, ptName, position, looped, duration)
	local coords, rot, scale, alpha = position.coords, position.rot, position.scale, position.alpha or 10.0
	LoadParticleDictionary(ptDict)
	UseParticleFxAssetNextCall(ptDict)
	if looped then 
		local particleHandle = StartParticleFxLoopedAtCoord(ptName, coords.x, coords.y, coords.z, rot.x, rot.y, rot.z, scale)
		SetParticleFxLoopedAlpha(particleHandle, alpha)
		Citizen.Wait(duration)
		StopParticleFxLooped(particleHandle, 0) 
	else
		SetParticleFxNonLoopedAlpha(alpha)
		StartParticleFxNonLoopedAtCoord(ptName, coords.x, coords.y, coords.z, rot.x, rot.y, rot.z, scale)
	end
end)

RegisterNetEvent("particle:sync:entity")
AddEventHandler("particle:sync:entity", function(ptDict, ptName, target, position, bone, looped, duration)
	local offset, rot, scale, alpha = position.offset, position.rot, position.scale, position.alpha or 10.0
	local entity = NetworkGetEntityFromNetworkId(target)
	LoadParticleDictionary(ptDict)
	UseParticleFxAssetNextCall(ptDict)
	if looped then
		local particleHandles = {}
		if bone then
			if type(bone) == 'table' then
                for i, b in pairs(bone) do
	                UseParticleFxAssetNextCall(ptDict)
					local boneIndex = GetEntityBoneIndexByName(entity, b)
					if boneIndex ~= -1 then
						particleHandles[#particleHandles + 1] = StartParticleFxLoopedOnEntityBone(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, boneIndex, scale)
					end
				end
			else
				local boneIndex = GetEntityBoneIndexByName(entity, bone)
				if boneIndex ~= -1 then
					particleHandles[#particleHandles + 1] = StartParticleFxLoopedOnEntityBone(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, boneIndex, scale)
				end
			end
		else
			particleHandles[#particleHandles + 1] = StartParticleFxLoopedOnEntity(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale)
		end
		for _, particleHandle in pairs(particleHandles) do
			if position.color then
				local color = position.color
				SetParticleFxLoopedColour(particleHandle, color.r, color.g, color.b, 0)
			end
			SetParticleFxLoopedAlpha(particleHandle, alpha)
		end
		Citizen.Wait(duration)
		for _, particleHandle in pairs(particleHandles) do
			StopParticleFxLooped(particleHandle, 0)
		end
	else
		SetParticleFxNonLoopedAlpha(alpha)
		if bone then
			StartParticleFxNonLoopedOnPedBone(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, GetEntityBoneIndexByName(entity, bone), scale)
		else
			StartParticleFxNonLoopedOnEntity(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale)
		end
	end
end)

RegisterNetEvent("particle:sync:player")
AddEventHandler("particle:sync:player", function(ptDict, ptName, target, position, bone, looped, duration)
	local offset, rot, scale, alpha = position.offset, position.rot, position.scale, position.alpha or 10.0
	local playerPed = GetPlayerPed(GetPlayerFromServerId(target))
	LoadParticleDictionary(ptDict)
	UseParticleFxAssetNextCall(ptDict)
	if looped then 
		local particleHandle 
		if bone then 			
			particleHandle = StartParticleFxLoopedOnEntityBone(ptName, playerPed, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, GetPedBoneIndex(playerPed, bone), scale)
		else
			particleHandle = StartParticleFxLoopedOnEntity(ptName, playerPed, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale)
		end
		SetParticleFxLoopedAlpha(particleHandle, alpha)
		if position.color then
			local color = position.color
			SetParticleFxLoopedColour(particleHandle, color.r, color.g, color.b, 0)
		end
		Citizen.Wait(duration)
		StopParticleFxLooped(particleHandle, 0) 
	else
		SetParticleFxNonLoopedAlpha(alpha)
		if bone then 
			StartParticleFxNonLoopedOnPedBone(ptName, playerPed, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, GetPedBoneIndex(playerPed, bone), scale)
		else
			StartParticleFxNonLoopedOnEntity(ptName, playerPed, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale)
		end
	end
end)