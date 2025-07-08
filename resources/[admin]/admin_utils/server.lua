RegisterCommand("adminrevive", function(source, args, raw)
    local src = source
    if IsPlayerAceAllowed(src, "admin") then
        local target = tonumber(args[1])
        if target and GetPlayerPed(target) then
            TriggerClientEvent("admin_utils:revive", target)
            print(("Admin %s hat Spieler %s revived."):format(src, target))
        else
            TriggerClientEvent("ox_lib:notify", src, {description = "Ungültiger Spieler", type = "error"})
        end
    end
end, false)

RegisterCommand("aduty", function(source)
    local src = source
    if IsPlayerAceAllowed(src, "admin") then
        TriggerClientEvent("admin_utils:toggleDuty", src)
    end
end, false)
