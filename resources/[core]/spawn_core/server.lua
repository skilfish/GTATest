RegisterNetEvent('spawn_core:updateLastPos', function(coords)
    local src = source
    local license = GetPlayerIdentifierByType(src, 'license')
    local jsonPos = json.encode({
        x = coords.x,
        y = coords.y,
        z = coords.z
    })

    exports.oxmysql:execute('UPDATE characters SET last_position = ? WHERE user_id = (SELECT id FROM users WHERE identifier = ?)', {
        jsonPos, license
    })
end)

AddEventHandler('playerDropped', function()
    local src = source
    local ped = GetPlayerPed(src)
    if ped and DoesEntityExist(ped) then
        local coords = GetEntityCoords(ped)
        TriggerEvent('spawn_core:updateLastPos', coords)
    end
end)

AddEventHandler('playerConnecting', function(_, _, deferrals)
    local src = source
    local license = GetPlayerIdentifierByType(src, 'license')
    deferrals.defer()
    Wait(0)

    exports.oxmysql:execute('SELECT last_position FROM characters WHERE user_id = (SELECT id FROM users WHERE identifier = ?)', {license}, function(result)
        if result and result[1] and result[1].last_position then
            local pos = json.decode(result[1].last_position)
            -- Sicherheitsprüfung: Verhindere Bug-Spawns
            if pos and type(pos.x) == "number" and type(pos.y) == "number" and type(pos.z) == "number" and pos.z > 0 then
                TriggerClientEvent('spawn_core:spawnAtLastPosition', src, pos)
            else
                TriggerClientEvent('char_creator:start', src)
            end
        else
            TriggerClientEvent('char_creator:start', src)
        end
        deferrals.done()
    end)
end)
