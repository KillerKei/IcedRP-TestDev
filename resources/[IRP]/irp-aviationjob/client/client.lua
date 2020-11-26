-- Globalisation for Framework --
irpCore = nil

Citizen.CreateThread(function()
	while irpCore == nil do
		TriggerEvent("irp:getSharedObject", function(obj) irpCore = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("irp:playerLoaded")
AddEventHandler("irp:playerLoaded", function(xPlayer)
	irpCore.PlayerData = xPlayer
end)

RegisterNetEvent("irp:setJob")
AddEventHandler("irp:setJob", function(job)
	irpCore.PlayerData.job = job
end)
-- End of Globalisation --
doingactiverun = false
cooldown = false
local timer = 0


function LoadMarkers()


    LoadModel('titan') -- plane used for export
    LoadModel('cargobob') -- helicopter
    LoadAnimDict('missheistdockssetup1clipboard@base')

end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        local Getmecuh = PlayerPedId()
        local x,y,z = -231.3556, 6234.774, 31.4959
        local drawtext = "[~g~E~s~] Order Stolen Vehicle [~g~$2000~s~]"
        local plyCoords = GetEntityCoords(Getmecuh)
        local distance = GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z,x,y,z,false)
        if distance <= 0.8 then
            DrawText3Ds(x,y,z, drawtext) 
            if IsControlJustReleased(0, 38) then
                TriggerServerEvent('irp-cartheft:checkcooldown',timer)
                if timer < 1 then
                    TriggerEvent('irp-cartheft:task1')
                    Citizen.Wait(2400000) -- CD 
                end
            end
        end
    end
end)

RegisterNetEvent('irp-cartheft:task1')
AddEventHandler('irp-cartheft:task1', function()
    loadAnimDict( "missheistdockssetup1clipboard@base" )
    TaskPlayAnim( PlayerPedId(), "missheistdockssetup1clipboard@base", "base", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(5)
    exports["irp-taskbar"]:taskBar(5000,"Searching For an order..")
    Citizen.Wait(10)
    exports["irp-taskbar"]:taskBar(2000,"Vehicle Found..")
    Citizen.Wait(10)
    exports["irp-taskbar"]:taskBar(5000,"Locating Vehicle..")
    Citizen.Wait(10)
    doingactiverun = true
    exports["irp-taskbar"]:taskBar(2000,"Vehicle Located..")
    Citizen.Wait(10)
    ClearPedTasksImmediately(PlayerPedId())
    Citizen.Wait(10)
    TriggerServerEvent('irp-cartheft:price')
    Citizen.Wait(100)
    TriggerEvent('DoLongHudText', 'Head to the GPS Located on your map.')
    SetNewWaypoint(1732.425, 3314.708)
end)


function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent('irp-cartheft:spawnveh')
AddEventHandler('irp-cartheft:spawnveh', function()
    irpCore.Game.SpawnVehicle('sultan', vector3( -229.0029, 6251.22, 31.48927), 169.79, function(vehicle)
    HuntCar = vehicle
    local plate = GetVehicleNumberPlateText(HuntCar)
    TriggerServerEvent('garage:addKeys', plate)
    TaskWarpPedIntoVehicle(PlayerPedId() , HuntCar, -1)
    end)
end)

RegisterNetEvent('irp-cartheft:spawnveh3')
AddEventHandler('irp-cartheft:spawnveh3', function()
    irpCore.Game.SpawnVehicle('tug', vector3( 1316.715, -3276.565, 5.803882), 350.79, function(vehicle)
    Boat = vehicle
    local plate = GetVehicleNumberPlateText(Boat)
    TriggerServerEvent('garage:addKeys', plate)
    TaskWarpPedIntoVehicle(PlayerPedId() , Boat, -1)
    end)
end)


RegisterNetEvent('irp-cartheft:spawnveh2')
AddEventHandler('irp-cartheft:spawnveh2', function()
    local car = math.random(1,4)

    if car == 1 then
        spawncar = 'adder'
    end
    if car == 2 then
        spawncar = 'reaper'
    end
    if car == 3 then
        spawncar = 'jester2'
    end
    if car == 4 then
        spawncar = 'entityxf'
    end
    irpCore.Game.SpawnVehicle(spawncar, vector3( 1732.425, 3314.708, 41.22347), 169.79, function(vehicle)
        Richcar = vehicle
        local plate = GetVehicleNumberPlateText(Richcar)
        TriggerServerEvent('garage:addKeys', plate)
        local x,y,z = 1242.786, -3263.058, 5.532083
        TriggerEvent("DoLongHudText","Please wait whilst we update your GPS!",1)
        Citizen.Wait(25000)
        TriggerEvent("DoLongHudText","Drive to the Marker on your GPS!",1)
        SetNewWaypoint(1242.786, -3263.058)
    end)
end)