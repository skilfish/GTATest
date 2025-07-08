local SKYLINE = nil
local time_out = {}

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)


RegisterServerEvent("skyline_tracker")
AddEventHandler("skyline_tracker", function(plate) 

    local xPlayers = SKYLINE.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = SKYLINE.GetPlayerFromId(xPlayers[i])


        if xPlayer.getJob().name == 'police' then
            TriggerClientEvent("skyline_tracker:plate", xPlayers[i], plate)

        end

    end
end)

RegisterServerEvent("skyline_tracker:setActivePlates")
AddEventHandler("skyline_tracker:setActivePlates", function(plate)
    time_out[plate] = false
end)

RegisterServerEvent("skyline_tracker:removeActivePlate")
AddEventHandler("skyline_tracker:removeActivePlate", function(plate)
    time_out[plate] = time_out[nil]
    local xPlayers = SKYLINE.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = SKYLINE.GetPlayerFromId(xPlayers[i])


        if xPlayer.getJob().name == 'police' then
            TriggerClientEvent("skyline_tracker:updateActivePlate", xPlayers[i], plate)
        end

    end

end)

RegisterServerEvent("skyline_tracker:getActivePlates")
AddEventHandler("skyline_tracker:getActivePlates", function()
    TriggerClientEvent("skyline_tracker:getActivePlates", source, time_out)
end)


RegisterServerEvent("skyline_tracker:triggerTimer")
AddEventHandler("skyline_tracker:triggerTimer", function(plate)
    local xPlayers = SKYLINE.GetPlayers()
    local startTimer = os.time() + Config.removeTimer
    Citizen.CreateThread(function()
        while os.time() < startTimer and time_out[plate] ~= nil do 
            Citizen.Wait(5)
        end

        for i=1, #xPlayers, 1 do
            local xPlayer = SKYLINE.GetPlayerFromId(xPlayers[i])
    
    
            if xPlayer.getJob().name == 'police' then
                TriggerClientEvent("skyline_tracker:updateTimer", xPlayers[i], plate)
            end
    
        end
    
    end)
end)

