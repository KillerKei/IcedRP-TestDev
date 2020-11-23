-- Settings
local guiEnabled = false
local hasOpened = false
local serverNotes = {
  
}
irpCore = nil

Citizen.CreateThread(function()
	while irpCore == nil do
		TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj end)
		Citizen.Wait(0)
	end
end)

-- Open Gui and Focus NUI
function openGui()
  SetPlayerControl(PlayerId(), 0, 0)
  guiEnabled = true
  SetNuiFocus(true)
  Citizen.Trace("OPENING")
  SendNUIMessage({openSection = "openNotepad"})

  local inveh = IsPedSittingInAnyVehicle(PlayerPedId())

  TriggerEvent("notepad")

end

function openGuiRead(text)
  SetPlayerControl(PlayerId(), 0, 0)
  guiEnabled = true
  SetNuiFocus(true)
  Citizen.Trace("OPENING")
  SendNUIMessage({openSection = "openNotepadRead", TextRead = text})


end

-- Close Gui and disable NUI
function closeGui()
  guiEnabled = false
  ped = PlayerPedId();
  ClearPedTasks(ped);
  Citizen.Trace("CLOSING")
  SetNuiFocus(false)
  SendNUIMessage({openSection = "close"})
  SetPlayerControl(PlayerId(), 1, 0)
end

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)
local plate="testicle"
local vehicleDefaultTable = {
  ["penis"..plate] = {
  ["fInitialDriveForce"] = 1.50000, 
  ["fClutchChangeRateScaleUpShift"] = 1.50000,
  ["fClutchChangeRateScaleDownShift"] = 1.50000,
  ["fBrakeBiasFront"] = 1.50000,
  ["fDriveBiasFront"] = 1.50000,
  }
}

local vehicleTable = {
  ["penis"..plate] = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 5,
    [5] = 5
  }
}

function doBoostFuel(amount,amount2,veh,plate)
    local amount = amount
    if amount == 0 then
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', vehicleDefaultTable["penis"..plate]["fInitialDriveForce"])
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult', vehicleDefaultTable["penis"..plate]["fLowSpeedTractionLossMult"])
    else
      local defaultBoost = vehicleDefaultTable["penis"..plate]["fInitialDriveForce"]
      local defaultTLoss = vehicleDefaultTable["penis"..plate]["fLowSpeedTractionLossMult"]
      local new = defaultBoost + defaultBoost * (amount/200)
      local new2 = defaultTLoss + defaultTLoss * (amount/20)
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', new)
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult', new2)
    end





    if amount2 == 0 and amount == 0 then

      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveInertia', vehicleDefaultTable["penis"..plate]["fDriveInertia"])
    else
      local defaultBoost = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
      local defaultfDriveInertia = vehicleDefaultTable["penis"..plate]["fDriveInertia"]
      local new = defaultBoost + defaultBoost * (amount2/200)

      local new2 = defaultfDriveInertia - defaultfDriveInertia * (amount2/30)
      if new2 < 0.5 then
        new2 = 0.5
      end
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', new)
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveInertia', new2)
    end

end

function doGears(amount,veh,plate)

    if amount == 0 then
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fClutchChangeRateScaleUpShift', vehicleDefaultTable["penis"..plate]["fClutchChangeRateScaleUpShift"])
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fClutchChangeRateScaleDownShift', vehicleDefaultTable["penis"..plate]["fClutchChangeRateScaleDownShift"])
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDragCoeff', vehicleDefaultTable["penis"..plate]["fInitialDragCoeff"])
    else
      local defaultShift = vehicleDefaultTable["penis"..plate]["fClutchChangeRateScaleUpShift"]
      local defaultShift2 = vehicleDefaultTable["penis"..plate]["fClutchChangeRateScaleUpShift"]
      local fInitialDragCoeff = vehicleDefaultTable["penis"..plate]["fInitialDragCoeff"]
      local new = defaultShift + amount
      local new2 = defaultShift2 + amount
      local new3 = fInitialDragCoeff + (amount/50)
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fClutchChangeRateScaleUpShift', new)
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fClutchChangeRateScaleDownShift', new2)
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDragCoeff', new3)
    end
end

