RegisterNetEvent('char_creator:saveCharacter', function(data)
    local src = source
    local license = GetPlayerIdentifierByType(src, 'license')
    local q = [[INSERT INTO characters (user_id, firstname, lastname, dob, gender) VALUES (
        (SELECT id FROM users WHERE identifier = ?),
        ?, ?, ?, ?
    )]]

    exports.oxmysql:execute(q, {license, data.firstname, data.lastname, data.dob, data.gender})
    SetPlayerRoutingBucket(src, 0)
    TriggerClientEvent('spawn_core:requestSpawn', src)
end)

AddEventHandler('playerConnecting', function(_, _, deferrals)
    local src = source
    local license = GetPlayerIdentifierByType(src, 'license')
    deferrals.defer()
    Wait(0)

    exports.oxmysql:execute('SELECT * FROM characters WHERE user_id = (SELECT id FROM users WHERE identifier = ?)', {license}, function(result)
        if result and result[1] then
            TriggerClientEvent('spawn_core:requestSpawn', src)
        else
            SetPlayerRoutingBucket(src, 1000 + src)
            TriggerClientEvent('char_creator:start', src)
        end
        deferrals.done()
    end)
end)
