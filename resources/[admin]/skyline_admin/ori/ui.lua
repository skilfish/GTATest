RegisterNUICallback("focusOff", function()
    SetNuiFocus(false, false)

    SendNUIMessage({
        display = false,
    })
end)