lockpicking = {}
TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj; end)

Citizen.CreateThread(function(...)
  while not irpCore do
    TriggerEvent('irp:getSharedObject', function(obj) irpCore = obj; end)
    Citizen.Wait(0)
  end
end)

lockpicking.Version = '1.0.11'

lockpicking.LockTolerance = 6.0
lockpicking.UsingLockpickItem = true
lockpicking.TextureDict = "lockpicking"
lockpicking.AudioBank = "SAFE_CRACK"