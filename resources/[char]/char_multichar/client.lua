RegisterNetEvent('char_multichar:openUI', function(maxSlots, chars)
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'open', max = maxSlots, characters = chars })
end)

RegisterNUICallback('createCharacter', function(data, cb)
    SetNuiFocus(false, false)
    TriggerServerEvent('char_multichar:createCharacter', data)
    cb('ok')
end)

RegisterNUICallback('selectCharacter', function(charId, cb)
    -- Load selected character (implementation depends on your framework)
    SetNuiFocus(false, false)
    TriggerEvent('spawn_core:requestSpawn') -- simplistic; replace with real select
    cb('ok')
end)

-- Auto request on resource start
AddEventHandler('onClientResourceStart', function(res)
    if res == GetCurrentResourceName() then
        TriggerServerEvent('char_multichar:requestSlots')
    end
end)
