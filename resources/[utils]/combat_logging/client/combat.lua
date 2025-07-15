RegisterNetEvent('combat:logHit', function(data)
    TriggerServerEvent('combat:handleHit', data)
end)
