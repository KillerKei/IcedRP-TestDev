irpCore = nil

TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)

-- START TEST
local JobCooldown 		= {}
local ConvertTimer		= {}
local DrugEffectTimer	= {}
local soldAmount 		= {}

RegisterServerEvent("t1ger_drugs:syncJobsData")
AddEventHandler("t1ger_drugs:syncJobsData",function(data)
	TriggerClientEvent("t1ger_drugs:syncJobsData",-1,data)
end)

-- Server side table, to store cooldown for players:
RegisterServerEvent("t1ger_drugs:addCooldownToSource")
AddEventHandler("t1ger_drugs:addCooldownToSource",function(source)
	table.insert(JobCooldown,{cooldown = GetPlayerIdentifier(source), time = (Config.CooldownTime * 60000)})
end)

-- Server side table, to store convert timer for players:
RegisterServerEvent("t1ger_drugs:addConvertingTimer")
AddEventHandler("t1ger_drugs:addConvertingTimer",function(source,timer)
	table.insert(ConvertTimer,{convertWait = GetPlayerIdentifier(source), timeB = timer})
end)

-- Server side table, to store drug effect timer for players:
RegisterServerEvent("t1ger_drugs:addDrugEffectTimer")
AddEventHandler("t1ger_drugs:addDrugEffectTimer",function(source,timer)
	table.insert(DrugEffectTimer,{effectWait = GetPlayerIdentifier(source), timeC = timer})
end)

-- CreateThread Function for timer:
Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
	Citizen.Wait(1000)
		for k,v in pairs(JobCooldown) do
			if v.time <= 0 then
				RemoveCooldown(v.cooldown)
			else
				v.time = v.time - 1000
			end
		end
		for k,v in pairs(ConvertTimer) do
			if v.timeB <= 0 then
				RemoveConvertTimer(v.convertWait)
			else
				v.timeB = v.timeB - 1000
			end
		end
		for k,v in pairs(DrugEffectTimer) do
			if v.timeC <= 0 then
				RemoveDrugEffectTimer(v.effectWait)
			else
				v.timeC = v.timeC - 1000
			end
		end
	end
end)

-- Usable item to start drugs jobs:
irpCore.RegisterUsableItem('drugItem', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)
	if not HasCooldown(GetPlayerIdentifier(source)) then
		if xPlayer.getInventoryItem(Config.HackerDevice).count >= 1 then
			TriggerClientEvent("t1ger_drugs:UsableItemCoke",source)
			xPlayer.removeInventoryItem('drugItem',1)
		else
			TriggerClientEvent('DoLongHudText', source, "You need a Hacking Device to use the USB", 1)
		end
	else
		TriggerClientEvent('DoLongHudText', source,string.format("USB is usable in: %s minutes",GetCooldownTime(GetPlayerIdentifier(source))), 1)
	end
end)

-- Usable item to start drugs jobs:
irpCore.RegisterUsableItem('drugItem2', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)
	if not HasCooldown(GetPlayerIdentifier(source)) then
		if xPlayer.getInventoryItem(Config.HackerDevice).count >= 1 then
			TriggerClientEvent("t1ger_drugs:UsableItemMeth",source)
			xPlayer.removeInventoryItem('drugItem2',1)
		else
			TriggerClientEvent('DoLongHudText', source, "You need a Hacking Device to use the USB", 1)
		end
	else
		TriggerClientEvent('DoLongHudText', source,string.format("USB is usable in: %s minutes",GetCooldownTime(GetPlayerIdentifier(source))), 1)
	end
end)

-- Usable item to start drugs jobs:
irpCore.RegisterUsableItem('drugItem3', function(source)
	local xPlayer = irpCore.GetPlayerFromId(source)
	if not HasCooldown(GetPlayerIdentifier(source)) then
		if xPlayer.getInventoryItem(Config.HackerDevice).count >= 1 then
			TriggerClientEvent("t1ger_drugs:UsableItemWeed",source)
		else
			TriggerClientEvent('DoLongHudText', source, "You need a Hacking Device to use the USB", 1)
		end
	else
		TriggerClientEvent('DoLongHudText', source,string.format("USB is usable in: %s minutes",GetCooldownTime(GetPlayerIdentifier(source))), 1)
	end
end)

-- Server Event for Buying Drug Job:
RegisterServerEvent("t1ger_drugs:GetSelectedJob")
AddEventHandler("t1ger_drugs:GetSelectedJob", function(drugType,BuyPrice,minReward,maxReward)
	local xPlayer = irpCore.GetPlayerFromId(source)
	local itemLabel = irpCore.GetItemLabel(itemName)
	if xPlayer.getMoney() >= BuyPrice then
		xPlayer.removeMoney(BuyPrice)
		TriggerEvent("t1ger_drugs:addCooldownToSource",source)
		TriggerClientEvent("t1ger_drugs:BrowseAvailableJobs",source, 0, drugType, minReward, maxReward)
		if drugType == "coke" then
			label = "Coke"
		elseif drugType == "meth" then
			label = "Meth"
		elseif drugType == "weed" then
			label = "Weed"
		end	
		TriggerClientEvent('DoLongHudText', source, "You paid $"..BuyPrice.." for a "..label.." job", 1)
	else
		TriggerClientEvent('DoLongHudText', source, "You dont have enough money", 2)
	end
end)

