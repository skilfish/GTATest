SKYLINE = nil

Citizen.CreateThread(function()
    while SKYLINE == nil do
        TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
        Citizen.Wait(0)
    end
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    
        SendNUIMessage({
            type = "ui",
            status = bool,
        })

end

local DrawText3D = function(x, y, z, text, r, g, b, scale)
    SetDrawOrigin(x, y, z, 0)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0, scale or 0.2)
    SetTextColour(r, g, b, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0, 0)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 56) then
            SetDisplay(true)
        end
    end
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("persoan", function(data)
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    SetDisplay(false)

    TriggerServerEvent('idcardoderso:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
end)

RegisterNUICallback("persozei", function(data)
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    SetDisplay(false)

    local player, closestDistance = SKYLINE.Game.GetClosestPlayer()

    if player == -1 or closestDistance > 1.5 then
        TriggerEvent("skyline_notify:Alert", "BRIEFTASCHE" , "Keine Person in der Nähe!" , 3000 , "error")
        isBusy = false 
    else 
        TriggerServerEvent('idcardoderso:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
    end

end)

RegisterNUICallback("fur", function(data)
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    SetDisplay(false)

    TriggerServerEvent('idcardoderso:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
end)
RegisterNUICallback("fure", function(data)
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    SetDisplay(false)

    local player, closestDistance = SKYLINE.Game.GetClosestPlayer()

    if player == -1 or closestDistance > 1.5 then
        TriggerEvent("skyline_notify:Alert", "BRIEFTASCHE" , "Keine Person in der Nähe!" , 3000 , "error")
        isBusy = false 
    else 
        TriggerServerEvent('idcardoderso:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
    end

    TriggerServerEvent('idcardoderso:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
end)

RegisterNUICallback("waffenan", function(data)
    SetDisplay(false)
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")

    TriggerServerEvent('idcardoderso:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
end)

RegisterNUICallback("waffenze", function(data)
    SetDisplay(false)
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")

    local player, closestDistance = SKYLINE.Game.GetClosestPlayer()

    if player == -1 or closestDistance > 1.5 then
        TriggerEvent("skyline_notify:Alert", "BRIEFTASCHE" , "Keine Person in der Nähe!" , 3000 , "error")
        isBusy = false 
    else 
        TriggerServerEvent('idcardoderso:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
    end

    TriggerServerEvent('idcardoderso:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
end)