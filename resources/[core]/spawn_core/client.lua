local lastSavedCoords = nil

CreateThread(function()
    while true do
        Wait(10000)

        local ped = PlayerPedId()
        if ped and DoesEntityExist(ped) then
            local coords = GetEntityCoords(ped)
            if not lastSavedCoords or #(coords - lastSavedCoords) > 1.0 then
                lastSavedCoords = coords
                TriggerServerEvent('spawn_core:updateLastPos', coords)
            end
        end
    end
end)

RegisterNetEvent('spawn_core:spawnAtLastPosition', function(pos)
    DoScreenFadeOut(500)
    Wait(500)
    SetEntityCoordsNoOffset(PlayerPedId(), pos.x, pos.y, pos.z, false, false, false)
    DoScreenFadeIn(500)
end)
