local function getCharacters(license)
    return exports.oxmysql:executeSync(
        'SELECT id, firstname, lastname, dob, gender FROM characters WHERE user_id = (SELECT id FROM users WHERE identifier = ?)',
        { license }
    )
end

RegisterNetEvent('char_multichar:requestSlots', function()
    local src = source
    local steam = GetPlayerIdentifierByType(src, 'steam')
    local license = GetPlayerIdentifierByType(src, 'license')

    local allow = Config.MultiCharAllowed[steam] == true
    local maxSlots = allow and Config.MaxCharacters or 1
    local chars = getCharacters(license)

    TriggerClientEvent('char_multichar:openUI', src, maxSlots, chars or {})
end)

RegisterNetEvent('char_multichar:createCharacter', function(data)
    local src = source
    local license = GetPlayerIdentifierByType(src, 'license')
    exports.oxmysql:execute(
        'INSERT INTO characters (user_id, firstname, lastname, dob, gender) VALUES ((SELECT id FROM users WHERE identifier = ?), ?, ?, ?, ?)',
        { license, data.firstname, data.lastname, data.dob, data.gender }
    )
    TriggerClientEvent('char_creator:start', src) -- reuse appearance creator
end)
