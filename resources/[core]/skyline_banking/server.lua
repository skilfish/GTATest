SKYLINE = nil

local wb = "https://discord.com/api/webhooks/988810131712139274/IXxsmelmw99KN3mQQ1IiozIY7H8YQgONC8cY1_n5Dw_VqukXwlkuMJk82tJJpHLhColp"

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

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


RegisterServerEvent('banksystemoderso:deposit')
AddEventHandler('banksystemoderso:deposit', function(amount)
    local _source = source

    local xPlayer = SKYLINE.GetPlayerFromId(_source)
    if amount == nil or amount <= 0 then
        --TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        if amount > xPlayer.getMoney() then
            amount = xPlayer.getMoney()
        end
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', tonumber(amount))

        local msg = {
            {
                ["color"] = "2123412",
                ["title"] = "Geld eingezahlt",
                ["description"] = "**Wie viel Geld eingezahlt wurde:** " .. amount .. "$ \n \n **Eingezahlt von: **" .. xPlayer.getName() .. "\nLizenz: " .. xPlayer.getIdentifier() .. " \nDiscord: <@" .. getDCId(xPlayer.source) .. ">",
                ["footer"] = {
                    ["text"] = "Copyright © Jucktnicht 2022",
                    ["icon_url"] = "",
                },
            }
        }
    
        PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterServerEvent('banksystemoderso:withdraw')
AddEventHandler('banksystemoderso:withdraw', function(amount)
    local _source = source
    local xPlayer = SKYLINE.GetPlayerFromId(_source)
    local base = 0
    amount = tonumber(amount)
    base = xPlayer.getAccount('bank').money
    if amount == nil or amount <= 0 then
        --TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        if amount > base then
            amount = base
        end
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)

        local msg = {
            {
                ["color"] = "2123412",
                ["title"] = "Geld abgehoben",
                ["description"] = "**Wie viel Geld abgehoben wurde:** " .. amount .. "$ \n \n **Abgehoben von: **" .. xPlayer.getName() .. "\nLizenz: " .. xPlayer.getIdentifier() .. " \nDiscord: <@" .. getDCId(xPlayer.source) .. ">",
                ["footer"] = {
                    ["text"] = "Copyright © Jucktnicht 2022",
                    ["icon_url"] = "",
                },
            }
        }
    
        PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterServerEvent('banksystemoderso:balance')
AddEventHandler('banksystemoderso:balance', function()
    local _source = source
    local xPlayer = SKYLINE.GetPlayerFromId(_source)
    balance = xPlayer.getAccount('bank').money
    TriggerClientEvent('currentbalance1', _source, balance)

end)

RegisterServerEvent('banksystemoderso:transfer')
AddEventHandler('banksystemoderso:transfer', function(to, amountt)
    local _source = source
    local xPlayer = SKYLINE.GetPlayerFromId(_source)
    local zPlayer = SKYLINE.GetPlayerFromId(to)
    local balance = 0
    if zPlayer ~= nil and GetPlayerEndpoint(to) ~= nil then
        balance = xPlayer.getAccount('bank').money
        zbalance = zPlayer.getAccount('bank').money
        if tonumber(_source) == tonumber(to) then
            xPlayer.triggerEvent("skyline_notify:Alert", "BANK" , "Du kannst dir selber kein Geld senden!" , 3000 , "error")
        else
            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <=
                0 then
                    xPlayer.triggerEvent("skyline_notify:Alert", "BANK" , "Du hast nicht genug Geld auf dem Konto!" , 3000 , "error")

            else
                xPlayer.removeAccountMoney('bank', tonumber(amountt))
                zPlayer.addAccountMoney('bank', tonumber(amountt))


                local msg = {
                    {
                        ["color"] = "2123412",
                        ["title"] = "Geld überwiesen",
                        ["description"] = "**Wie viel Geld Überwiesen wurde:** " .. amountt .. "$ \n \n **Überwiesen von: **" .. xPlayer.getName() .. "\nLizenz: " .. xPlayer.getIdentifier() .. " \nDiscord: <@" .. getDCId(xPlayer.source) .. "> \n \n **Überweisung ging an:** " .. zPlayer.getName() .. "\n Lizenz: " .. zPlayer.getIdentifier() .. "\n Discord: <@" .. getDCId(zPlayer.source) .. ">",
                        ["footer"] = {
                            ["text"] = "Copyright © Jucktnicht 2022",
                            ["icon_url"] = "",
                        },
                    }
                }
            
                PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })

                xPlayer.triggerEvent("skyline_notify:Alert", "BANK" , "Du hast das Geld überwiesen." , 3000 , "success")
                zPlayer.triggerEvent("skyline_notify:Alert", "BANK" , "Du hast das Geld überwiesen bekommen. (Menge: " .. amountt .. "$)" , 4000 , "success")
              
            end

        end
    else 
        xPlayer.triggerEvent("skyline_notify:Alert", "BANK" , "Diese ID ist nicht online!" , 3000 , "error")

    end

end)

SKYLINE.RegisterServerCallback("banksystemoderso:getName", function(playerId , cb)
    local xPlayer = SKYLINE.GetPlayerFromId(playerId)
    cb(xPlayer.getName())
 end)