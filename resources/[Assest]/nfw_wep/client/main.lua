irpCore = nil
local IsDead = false

Citizen.CreateThread(function()
	while irpCore == nil do
		TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('playerSpawned', function()
    used = 0
    used2 = 0
    used3 = 0
    used4 = 0
end)

RegisterNetEvent('irp:playerLoaded')
AddEventHandler('irp:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

local used = 0

RegisterNetEvent('nfw_wep:silencieux')
AddEventHandler('nfw_wep:silencieux', function(duration)
    local inventory = irpCore.GetPlayerData().inventory
    local silencieux = 0
    
    for i=1, #inventory, 1 do
        if inventory[i].name == 'silencieux' then
            silencieux = inventory[i].count
        end
    end

    local ped = PlayerPedId()
    local WepHash = GetSelectedPedWeapon(ped)

    if WepHash == GetHashKey("WEAPON_PISTOL") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("component_at_pi_supp_02"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_PISTOL50") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
   
    elseif WepHash == GetHashKey("WEAPON_COMBATPISTOL") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    elseif WepHash == GetHashKey("WEAPON_APPISTOL") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_HEAVYPISTOL") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_VINTAGEPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_SMG") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_PI_SUPP"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_MICROSMG") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_ASSAULTSMG") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_ATCOMPONENT_AT_AR_SUPP_02_PI_SUPP"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_CARBINERIFLE") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
   
    elseif WepHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
   
    elseif WepHash == GetHashKey("WEAPON_SPECIALCARBINE") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_SR_SUPP"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    
    elseif WepHash == GetHashKey("WEAPON_SNIPERRIFLE") then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
        TriggerEvent('DoLongHudText', 'You have equipped a silencer!', 1)
        used = used + 1
    else
        TriggerEvent('DoLongHudText', 'You have used all your silencers!', 2)
    end
end)

local used2 = 0

RegisterNetEvent('nfw_wep:flashlight')
AddEventHandler('nfw_wep:flashlight', function(duration)                    
    local inventory = irpCore.GetPlayerData().inventory
	local flashlight = 0
    
    for i=1, #inventory, 1 do
		if inventory[i].name == 'flashlight' then
			flashlight = inventory[i].count
		end
	end
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
        
    if used2 <= flashlight then

		if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
		  	TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1) 
		  	used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
	  		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
		    GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
		    GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
		    GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_PI_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)         
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
		  	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))  
            TriggerEvent('DoLongHudText', 'You have equipped a flashlight!', 1)	        
            used2 = used2 + 1
		else 
            TriggerEvent('DoLongHudText', 'You do not have a weapon in hand that can equip a flashlight!', 2)  	 
		end
	else
        TriggerEvent('DoLongHudText', 'You have used all your flashlights!', 2)  	 
	end
end)

local used3 = 0