irpCore.RegisterUsableItem('joint2g', function(source)
	--if not CheckedStartedDrugs(GetPlayerIdentifier(source)) then
	--TriggerEvent("t1ger_drugs:startDrugsTimer",source)
	TriggerClientEvent("t1ger_drugs:DrugEffects",source)
	local xPlayer = irpCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("joint2g",1)
	--else
	 	--TriggerClientEvent("DoLongHudText",source,string.format("You can consume another drug in: %s seconds",GetTimeForDrugs(GetPlayerIdentifier(source))))
	--end
end)

-- Server Event for Job Reward:
RegisterServerEvent("t1ger_drugs:JobReward")
AddEventHandler("t1ger_drugs:JobReward",function(minReward,maxReward,typeDrug)
	local minDrugReward = minReward
	local maxDrugReward = maxReward
	local xPlayer = irpCore.GetPlayerFromId(source)
	drugAmount = math.random(minDrugReward,maxDrugReward)
	xPlayer.addInventoryItem(typeDrug.."brick",math.ceil(drugAmount))
end)

-- Usable item for drug effects:
Citizen.CreateThread(function()
	for k,v in pairs(Config.DrugEffects) do 
		irpCore.RegisterUsableItem(v.UsableItem, function(source)
			local xPlayer = irpCore.GetPlayerFromId(source)
			local itemLabel = irpCore.GetItemLabel(v.UsableItem)
			
			if not DrugEffect(GetPlayerIdentifier(source)) then
				TriggerEvent("t1ger_drugs:addDrugEffectTimer",source,v.UsableTime)
				xPlayer.removeInventoryItem(v.UsableItem,1)
				Citizen.Wait(500)
				TriggerClientEvent('irp-inventory:refreshInventory', source)
				TriggerClientEvent("t1ger_drugs:DrugEffects",source,k,v)
			else
				TriggerClientEvent('DoLongHudText', source,string.format("You are already consuming a drug",GetDrugEffectTime(GetPlayerIdentifier(source))), 1)	
			end	
		end)
	end
end)

-- Usable item to convert drugs:
Citizen.CreateThread(function()
	for k,v in pairs(Config.DrugConversion) do 
		irpCore.RegisterUsableItem(v.UsableItem, function(source)
			local xPlayer = irpCore.GetPlayerFromId(source)
			local itemLabel = irpCore.GetItemLabel(v.UsableItem)
			local drugOutput
			local requiredItems
			
			local scale = xPlayer.getInventoryItem(v.hqscale).count >= 1
			if v.HighQualityScale then
				if scale then
					drugOutput = v.RewardAmount.b
					requiredItems = v.RequiredItemAmount.d
				else
					drugOutput = v.RewardAmount.a
					requiredItems = v.RequiredItemAmount.c
				end
			else
				drugOutput = v.RewardAmount
				requiredItems = v.RequiredItemAmount
			end
				
			local reqItems = xPlayer.getInventoryItem(v.RequiredItem).count >= requiredItems
			if not reqItems then
				local reqItemLabel = irpCore.GetItemLabel(v.RequiredItem)
				TriggerClientEvent('DoLongHudText', source,"You do not have enough "..reqItemLabel..".", 2)
				return
			end
			
			if xPlayer.getInventoryItem(v.RewardItem).count <= v.MaxRewardItemInv.f or (not scale and xPlayer.getInventoryItem(v.RewardItem).count <= v.MaxRewardItemInv.e) then
				if not Converting(GetPlayerIdentifier(source)) then
					xPlayer.removeInventoryItem(v.UsableItem,1)
					TriggerEvent("t1ger_drugs:addConvertingTimer",source,v.ConversionTime)
					xPlayer.removeInventoryItem(v.RequiredItem,requiredItems)
					TriggerClientEvent("t1ger_drugs:ConvertProcess",source,k,v)
					Citizen.Wait(v.ConversionTime)
					xPlayer.addInventoryItem(v.RewardItem,drugOutput)
					Citizen.Wait(1000)
					TriggerClientEvent('irp-inventory:refreshInventory', source)
				else
					TriggerClientEvent('DoLongHudText', source,string.format("You are already converting",GetConvertTime(GetPlayerIdentifier(source))), 1)	
				end	
			else
				TriggerClientEvent('DoLongHudText', source,"You do not have enough empty space for more "..itemLabel..".", 2)
			end
		end)
	end
end)

RegisterServerEvent('t1ger_drugs:DrugJobInProgress')
AddEventHandler('t1ger_drugs:DrugJobInProgress', function()
	TriggerClientEvent('irp-dispatch:drugjob', -1)
	return
end)

RegisterServerEvent('t1ger_drugs:DrugSaleInProgress')
AddEventHandler('t1ger_drugs:DrugSaleInProgress', function()
	TriggerClientEvent('irp-dispatch:drugjob', -1)
	return
end)

