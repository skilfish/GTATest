RegisterNetEvent("skyline_core:saveArmor")
AddEventHandler("skyline_core:saveArmor", function(armor)
    local xPlayer = SKYLINE.GetPlayerFromId(source)

    MySQL.Async.execute("UPDATE users SET armor = @armor WHERE identifier = @license",
  { ["@armor"] = armor, ["@license"] = xPlayer.getIdentifier()},
  function(affectedRows)end
    )

end)

SKYLINE.RegisterServerCallback("skyline_core:getArmor", function(playerId , cb)
    local xPlayer = SKYLINE.GetPlayerFromId(playerId)

    MySQL.Async.fetchScalar("SELECT armor FROM users WHERE identifier = @license", {["@license"] = xPlayer.getIdentifier()}, function(result)
        if result ~= nil then 
            cb(result)
        else 
            cb(0)
        end 
    end)
end)


RegisterNetEvent("skyline_core:saveHealth")
AddEventHandler("skyline_core:saveHealth", function(health)
    local xPlayer = SKYLINE.GetPlayerFromId(source)

    MySQL.Async.execute("UPDATE users SET health = @health WHERE identifier = @license",
  { ["@health"] = health, ["@license"] = xPlayer.getIdentifier()},
  function(affectedRows)end
    )

end)

SKYLINE.RegisterServerCallback("skyline_core:getHealth", function(playerId , cb)
    local xPlayer = SKYLINE.GetPlayerFromId(playerId)

    MySQL.Async.fetchScalar("SELECT health FROM users WHERE identifier = @license", {["@license"] = xPlayer.getIdentifier()}, function(result)
        if result ~= nil then 
            cb(result)
        else 
            cb(200)
        end 
    end)
end)


-- lastpos 

SKYLINE.RegisterServerCallback("skyline_lastpos:needInit", function(playerId , cb)
    local xPlayer = SKYLINE.GetPlayerFromId(playerId)

    result = MySQL.Sync.fetchScalar("SELECT lastPos FROM lastpos WHERE license = '" .. xPlayer.getIdentifier() .. "' ")

    if result == nil then 
        MySQL.Sync.execute('INSERT INTO lastpos (license,lastPos) VALUES (@identifier, @lastPos)', {
            ['@identifier'] = xPlayer.getIdentifier(),
            ['@lastPos'] = "{x = 0.0 , y = 0.0 , z = 0.0}"
        }, function (rowsChanged)
        end)

        cb(true)
    end 

end)


RegisterNetEvent("skyline_lastpos:save")
AddEventHandler("skyline_lastpos:save", function(coords)
    local xPlayer = SKYLINE.GetPlayerFromId(source)

    coords_s = json.encode(coords)

    if coords ~= nil then 
        MySQL.Sync.execute("UPDATE lastpos SET lastPos = '" .. coords_s .. "' WHERE license = '" .. xPlayer.getIdentifier() .. "'")


    end 

end)


SKYLINE.RegisterServerCallback("skyline_lastpos:getLastPos", function(playerId , cb)
    xPlayer = SKYLINE.GetPlayerFromId(playerId)

    result = MySQL.Sync.fetchScalar("SELECT lastPos FROM lastpos WHERE license = '" .. xPlayer.getIdentifier() .. "' ")
    
    cb(result)
 end)