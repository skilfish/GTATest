SKYLINE = nil

local wb = "https://discord.com/api/webhooks/989066396442984478/B1V3-sDz5cKGi8k8GsmpK4N94h1kucZhEYP_bqyBt_ytpadSFIz8gfHqdmHCljMaj8rz"

isInSupportMode = {}

function getDCId(source) 
    local discord = ""
    local id = ""
    
identifiers = GetNumPlayerIdentifiers(source)
for i = 0, identifiers + 1 do
    if GetPlayerIdentifier(source, i) ~= nil then
        if string.match(GetPlayerIdentifier(source, i), "discord") then
            discord = GetPlayerIdentifier(source, i)
            id = string.sub(discord, 9, -1)
        end
    end
end

return id

end 

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj  end)

SKYLINE.RegisterServerCallback("skyline_admin:rangcheck", function(source, cb)
    local player = SKYLINE.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)


RegisterNetEvent("skyline_admin:sendOOCMSG")
AddEventHandler("skyline_admin:sendOOCMSG", function(id , msg)
    local xTarget = SKYLINE.GetPlayerFromId(id)
    xTarget.triggerEvent("skyline_notify:Alert", "OOC", msg , 4000 , "success")
end)

SKYLINE.RegisterServerCallback("skyline_admin:updateCar", function(source, cb ,props)
    local player = SKYLINE.GetPlayerFromId(source)

    if player.getGroup() == "pl" then 
        MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle = '" .. json.encode(props) .. "' WHERE plate = '" .. props["plate"] .. "'")
    end 

    cb("a")
 end)

RegisterNetEvent("skyline_admin:noclip")
AddEventHandler("skyline_admin:noclip", function(val)
    local xPlayer = SKYLINE.GetPlayerFromId(source)

    if not val then
        local msg = {
            {
                ["color"] = "2123412",
                ["title"] = "NoClip",
                ["description"] = "**" .. GetPlayerName(source) .. "** hat den NoClip **aktiviert**. \n \n Lizenz: " .. xPlayer.getIdentifier() .. " \n Discord: <@" .. getDCId(xPlayer.source) .. ">",
                ["footer"] = {
                    ["text"] = "Copyright © Jucktnicht 2022",
                    ["icon_url"] = "",
                },
            }
        }
    
        PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })
    else 
        local msg = {
            {
                ["color"] = "2123412",
                ["title"] = "NoClip",
                ["description"] = "**" .. GetPlayerName(source) .. "** hat den NoClip **deaktiviert**. \n \n Lizenz: " .. xPlayer.getIdentifier() .. "\n Discord: <@" .. getDCId(xPlayer.source) .. ">",
                ["footer"] = {
                    ["text"] = "Copyright © Jucktnicht 2022",
                    ["icon_url"] = "",
                },
            }
        }
    
        PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' }) 
    end
end)

RegisterNetEvent("skyline_admin:nametags")
AddEventHandler("skyline_admin:nametags", function(val)
    local xPlayer = SKYLINE.GetPlayerFromId(source)

    if not val then
        local msg = {
            {
                ["color"] = "2123412",
                ["title"] = "Nametags",
                ["description"] = "**" .. GetPlayerName(source) .. "** hat die Nametags **aktiviert**. \n \n Lizenz: " .. xPlayer.getIdentifier() .. " \n Discord: <@" .. getDCId(xPlayer.source) .. ">",
                ["footer"] = {
                    ["text"] = "Copyright © Jucktnicht 2022",
                    ["icon_url"] = "",
                },
            }
        }
    
        PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })
    else 
        local msg = {
            {
                ["color"] = "2123412",
                ["title"] = "NoClip",
                ["description"] = "**" .. GetPlayerName(source) .. "** hat die Nametags **deaktiviert**. \n \n Lizenz: " .. xPlayer.getIdentifier() .. "\n Discord: <@" .. getDCId(xPlayer.source) .. ">",
                ["footer"] = {
                    ["text"] = "Copyright © Jucktnicht 2022",
                    ["icon_url"] = "",
                },
            }
        }
    
        PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' }) 
    end
end)