function doBraking(amount,veh,plate)
    if amount == 5 then
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeBiasFront', vehicleDefaultTable["penis"..plate]["fBrakeBiasFront"])
    else
      local defaultBrakeBias = vehicleDefaultTable["penis"..plate]["fBrakeBiasFront"]
      local new = (amount/10)
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeBiasFront', new)
    end
end

function doDrive(amount,veh,plate)
    if amount == 5 then
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveBiasFront', vehicleDefaultTable["penis"..plate]["fDriveBiasFront"])
    else
      local defaultBrakeBias = vehicleDefaultTable["penis"..plate]["fDriveBiasFront"]
      local new = (amount/10)
      SetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveBiasFront', new)
    end
end


function modify(boost,fuel,gears,braking,drive,veh,plate)
    doBoostFuel(boost,fuel,veh,plate)
    doGears(gears,veh,plate)
    doBraking(braking,veh,plate)
    doDrive(drive,veh,plate)

    TriggerEvent('DoLongHudText', 'Tune Set', 1)
end

RegisterNetEvent('tuner:setNew')
AddEventHandler('tuner:setNew', function(defaultTable,newTable)
  vehicleDefaultTable = defaultTable
  vehicleTable = newTable
end)


RegisterNetEvent('tuner:setDriver')
AddEventHandler('tuner:setDriver', function()
    local veh = GetVehiclePedIsUsing(PlayerPedId())  
    if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
      local plate = GetVehicleNumberPlateText(veh)
      if vehicleTable["penis"..plate] then
        Wait(1000)
        local df = vehicleTable["penis"..plate][1]
        local gr1 = vehicleTable["penis"..plate][2]
        local gr2 = vehicleTable["penis"..plate][3]
        local bb = vehicleTable["penis"..plate][4]
        local db = vehicleTable["penis"..plate][5]
        modify(df,gr1,gr2,bb,db,veh,plate)
      end
    end
end)






RegisterNetEvent('tuner:open')
AddEventHandler('tuner:open', function()

    
    Wait(1000)
    exports["irp-taskbar"]:taskBar(7000, "Connecting Tuner Laptop") 
      local veh = GetVehiclePedIsUsing(PlayerPedId())  
      if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
        local plate = GetVehicleNumberPlateText(veh)

        if vehicleTable["penis"..plate] then
        else
          vehicleDefaultTable["penis"..plate] = {
            ["fInitialDriveForce"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce'), 
            ["fClutchChangeRateScaleUpShift"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fClutchChangeRateScaleUpShift'),
            ["fClutchChangeRateScaleDownShift"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fClutchChangeRateScaleDownShift'),
            ["fBrakeBiasFront"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeBiasFront'),
            ["fDriveBiasFront"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveBiasFront'),
            ["nInitialDriveIntertia"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'nInitialDriveIntertia'),
            ["fMass"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fMass'),
            ["fInitialDragCoeff"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDragCoeff'),
            ["fBrakeForce"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce'),
            ["fLowSpeedTractionLossMult"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult'),
            ["fDriveInertia"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveInertia'),

          } 
          vehicleTable["penis"..plate] = {
            [1] = 0,
            [2] = 0,
            [3] = 0,
            [4] = 5,
            [5] = 5
          }

        end

        local df = vehicleTable["penis"..plate][1]
        local gr1 = vehicleTable["penis"..plate][2]
        local gr2 = vehicleTable["penis"..plate][3]
        local bb = vehicleTable["penis"..plate][4]
        local db = vehicleTable["penis"..plate][5]


        openGui(df,gr1,gr2,bb,db)

        guiEnabled = true
      end
end)


RegisterNUICallback('tuneSystem', function(data, cb)
  closeGui()
  local boost = data.boost
  local fuel = data.fuel
  local gears = data.gears
  local braking = data.braking
  local drive = data.drive

  local veh = GetVehiclePedIsUsing(PlayerPedId())  
  if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
    local plate = GetVehicleNumberPlateText(veh)
    vehicleTable["penis"..plate][1] = boost
    vehicleTable["penis"..plate][2] = fuel
    vehicleTable["penis"..plate][3] = gears
    vehicleTable["penis"..plate][4] = braking
    vehicleTable["penis"..plate][5] = drive

    modify(boost,fuel,gears,braking,drive,veh,plate)
  end
  -- submit here
  --cb('ok')
end)


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
