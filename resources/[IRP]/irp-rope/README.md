# irp-handcuffs
# Example of implementation (irp-policejob)

Client
```
    if data2.current.value == 'handcuff' then
      TriggerServerEvent('irp-policejob:handcuff', GetPlayerServerId(player))
    end

    if data2.current.value == 'unhandcuff' then
      TriggerServerEvent('irp-policejob:unhandcuff', GetPlayerServerId(player))
    end
 ```
 
Server
 ```
    RegisterServerEvent('irp-policejob:handcuff')
    AddEventHandler('irp-policejob:handcuff', function(source)
      TriggerClientEvent('irp-handcuffs:cuff', source)
    end)

    RegisterServerEvent('irp-policejob:unhandcuff')
    AddEventHandler('irp-policejob:unhandcuff', function(source)
     TriggerClientEvent('irp-handcuffs:uncuff', source)
    end)
```

# Based on:
# https://github.com/TomGrobbe/Realistic-Handcuffs-FiveM
