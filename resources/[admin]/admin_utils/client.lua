RegisterNetEvent("admin_utils:revive", function()
    SetEntityHealth(PlayerPedId(), 200)
    ClearPedTasksImmediately(PlayerPedId())
    TriggerEvent("ox_lib:notify", {description = "Du wurdest revived.", type = "success"})
end)

local aduty = false

RegisterNetEvent("admin_utils:toggleDuty", function()
    aduty = not aduty
    if aduty then
        SetEntityVisible(PlayerPedId(), false, false)
        TriggerEvent("ox_lib:notify", {description = "Admin Duty aktiviert", type = "success"})
    else
        SetEntityVisible(PlayerPedId(), true, false)
        TriggerEvent("ox_lib:notify", {description = "Admin Duty deaktiviert", type = "info"})
    end
end)


local gamertagsEnabled = false
local tagHandle = nil

RegisterCommand("showtags", function()
    if not gamertagsEnabled then
        local playerPed = PlayerPedId()
        local playerName = GetPlayerName(PlayerId())
        tagHandle = CreateFakeMpGamerTag(playerPed, playerName, false, false, "", 0)
        SetMpGamerTagVisibility(tagHandle, 0, true)
        gamertagsEnabled = true
        TriggerEvent("ox_lib:notify", {description = "Gamertag aktiviert", type = "info"})
    end
end, false)

RegisterCommand("hidetags", function()
    if gamertagsEnabled and tagHandle then
        RemoveMpGamerTag(tagHandle)
        gamertagsEnabled = false
        TriggerEvent("ox_lib:notify", {description = "Gamertag deaktiviert", type = "info"})
    end
end, false)
