RegisterNetEvent('combat:playerHit')
AddEventHandler('combat:playerHit', function(data)
    TriggerServerEvent('combat:logHit', data)
end)

RegisterNetEvent('combat:playerKilled')
AddEventHandler('combat:playerKilled', function(data)
    TriggerServerEvent('combat:logKill', data)
end)
