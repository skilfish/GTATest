AddEventHandler("playerDropped", function(reason)
    local crds = GetEntityCoords(GetPlayerPed(source))
    local id = source
    local identifier = ""
    if Config.UseSteam then
        identifier = GetPlayerIdentifier(source, 0)
    else
        identifier = GetPlayerIdentifier(source, 1)
    end
    TriggerClientEvent("skyline_combatlog", -1, id, crds, identifier, reason)
   
end)