RegisterNetEvent('nfw_wep:grip')
AddEventHandler('nfw_wep:grip', function(duration)
    local inventory = irpCore.GetPlayerData().inventory
    local grip = 0

    for i=1, #inventory, 1 do
        if inventory[i].name == 'grip' then
            grip = inventory[i].count
        end
    end

    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    if used3 <= grip then
        if currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            TriggerEvent('DoLongHudText', 'You have equipped a grip!', 1)
            used3 = used3 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            TriggerEvent('DoLongHudText', 'You have equipped a grip!', 1)
            used3 = used3 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            TriggerEvent('DoLongHudText', 'You have equipped a grip!', 1)
            used3 = used3 + 1
       
        elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            TriggerEvent('DoLongHudText', 'You have equipped a grip!', 1)
            used3 = used3 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            TriggerEvent('DoLongHudText', 'You have equipped a grip!', 1)
            used3 = used3 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            TriggerEvent('DoLongHudText', 'You have equipped a grip!', 1)
            used3 = used3 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            TriggerEvent('DoLongHudText', 'You have equipped a grip!', 1)
            used3 = used3 + 1
       
        elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            TriggerEvent('DoLongHudText', 'You have equipped a grip!', 1)
            used3 = used3 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            TriggerEvent('DoLongHudText', 'You have equipped a grip!', 1)
            used3 = used3 + 1
        else
            TriggerEvent('DoLongHudText', 'You do not have a wepaon in hand that is compatible with a grip!', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You have used all your grip!', 2)
    end
end)

RegisterNetEvent('nfw_wep:yusuf')
AddEventHandler('nfw_wep:yusuf', function(duration)
    local inventory = irpCore.GetPlayerData().inventory
    local yusuf = 0
    for i=1, #inventory, 1 do
        if inventory[i].name == 'yusuf' then
            yusuf = inventory[i].count
        end
    end

    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    if used4 <= yusuf then

        if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_PISTOL_VARMOD_LUXE"))
           TriggerEvent('DoLongHudText', 'You have applied a Luxury Weapon Skin!', 1)
            used4 = used4 + 1
        
        elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_PISTOL50_VARMOD_LUXE"))
           TriggerEvent('DoLongHudText', 'You have applied a Luxury Weapon Skin!', 1)
            used4 = used4 + 1

        elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_APPISTOL_VARMOD_LUXE"))
           TriggerEvent('DoLongHudText', 'You have applied a Luxury Weapon Skin!', 1)
            used4 = used4 + 1

        elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_HEAVYPISTOL_VARMOD_LUXE"))
           TriggerEvent('DoLongHudText', 'You have applied a Luxury Weapon Skin!', 1)
            used4 = used4 + 1

        elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_SMG_VARMOD_LUXE"))
           TriggerEvent('DoLongHudText', 'You have applied a Luxury Weapon Skin!', 1)
            used4 = used4 + 1

        elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_MICROSMG_VARMOD_LUXE"))
           TriggerEvent('DoLongHudText', 'You have applied a Luxury Weapon Skin!', 1)
            used4 = used4 + 1

        elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"))
           TriggerEvent('DoLongHudText', 'You have applied a Luxury Weapon Skin!', 1)
            used4 = used4 + 1

        elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_CARBINERIFLE_VARMOD_LUXE"))
           TriggerEvent('DoLongHudText', 'You have applied a Luxury Weapon Skin!', 1)
            used4 = used4 + 1

        elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"))
           TriggerEvent('DoLongHudText', 'You have applied a Luxury Weapon Skin!', 1)
            used4 = used4 + 1
        else
            TriggerEvent('DoLongHudText', 'You do not have a wepaon in hand that is compatible with a skin!', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You have used all your weapon skins!', 2)
    end
end)

RegisterNetEvent('nfw_wep:HeavyArmor')
AddEventHandler('nfw_wep:HeavyArmor', function()
    local inventory = irpCore.GetPlayerData().inventory
    local ped = GetPlayerPed(-1)
    local armor = GetPedArmour(ped)
    local item = 'HeavyArmor'

    if(armor >= 100) or (armor+30 > 100) then
        TriggerEvent('DoLongHudText', 'Your armor is already maxed!', 2)
        TriggerServerEvent('returnItem', item)
        return
    end
    exports["irp-taskbar"]:taskBar(12000, "Applying")
    AddArmourToPed(ped, 100)
end)

RegisterNetEvent('nfw_wep:pAmmo')
AddEventHandler('nfw_wep:pAmmo', function()
    local ped = GetPlayerPed(-1)
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    local ammo = GetAmmoInPedWeapon(ped, currentWeaponHash)
    local item = "pAmmo"

    if(ammo >= 250 or ammo + 50 > 250) then
        TriggerEvent('DoLongHudText', 'Your weapon ammo is already maxed!', 2)
        TriggerServerEvent('returnItem', item)
        return
    end


    if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Pistol ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Pistol ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL_MK2") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Pistol ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Pistol ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_SNSPISTOL") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Pistol ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Pistol ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Pistol ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_REVOLVER") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Pistol ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Pistol ammo!', 1)
    else
        TriggerEvent('DoLongHudText', 'This weapon is not compatible with this ammo!', 2)
        TriggerServerEvent('returnItem', item)
    end
end)

RegisterNetEvent('nfw_wep:mgAmmo')
AddEventHandler('nfw_wep:mgAmmo', function()
    local ped = GetPlayerPed(-1)
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    local ammo = GetAmmoInPedWeapon(ped, currentWeaponHash)
    local item = "mgAmmo"

    if(ammo >= 250 or ammo + 50 > 250) then
        TriggerEvent('DoLongHudText', 'Your weapon ammo is already maxed!', 2)
        TriggerServerEvent('returnItem', item)
        return
    end

    if currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Machine Gun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_MACHINEPISTOL") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Machine Gun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Machine Gun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Machine Gun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
    elseif currentWeaponHash == GetHashKey("WEAPON_MG") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Machine Gun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_COMBATMG") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Machine Gun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_GUSENBERG") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Machine Gun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_MINISMG") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
    else
        TriggerEvent('DoLongHudText', 'This weapon is not compatible with this ammo!', 2)
        TriggerServerEvent('returnItem', item)
    end
end)

RegisterNetEvent('nfw_wep:arAmmo')
AddEventHandler('nfw_wep:arAmmo', function()
    local ped = GetPlayerPed(-1)
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    local ammo = GetAmmoInPedWeapon(ped, currentWeaponHash)
    local item = "arAmmo"

    if(ammo >= 250 or ammo + 50 > 250) then
        TriggerEvent('DoLongHudText', 'Your weapon ammo is already maxed!', 2)
        TriggerServerEvent('returnItem', item)
        return
    end

    if currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Assault Rifle ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Assault Rifle ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Assault Rifle ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_SNIPERRIFLE") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 10)
            TriggerEvent('DoLongHudText', 'Added 50 more Rifle ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Assault Rifle ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Assault Rifle ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_COMPACTRIFLE") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Assault Rifle ammo!', 1)
    else
        TriggerEvent('DoLongHudText', 'This weapon is not compatible with this ammo!', 2)
        TriggerServerEvent('returnItem', item)
    end
end)

RegisterNetEvent('nfw_wep:sgAmmo')
AddEventHandler('nfw_wep:sgAmmo', function()
    local ped = GetPlayerPed(-1)
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    local ammo = GetAmmoInPedWeapon(ped, currentWeaponHash)
    local item = "sgAmmo"

    if(ammo >= 250 or ammo + 50 > 250) then
        TriggerEvent('DoLongHudText', 'Your weapon ammo is already maxed!', 2)
        TriggerServerEvent('returnItem', item)
        return
    end

    if currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Shotgun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_SAWNOFFSHOTGUN") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Shotgun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_DBSHOTGUN") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Shotgun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Shotgun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Shotgun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_MUSKET") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Shotgun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Shotgun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_DOUBLEBARRELSHOTGUN") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Shotgun ammo!', 1)
    elseif currentWeaponHash == GetHashKey("WEAPON_AUTOSHOTGUN") then
        exports["irp-taskbar"]:taskBar(7500, "Reloading")
            AddAmmoToPed(ped, currentWeaponHash, 50)
            TriggerEvent('DoLongHudText', 'Added 50 more Shotgun ammo!', 1)
    else
        TriggerEvent('DoLongHudText', 'This weapon is not compatible with this ammo!', 2)
        TriggerServerEvent('returnItem', item)
    end
end)