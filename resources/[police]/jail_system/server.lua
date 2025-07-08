RegisterCommand("jail", function(source, args)
    local src = source
    if IsPlayerAceAllowed(src, "police") then
        local target = tonumber(args[1])
        local duration = tonumber(args[2]) or 5
        if target then
            TriggerClientEvent("jail_system:sendToJail", target, duration)
        end
    end
end, false)

RegisterCommand("unjail", function(source, args)
    local src = source
    if IsPlayerAceAllowed(src, "police") then
        local target = tonumber(args[1])
        if target then
            TriggerClientEvent("jail_system:releaseFromJail", target)
        end
    end
end, false)

RegisterNetEvent("jail_system:requestJail", function(targetId, duration)
    local src = source
    if IsPlayerAceAllowed(src, "police") then
        TriggerClientEvent("jail_system:sendToJail", targetId, duration)
    end
end)

RegisterNetEvent("jail_system:requestUnjail", function(targetId)
    local src = source
    if IsPlayerAceAllowed(src, "police") then
        TriggerClientEvent("jail_system:releaseFromJail", targetId)
    end
end)

RegisterNetEvent("jail_system:checkJobForMenu", function()
    local src = source
    local job = exports.ox_core:getPlayer(src)?.job?.name
    if job == "police" then
        TriggerClientEvent("jail_system:openMenu", src)
    end
end)
