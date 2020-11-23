RegisterNetEvent('MF_DopePlant:SyncPlant')
RegisterNetEvent('MF_DopePlant:RemovePlant')

local MFD = MF_DopePlant
local PlayerConvertTimer = {}

function MFD:Awake(...)
  while not irpCore do 
    Citizen.Wait(0); 
  end

  self:DSP(true);
  self.dS = true
  self:Start()
end

function MFD:DoLogin(src)  
  self:DSP(true);
end

function MFD:DSP(val) self.cS = val; end
function MFD:Start(...)
  self:Update();
end

function MFD:Update(...)
end

function MFD:SyncPlant(plant,delete)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  local identifier = xPlayer.getIdentifier()
  plant["Owner"] = identifier
  if delete then 
    if xPlayer.job.label ~= self.PoliceJobLabel then
      self:RewardPlayer(source, plant)
    end
  end
  self:PlantCheck(identifier,plant,delete) 
  TriggerClientEvent('MF_DopePlant:SyncPlant',-1,plant,delete)
end

function MFD:RewardPlayer(source,plant)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  if not source or not plant then return; end
  if plant.Gender == "Male" then
    math.random();math.random();math.random();
    local r = math.random(1000,5000)
    if r < 3000 then
      if plant.Quality > 95 then
        xPlayer.addInventoryItem('highgrademaleseed',math.random(3, 6))
        xPlayer.addInventoryItem('highgradefemaleseed',math.random(2, 4))
        --xPlayer.addInventoryItem('highgrademaleseed', math.floor( math.random( math.floor(plant.Quality/1), math.floor(plant.Quality*1.5))/15))
        --xPlayer.addInventoryItem('highgradefemaleseed', math.floor( math.random( math.floor(plant.Quality/1), math.floor(plant.Quality*1.5))/20))
      elseif plant.Quality > 80 then
        xPlayer.addInventoryItem('highgrademaleseed',math.random(2, 5))
        xPlayer.addInventoryItem('highgradefemaleseed',math.random(1, 3))
        --xPlayer.addInventoryItem('highgrademaleseed', math.floor( math.random( math.floor(plant.Quality/3), math.floor(plant.Quality*1.5))/25))
        --xPlayer.addInventoryItem('highgradefemaleseed', math.floor( math.random( math.floor(plant.Quality/3), math.floor(plant.Quality*1.5))/30))
      else
      --  xPlayer.addInventoryItem('lowgrademaleseed', math.floor( math.random( math.floor(plant.Quality/2), math.floor(plant.Quality))/20))
      end
    else
      if plant.Quality > 95 then
        xPlayer.addInventoryItem('highgrademaleseed',math.random(3, 5))
        xPlayer.addInventoryItem('highgradefemaleseed',math.random(2, 4)) --xPlayer.addInventoryItem('highgradefemaleseed', math.floor( math.random( math.floor(plant.Quality/2),math.floor(plant.Quality*1.5))/25))
      elseif plant.Quality > 80 then
        xPlayer.addInventoryItem('highgrademaleseed',math.random(2, 5))
        xPlayer.addInventoryItem('highgradefemaleseed',math.random(1, 3)) --xPlayer.addInventoryItem('highgradefemaleseed', math.floor( math.random( math.floor(plant.Quality/3),math.floor(plant.Quality*1.5))/35))
      else
      --  xPlayer.addInventoryItem('lowgrademaleseed', math.floor( math.random( math.floor(plant.Quality/2),math.floor( plant.Quality ))/20 ))
      end
      --xPlayer.addInventoryItem('lowgradefemaleseed', math.floor( math.random( math.floor(plant.Quality/2), math.floor( plant.Quality ))/20 ))
    end
  else
    if plant and plant.Quality and plant.Quality > 80 then
      xPlayer.addInventoryItem('weed20g', math.random(2, 5)) --xPlayer.addInventoryItem('weed20g', math.floor( math.random( math.floor(plant.Quality/3), math.floor(plant.Quality/4) ) ) )
    elseif plant.Quality then
      xPlayer.addInventoryItem('weed20g', math.random(1, 3)) --xPlayer.addInventoryItem('weed20g', math.floor( math.random( math.floor(plant.Quality/4), math.floor(plant.Quality/6) ) ) )
    end
  end
