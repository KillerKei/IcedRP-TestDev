local healing = false

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

RegisterNetEvent("irp-hospital:items:gauze")
AddEventHandler("irp-hospital:items:gauze", function(item)
    loadAnimDict("missheistdockssetup1clipboard@idle_a")
    TaskPlayAnim( PlayerPedId(), "missheistdockssetup1clipboard@idle_a", "idle_a", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
    exports["irp-taskbar"]:taskBar(1500, "Packing Wounds")
        TriggerEvent('irp-hospital:client:FieldTreatBleed')
        ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("irp-hospital:items:bandage")
AddEventHandler("irp-hospital:items:bandage", function(item)
    HealSlow()
end)

RegisterNetEvent("irp-hospital:items:firstaid")
AddEventHandler("irp-hospital:items:firstaid", function(item)
    loadAnimDict("missheistdockssetup1clipboard@idle_a")
    TaskPlayAnim( PlayerPedId(), "missheistdockssetup1clipboard@idle_a", "idle_a", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
    exports["irp-taskbar"]:taskBar(10000, "Using First Aid")
        local maxHealth = GetEntityMaxHealth(PlayerPedId())
		local health = GetEntityHealth(PlayerPedId())
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
        SetEntityHealth(PlayerPedId(), newHealth)
        TriggerEvent('irp-hospital:client:RemoveBleed')
        ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("irp-hospital:items:medkit")
AddEventHandler("irp-hospital:items:medkit", function(item)
    loadAnimDict("missheistdockssetup1clipboard@idle_a")
    TaskPlayAnim( PlayerPedId(), "missheistdockssetup1clipboard@idle_a", "idle_a", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
    exports["irp-taskbar"]:taskBar(20000, "Using Medkit")
        SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
        TriggerEvent('irp-hospital:client:FieldTreatLimbs')
        ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("irp-hospital:items:vicodin")
AddEventHandler("irp-hospital:items:vicodin", function(item)
    local maxHealth = GetEntityMaxHealth(PlayerPedId())
    local health = GetEntityHealth(PlayerPedId())
    local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 15))
    loadAnimDict("mp_suicide")
    TaskPlayAnim( PlayerPedId(), "mp_suicide", "pill", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
    exports["irp-taskbar"]:taskBar(1000, "Taking Oxycodone")
        SetEntityHealth(PlayerPedId(), newHealth)
        TriggerEvent('irp-hospital:client:RemoveBleed')
        TriggerEvent('irp-hospital:client:UsePainKiller', 6)
        ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("irp-hospital:items:ifak")
AddEventHandler("irp-hospital:items:ifak", function(item)
    loadAnimDict("missheistdockssetup1clipboard@idle_a")
    TaskPlayAnim( PlayerPedId(), "missheistdockssetup1clipboard@idle_a", "idle_a", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
    exports["irp-taskbar"]:taskBar(3500, "Using IFAK")
        local maxHealth = GetEntityMaxHealth(PlayerPedId())
		local health = GetEntityHealth(PlayerPedId())
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 30))
        SetEntityHealth(PlayerPedId(), newHealth)
        TriggerEvent('irp-hospital:client:RemoveBleed')
        ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("irp-hospital:items:hydrocodone")
AddEventHandler("irp-hospital:items:hydrocodone", function(item)
    loadAnimDict("mp_suicide")
    TaskPlayAnim( PlayerPedId(), "mp_suicide", "pill", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
    exports["irp-taskbar"]:taskBar(1000, "Taking Hydrocodone")
        TriggerEvent('irp-hospital:client:UsePainKiller', 2)
        ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("irp-hospital:items:morphine")
AddEventHandler("irp-hospital:items:morphine", function(item)
    loadAnimDict("mp_suicide")
    TaskPlayAnim( PlayerPedId(), "mp_suicide", "pill", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
    exports["irp-taskbar"]:taskBar(2000, "Taking Morphine")
        TriggerEvent('irp-hospital:client:UsePainKiller', 6)
        ClearPedTasks(PlayerPedId())
end)

function HealSlow()
    if not healing then
        healing = true
    else
        return
    end
    
    local count = 30
    while count > 0 do
        Citizen.Wait(1000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
        TriggerEvent('irp-hospital:client:RemoveBleed') 
    end
    healing = false
end