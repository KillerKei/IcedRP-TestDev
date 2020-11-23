irpCore = nil

 Citizen.CreateThread(function()
  while irpCore == nil do
      TriggerEvent('irp:getSharedObject', function(obj)
          irpCore = obj
      end)
      Citizen.Wait(0)
  end

end)

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
local busy = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        while busy do
            Citizen.Wait(0)
        end
        local plyPed = PlayerPedId()
        local distance = GetDistanceBetweenCoords(GetEntityCoords(plyPed, true), 1764.16, 2476.422, 45.53553, true)
        --First Search Loc (Spoon)
        if distance < 2.5 then
            DrawText3Ds(1764.16, 2476.422, 45.53553, "[G] - Search")
            if distance < 1 then
                if IsControlJustPressed(0, Keys["G"]) then
                    FreezeEntityPosition(plyPed, true)
                    TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
                    busy = true
                    exports["irp-taskbar"]:taskBar(5000, "Searching")
                        local finished = exports["irp-taskbarskill"]:taskBar(2000,math.random(5,8))
                        if finished ~= 100 then
                            FreezeEntityPosition(plyPed, false)
                            ClearPedTasks(plyPed)
                            busy = false
                            return
                        end
                        if finished == 100 then
                            local finished2 = exports["irp-taskbarskill"]:taskBar(1500,math.random(4,7))
                            if finished2 ~= 100 then
                                FreezeEntityPosition(plyPed, false)
                                ClearPedTasks(plyPed)
                                busy = false
                                return
                            end
                            if finished2 == 100 then
                                local finished3 = exports["irp-taskbarskill"]:taskBar(1000,math.random(3,5))
                                if finished3 ~= 100 then
                                    FreezeEntityPosition(plyPed, false)
                                    ClearPedTasks(plyPed)
                                    busy = false
                                    return
                                end
                                if finished3 == 100 then
                                    TriggerServerEvent('irp-jailbreak:GiveSpoon')
                                    FreezeEntityPosition(plyPed, false)
                                    ClearPedTasks(plyPed)
                                    busy = false
                                end
                            end
                        end
                end
            end
        end
        --2nd Search Loc
        local distance2 = GetDistanceBetweenCoords(GetEntityCoords(plyPed, true), 1756.354, 2475.406, 45.59897, true)
        if distance2 < 2.5 then
            DrawText3Ds( 1756.354, 2475.406, 45.59897, "[G] - Search")
            if distance2 < 1 then
                if IsControlJustPressed(0, Keys["G"]) then
                    irpCore.TriggerServerCallback('irp-jailbreak:CheckItem', function(result)
                        if result then
                            FreezeEntityPosition(plyPed, true)
                            TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
                            busy = true
                            exports["irp-taskbar"]:taskBar(5000, "Searching")
                                TriggerServerEvent('irp-jailbreak:searchItem')
                                FreezeEntityPosition(plyPed, false)
                                ClearPedTasks(plyPed)
                                busy = false
                            else
                            TriggerEvent('DoLongHudText', 'Missing Materials', 2)
                        end
                    end)
                end
            end
        end
        --3rd Search Loc
        local distance3 = GetDistanceBetweenCoords(GetEntityCoords(plyPed, true), 1768.964, 2494.139, 45.599, true)
        if distance3 < 2.5 then
            DrawText3Ds(1768.964, 2494.139, 45.599, "[G] - Search")
            if distance3 < 1 then
                if IsControlJustPressed(0, Keys["G"]) then
                    irpCore.TriggerServerCallback('irp-jailbreak:CheckItem', function(result)
                        if result then
                            FreezeEntityPosition(plyPed, true)
                            TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
                            busy = true
                            exports["irp-taskbar"]:taskBar(5000, "Searching")
                                TriggerServerEvent('irp-jailbreak:searchItem')
                                FreezeEntityPosition(plyPed, false)
                                ClearPedTasks(plyPed)
                                busy = false
                            else
                                TriggerEvent('DoLongHudText', 'Missing Materials', 2)
                        end
                    end)
                end
            end
        end
        --4th Search Loc
        local distance4 = GetDistanceBetweenCoords(GetEntityCoords(plyPed, true), 1760.712, 2519.051, 45.56498, true)
        if distance4 < 2.5 then
            DrawText3Ds(1760.712, 2519.051, 45.56498, "[G] - Repairing?")
            if distance4 < 1 then
                if IsControlJustPressed(0, Keys["G"]) then
                    irpCore.TriggerServerCallback('irp-jailbreak:CheckItem', function(result)
                        if result then
                            FreezeEntityPosition(plyPed, true)
                            TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
                            busy = true
                            exports["irp-taskbar"]:taskBar(5000, "Searching")
                                TriggerServerEvent('irp-jailbreak:searchItem')
                                FreezeEntityPosition(plyPed, false)
                                ClearPedTasks(plyPed)
                                busy = false
                            else
                                TriggerEvent('DoLongHudText', 'Missing Materials', 2)
                        end
                    end)
                end
            end
        end
        --5th Search Loc
        local distance5 = GetDistanceBetweenCoords(GetEntityCoords(plyPed, true), 1663.557, 2514.429, 45.5649, true)
        if distance5 < 2.5 then
            DrawText3Ds(1663.557, 2514.429, 45.5649, "[G] - Clean Up?")
            if distance5 < 1 then
                if IsControlJustPressed(0, Keys["G"]) then
                    irpCore.TriggerServerCallback('irp-jailbreak:CheckItem', function(result)
                        if result then
                            FreezeEntityPosition(plyPed, true)
                            TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
                            busy = true
                            exports["irp-taskbar"]:taskBar(5000, "Searching")
                                TriggerServerEvent('irp-jailbreak:searchItem')
                                FreezeEntityPosition(plyPed, false)
                                ClearPedTasks(plyPed)
                                busy = false
                            else
                                TriggerEvent('DoLongHudText', 'Missing Materials', 2)
                        end
                    end)
                end
            end
        end
        --6th Search Loc
        local distance6 = GetDistanceBetweenCoords(GetEntityCoords(plyPed, true), 1629.977, 2564.353, 45.56486, true)
        if distance6 < 2.5 then
            DrawText3Ds(1629.977, 2564.353, 45.56486, "[G] - Repairing?")
            if distance6 < 1 then
                if IsControlJustPressed(0, Keys["G"]) then
                    irpCore.TriggerServerCallback('irp-jailbreak:CheckItem', function(result)
                        if result then
                            FreezeEntityPosition(plyPed, true)
                            TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
                            busy = true
                            exports["irp-taskbar"]:taskBar(5000, "Searching")
                                TriggerServerEvent('irp-jailbreak:searchItem')
                                FreezeEntityPosition(plyPed, false)
                                ClearPedTasks(plyPed)
                                busy = false
                            else
                                TriggerEvent('DoLongHudText', 'Missing Materials', 2)
                        end
                    end)
                end
            end
        end
        --Open All Cells
        local distance7 = GetDistanceBetweenCoords(GetEntityCoords(plyPed, true), 1757.526, 2473.554, 49.58722, true)
        if distance7 < 1 then
            DrawText3Ds(1757.526, 2473.554, 49.58722, "[G] - Unlock All Cells")
            if distance7 < 1 then
                if IsControlJustPressed(0, Keys["G"]) then
                    irpCore.TriggerServerCallback('irp-jailbreak:CheckItem2', function(result)
                        if result then
                            LoadAnim("mp_prison_break")
                            FreezeEntityPosition(plyPed, true)
                            TaskPlayAnim(plyPed, "mp_prison_break", "hack_loop", 2.0, 2.0, -1, 51, 0, false, false, false)
                            busy = true
                            exports["irp-taskbar"]:taskBar(15000, "Accessing System")
                                TriggerEvent('irp-dispatch:jailbreak')
                                TriggerEvent('irp-jailbreak:UnlockAll')
                                FreezeEntityPosition(plyPed, false)
                                ClearPedTasks(plyPed)
                                TriggerEvent('DoLongHudText', 'All cells unlocked', 1)
                                TriggerEvent("irp-jailbreak:UpdateTime")
                                TriggerEvent('DoLongHudText', 'Jail Time reduced to 0', 1)
                                TriggerEvent('DoLongHudText', 'All doors will be unlock in 5 minutes!', 2)
                                busy = false
                            else
                                TriggerEvent('DoLongHudText', 'Missing Materials', 2)
                        end
                    end)
                end
            end
        end
    end
end)

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end