RegisterServerEvent("t1ger_drugs:sellDrugs")
AddEventHandler("t1ger_drugs:sellDrugs", function()
	local xPlayer = irpCore.GetPlayerFromId(source)
	local weed = xPlayer.getInventoryItem(Config.WeedDrug).count
	local meth = xPlayer.getInventoryItem(Config.MethDrug).count
	local coke = xPlayer.getInventoryItem(Config.CokeDrug).count
	local drugamount = 0
	local price = 0
	local drugType = nil
	
	if weed > 0 then
		drugType = Config.WeedDrug
		if weed == 1 then
			drugamount = 1
		elseif weed == 2 then
			drugamount = math.random(1,2)
		elseif weed == 3 then	
			drugamount = math.random(1,3)
		elseif weed >= 4 then	
			drugamount = math.random(1,4)
		end
		
	elseif meth > 0 then
		drugType = Config.MethDrug
		if meth == 1 then
			drugamount = 1
		elseif meth == 2 then
			drugamount = math.random(1,2)
		elseif meth >= 3 then	
			drugamount = math.random(1,3)
		end
		
	elseif coke > 0 then
		drugType = Config.CokeDrug
		if coke == 1 then
			drugamount = 1
		elseif coke == 2 then
			drugamount = math.random(1,2)
		elseif coke >= 3 then	
			drugamount = math.random(1,3)
		end
	
	else
		TriggerEvent("DoLongHudText", source, "You have no more drugs on you", 2)
		return
	end
	
	if drugType==Config.WeedDrug then
		price = math.random(Config.WeedSale.min,Config.WeedSale.max) * 10 * drugamount
	elseif drugType==Config.MethDrug then
		price = math.random(Config.MethSale.min,Config.MethSale.max) * 10 * drugamount
	elseif drugType==Config.CokeDrug then
		price = math.random(Config.CokeSale.min,Config.CokeSale.max) * 10 * drugamount
	end
	
	if drugType ~= nil then
		local drugLabel = irpCore.GetItemLabel(drugType)
		AddToSoldAmount(xPlayer.getIdentifier(),drugamount)
		xPlayer.removeInventoryItem(drugType, drugamount)
		if Config.ReceiveDirtyCash then
			xPlayer.addAccountMoney('black_money', price)
		else
			xPlayer.addMoney(price)
		end
		Citizen.Wait(500)
	end		
end)

RegisterServerEvent("t1ger_drugs:canSellDrugs")
AddEventHandler("t1ger_drugs:canSellDrugs", function()
	local xPlayer = irpCore.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local soldAmount = (xPlayer.getInventoryItem("coke1g").count > 0 or xPlayer.getInventoryItem("meth1g").count > 0 or xPlayer.getInventoryItem("weed4g").count > 0) and CheckSoldAmount(xPlayer.getIdentifier()) < Config.maxCap
		TriggerClientEvent("t1ger_drugs:canSellDrugs",source,soldAmount)
	end
end)

function AddToSoldAmount(source,amount)
	for k,v in pairs(soldAmount) do
		if v.id == source then
			v.amount = v.amount + amount
			return
		end
	end
end
function CheckSoldAmount(source)
	for k,v in pairs(soldAmount) do
		if v.id == source then
			return v.amount
		end
	end
	table.insert(soldAmount,{id = source, amount = 0})
	return CheckSoldAmount(source)
end

-- Do not touch these 6 functions!
function RemoveCooldown(source)
	for k,v in pairs(JobCooldown) do
		if v.cooldown == source then
			table.remove(JobCooldown,k)
		end
	end
end
function GetCooldownTime(source)
	for k,v in pairs(JobCooldown) do
		if v.cooldown == source then
			return math.ceil(v.time/60000)
		end
	end
end
function HasCooldown(source)
	for k,v in pairs(JobCooldown) do
		if v.cooldown == source then
			return true
		end
	end
	return false
end
function RemoveDrugEffectTimer(source)
	for k,v in pairs(DrugEffectTimer) do
		if v.effectWait == source then
			table.remove(DrugEffectTimer,k)
		end
	end
end
function GetDrugEffectTime(source)
	for k,v in pairs(DrugEffectTimer) do
		if v.effectWait == source then
			return math.ceil(v.timeC/1000)
		end
	end
end
function DrugEffect(source)
	for k,v in pairs(DrugEffectTimer) do
		if v.effectWait == source then
			return true
		end
	end
	return false
end
function RemoveConvertTimer(source)
	for k,v in pairs(ConvertTimer) do
		if v.convertWait == source then
			table.remove(ConvertTimer,k)
		end
	end
end
function GetConvertTime(source)
	for k,v in pairs(ConvertTimer) do
		if v.convertWait == source then
			return math.ceil(v.timeB/1000)
		end
	end
end
function Converting(source)
	for k,v in pairs(ConvertTimer) do
		if v.convertWait == source then
			return true
		end
	end
	return false
end
