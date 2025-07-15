local oxmysql = exports.oxmysql

RegisterServerEvent("char_creator:saveCharacter")
AddEventHandler("char_creator:saveCharacter", function(data)
    local src = source
    local license = GetPlayerIdentifierByType(src, "license")

    oxmysql:query("SELECT id FROM players WHERE identifier = ?", {license}, function(result)
        local user_id
        if result[1] then
            user_id = result[1].id
        else
            oxmysql:insert("INSERT INTO players (identifier) VALUES (?)", {license}, function(insertId)
                user_id = insertId
            end)
        end

        Wait(200)

        oxmysql:insert([[
            INSERT INTO characters (user_id, firstName, lastName, fullName, gender, dateOfBirth, x, y, z, heading)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ]], {
            user_id, data.firstName, data.lastName, data.fullName, data.gender, data.dob,
            data.coords.x, data.coords.y, data.coords.z, data.coords.heading
        })
    end)
end)