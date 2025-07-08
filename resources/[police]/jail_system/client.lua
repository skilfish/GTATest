local isInJail = false
local jailTime = 0

RegisterNetEvent("jail_system:sendToJail", function(duration)
    isInJail = true
    jailTime = duration * 60
    SetEntityCoords(PlayerPedId(), 1680.1, 2513.0, 45.5)
    TriggerEvent("ox_lib:notify", {description = "Du wurdest inhaftiert für " .. duration .. " Minute(n).", type = "error"})

    CreateThread(function()
        while isInJail and jailTime > 0 do
            Wait(1000)
            jailTime -= 1
            if jailTime <= 0 then
                TriggerEvent("jail_system:releaseFromJail")
            end
        end
    end)
end)

RegisterNetEvent("jail_system:releaseFromJail", function()
    isInJail = false
    SetEntityCoords(PlayerPedId(), 1850.0, 2585.0, 45.5)
    TriggerEvent("ox_lib:notify", {description = "Du wurdest entlassen.", type = "success"})
end)


CreateThread(function()
    exports.ox_target:addGlobalPlayer({
        {
            icon = "fa-solid fa-lock",
            label = "Ins Gefängnis stecken (5 Min.)",
            job = "police",
            distance = 2.5,
            canInteract = function(entity)
                return true
            end,
            onSelect = function(data)
                local target = data.entity
                local playerId = NetworkGetPlayerIndexFromPed(target)
                if playerId then
                    TriggerServerEvent("jail_system:requestJail", GetPlayerServerId(playerId), 5)
                end
            end
        },
        {
            icon = "fa-solid fa-unlock",
            label = "Aus Gefängnis entlassen",
            job = "police",
            distance = 2.5,
            canInteract = function(entity)
                return true
            end,
            onSelect = function(data)
                local target = data.entity
                local playerId = NetworkGetPlayerIndexFromPed(target)
                if playerId then
                    TriggerServerEvent("jail_system:requestUnjail", GetPlayerServerId(playerId))
                end
            end
        }
    })
end)

RegisterCommand("openJailMenu", function()
    local closestPlayer, closestDistance = lib.getClosestPlayer()
    if closestPlayer == -1 or closestDistance > 3.0 then
        lib.notify({ description = "Kein Spieler in der Nähe", type = "error" })
        return
    end

    lib.registerContext({
        id = 'jail_menu',
        title = 'Polizei: Gefängnis',
        options = {
            {
                title = 'Ins Gefängnis stecken (5 Min.)',
                icon = 'lock',
                onSelect = function()
                    TriggerServerEvent("jail_system:requestJail", GetPlayerServerId(closestPlayer), 5)
                end
            },
            {
                title = 'Entlassen',
                icon = 'unlock',
                onSelect = function()
                    TriggerServerEvent("jail_system:requestUnjail", GetPlayerServerId(closestPlayer))
                end
            }
        }
    })

    lib.showContext('jail_menu')
end)

CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustReleased(0, 167) then -- F6
            TriggerServerEvent("jail_system:checkJobForMenu")
        end
    end
end)

RegisterNetEvent("jail_system:openMenu", function()
    ExecuteCommand("openJailMenu")
end)
