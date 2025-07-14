local isFirstSpawn = true

RegisterNetEvent('spawn_core:spawnPlayer', function(position)
    if Config.EnableSpawnFade then
        DoScreenFadeOut(500)
        Wait(1000)
    end

    FreezeEntityPosition(PlayerPedId(), true)

    SetEntityCoords(PlayerPedId(), position.x, position.y, position.z, false, false, false, true)
    SetEntityHeading(PlayerPedId(), position.w)

    if Config.EnableLoginFreeze then
        Wait(2000)
        FreezeEntityPosition(PlayerPedId(), false)
    end

    if Config.EnableSpawnFade then
        DoScreenFadeIn(1000)
    end

    TriggerEvent('spawn_core:onSpawnReady')
end)