end

function MFD:PlantCheck(identifier, plant, delete)
  if not plant or not identifier then return; end
  local data = MySQL.Sync.fetchAll('SELECT * FROM dopeplants WHERE plantid=@plantid',{['@plantid'] = plant.PlantID})
  if not delete then
    if not data or not data[1] then  
      MySQL.Async.execute('INSERT INTO dopeplants (owner, plantid, plant) VALUES (@owner, @id, @plant)',{['@owner'] = identifier,['@id'] = plant.PlantID, ['@plant'] = json.encode(plant)})
    else
      MySQL.Sync.execute('UPDATE dopeplants SET plant=@plant WHERE plantid=@plantid',{['@plant'] = json.encode(plant),['@plantid'] = plant.PlantID})
    end
  else
    if data and data[1] then
      MySQL.Async.execute('DELETE FROM dopeplants WHERE plantid=@plantid', {['@plantid'] = plant.PlantID})
    end
  end
end

function MFD:GetLoginData(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  local data = MySQL.Sync.fetchAll('SELECT * FROM dopeplants WHERE owner=@owner',{['@owner'] = xPlayer.identifier})
  if not data or not data[1] then return false; end
  local aTab = {}
  for k = 1,#data,1 do
    local v = data[k]
    if v and v.plant then
      local data = json.decode(v.plant)
      table.insert(aTab,data)
    end
  end
  return aTab
end

function MFD:ItemTemplate()
  return {
    ["Type"] = "Water",
    ["Quality"] = 0.0,
  }
end

function MFD:PlantTemplate()
  return {
    ["Gender"] = "Female",
    ["Quality"] = 0.0,
    ["Growth"] = 0.0,
    ["Water"] = 20.0,
    ["Food"] = 20.0,
    ["Stage"] = 1,
    ["PlantID"] = math.random(math.random(999999,9999999),math.random(99999999,999999999))
  }
end

irpCore.RegisterServerCallback('MF_DopePlant:GetLoginData', function(source,cb) cb(MFD:GetLoginData(source)); end)
irpCore.RegisterServerCallback('MF_DopePlant:GetStartData', function(source,cb) while not MFD.dS do Citizen.Wait(0); end; cb(MFD.cS); end)
AddEventHandler('MF_DopePlant:SyncPlant', function(plant,delete) MFD:SyncPlant(plant,delete); end)
AddEventHandler('playerConnected', function(...) MFD:DoLogin(source); end)
Citizen.CreateThread(function(...) MFD:Awake(...); end)

irpCore.RegisterUsableItem('purifiedwater', function(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('purifiedwater').count > 0 then 
    xPlayer.removeInventoryItem('purifiedwater', 1)

    local template = MFD:ItemTemplate()
    template.Type = "Water"
    template.Quality = 0.2

    TriggerClientEvent('MF_DopePlant:UseItem',source,template)
  end
end)

irpCore.RegisterUsableItem('highgradefert', function(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('highgradefert').count > 0 then 
    xPlayer.removeInventoryItem('highgradefert', 1)

    local template = MFD:ItemTemplate()
    template.Type = "Food"
    template.Quality = 0.2

    TriggerClientEvent('MF_DopePlant:UseItem',source,template)
    TriggerClientEvent('tm1_stores:addFertilizer', source, 50)
  end
end)

irpCore.RegisterUsableItem('highgrademaleseed', function(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('highgrademaleseed').count > 0 and xPlayer.getInventoryItem('plantpot').count > 0 then
    xPlayer.removeInventoryItem('highgrademaleseed', 1)
    xPlayer.removeInventoryItem('plantpot', 1)

    local template = MFD:PlantTemplate()
    template.Gender = "Male"
    template.Quality = 0.2
    template.Quality = math.random(200,500)/10
    template.Food =  math.random(200,400)/10
    template.Water = math.random(200,400)/10

    TriggerClientEvent('MF_DopePlant:UseSeed',source,template)
  end
end)

irpCore.RegisterUsableItem('highgradefemaleseed', function(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('highgradefemaleseed').count > 0 and xPlayer.getInventoryItem('plantpot').count > 0 then
    xPlayer.removeInventoryItem('highgradefemaleseed', 1)
    xPlayer.removeInventoryItem('plantpot', 1)

    local template = MFD:PlantTemplate()
    template.Gender = "Female"
    template.Quality = 0.2
    template.Quality = math.random(200,500)/10
    template.Food =  math.random(200,400)/10
    template.Water = math.random(200,400)/10

    TriggerClientEvent('MF_DopePlant:UseSeed',source,template)
  end
end)

--EDITS
-- WEED Oz >> Weed Hq
irpCore.RegisterUsableItem('weed20g', function(source)
		
	local xPlayer = irpCore.GetPlayerFromId(source)
	local weedBag = xPlayer.getInventoryItem("weed20g").count >= 1
	local scale = xPlayer.getInventoryItem("hqscale").count >= 1
	local bags = xPlayer.getInventoryItem("drugbags").count >= 3
	
	if not bags or not weedBag then
		if not bags then
			TriggerClientEvent("DoLongHudText",source,'You do not have enough bags', 2)
		else
			TriggerClientEvent("DoLongHudText",source,'You do not have enough Weed Oz', 2)
		end
		return
	end
	
	local maxWeedBagOutput = 5
		
	if not scale then
		maxWeedBagOutput = 4
	end
	
	if xPlayer.getInventoryItem("weed4g").count <= 195 or (not scale and xPlayer.getInventoryItem("weed4g").count <= 196) then
		if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
			TriggerEvent("irp-WeedPlants:startConvertTimer",source)
		
			xPlayer.removeInventoryItem("weed20g",1)
			xPlayer.removeInventoryItem("drugbags", 3)
		
			TriggerClientEvent("Weed20gToWeed4g",source)
			Citizen.Wait(15000)
		
			xPlayer.addInventoryItem("weed4g",maxWeedBagOutput)
		else
			TriggerClientEvent("DoLongHudText",source,string.format("You are already engaged in a process!",GetTimeForConvert(GetPlayerIdentifier(source))))
		end
	else
		TriggerClientEvent("DoLongHudText",source,"You do not have enough empty space for more Weed Hq", 2)
	end
end)

-- WEED Hq >> 2g Joint
irpCore.RegisterUsableItem('weed4g', function(source)

	local xPlayer = irpCore.GetPlayerFromId(source)
	local weed = xPlayer.getInventoryItem("weed4g").count >= 1
	local paper = xPlayer.getInventoryItem("rolpaper").count >= 2

	if not paper or not weed then
		if not paper then
			TriggerClientEvent("DoLongHudText",source, "You do not have enough rolling paper", 2)
		else
			TriggerClientEvent("DoLongHudTextDoLongHudText", source, "You do not have enough Weed Hq", 2)
		end
		return
	end
	
	if xPlayer.getInventoryItem("joint2g").count <= 48 then
		if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
			TriggerEvent("irp-WeedPlants:startConvertTimer",source)
		
			xPlayer.removeInventoryItem("weed4g",1)
			xPlayer.removeInventoryItem("rolpaper",2)
		
			TriggerClientEvent("Weed4gToJoint2g",source)
			Citizen.Wait(15000)
		
			xPlayer.addInventoryItem("joint2g",2)
		else
			TriggerClientEvent("DoLongHudText",source,string.format("You are already engaged in a process!",GetTimeForConvert(GetPlayerIdentifier(source))), 2)
		end
	else
		TriggerClientEvent("DoLongHudText",source,"You do not have enough empty space for more Joints", 2)
	end
end)

function CheckedStartedConvert(source)
	for k,v in pairs(PlayerConvertTimer) do
		if v.startedConvert == source then
			return true
		end
	end
	return false
end

function GetTimeForDrugs(source)
	for k,v in pairs(PlayerDrugsTimer) do
		if v.startedDrugs == source then
			return math.ceil(v.timeDrugs/1000)
		end
	end
end

function CheckedStartedDrugs(source)
	for k,v in pairs(PlayerDrugsTimer) do
		if v.startedDrugs == source then
			return true
		end
	end
	return false
end

function RemoveStartedConvert(source)
	for k,v in pairs(PlayerConvertTimer) do
		if v.startedConvert == source then
			table.remove(PlayerConvertTimer,k)
		end
	end
end

-- Maintenance Items
--[[irpCore.RegisterUsableItem('wateringcan', function(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('wateringcan').count > 0 then 
    xPlayer.removeInventoryItem('wateringcan', 1)

    local template = MFD:ItemTemplate()
    template.Type = "Water"
    template.Quality = 0.1

    TriggerClientEvent('MF_DopePlant:UseItem',source,template)
    TriggerClientEvent('tm1_stores:addWater', source, 25)
  end
end)

irpCore.RegisterUsableItem('bagofdope', function(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('bagofdope').count > 0 then
    xPlayer.removeInventoryItem('bagofdope', 1)
    Citizen.Wait(1000)
    xPlayer.addAccountMoney('black_money', math.random(700, 1500))
  end
end)

irpCore.RegisterUsableItem('lowgradefert', function(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('lowgradefert').count > 0 then 
    xPlayer.removeInventoryItem('lowgradefert', 1)

    local template = MFD:ItemTemplate()
    template.Type = "Food"
    template.Quality = 0.1

    TriggerClientEvent('MF_DopePlant:UseItem',source,template)
    TriggerClientEvent('tm1_stores:addFertilizer', source, 25)
  end
end)

irpCore.RegisterUsableItem('lowgrademaleseed', function(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('lowgrademaleseed').count > 0 and xPlayer.getInventoryItem('plantpot').count > 0 then 
    xPlayer.removeInventoryItem('lowgrademaleseed', 1)
    xPlayer.removeInventoryItem('plantpot', 1)

    local template = MFD:PlantTemplate()
    template.Gender = "Male"
    template.Quality = math.random(1,100)/10
    template.Food =  math.random(100,200)/10
    template.Water = math.random(100,200)/10

    TriggerClientEvent('MF_DopePlant:UseSeed',source,template)
  end
end

irpCore.RegisterUsableItem('lowgradefemaleseed', function(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('lowgradefemaleseed').count > 0 and xPlayer.getInventoryItem('plantpot').count > 0 then
    xPlayer.removeInventoryItem('lowgradefemaleseed', 1)
    xPlayer.removeInventoryItem('plantpot', 1)

    local template = MFD:PlantTemplate()
    template.Gender = "Female"
    template.Quality = 0.1
    template.Quality = math.random(1,100)/10
    template.Food =  math.random(100,200)/10
    template.Water = math.random(100,200)/10

    TriggerClientEvent('MF_DopePlant:UseSeed',source,template)
  end
end)

irpCore.RegisterUsableItem('drugbags', function(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  local canUse = false
  local msg = ''
  if xPlayer.getInventoryItem('trimmedweed').count >= MFD.WeedPerBag and xPlayer.getInventoryItem('hqscale').count > 0 then
    xPlayer.removeInventoryItem('drugbags', 1)
    xPlayer.removeInventoryItem('trimmedweed', MFD.WeedPerBag)
    xPlayer.addInventoryItem('bagofdope', 1)
    canUse = true
    msg = "You put "..MFD.WeedPerBag.." trimmed weed into the ziplock bag"
  elseif xPlayer.getInventoryItem('trimmedweed').count > 0 then
    msg = "You need scales to weigh the bag up correctly."
  else
    msg = "You don't have enough trimmed weed to do this."
  end
  TriggerClientEvent('MF_DopePlant:UseBag', source, canUse, msg)
end)

--uhmm just adding this here for now.. and see what i can do with it 
irpCore.RegisterUsableItem('rolpaper', function(source)
  local xPlayer = irpCore.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); irpCore.GetPlayerFromId(source); end
  local canUse = true
  local msg = ''
  if xPlayer.getInventoryItem('bagofdope').count >= MFD.JointPerPaper and xPlayer.getInventoryItem('rolpaper').count > 0 then
    xPlayer.removeInventoryItem('bagofdope', 1)
    xPlayer.removeInventoryItem('rolpaper', 3)
    xPlayer.addInventoryItem('joint2g', 3)
    canUse = true
    msg = "You rolled " ..MFD.JointPerPaper.. " joints"
  elseif xPlayer.getInventoryItem('bagofdope').count > 0 then
    msg = "You need a bag of dope roll joints."
  else
    msg = "You don't have enough weed to do this."
  end
  TriggerClientEvent('MF_DopePlant:UseBag', source, canUse, msg)
end)]]