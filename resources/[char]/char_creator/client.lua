local cam

RegisterNetEvent('char_creator:start', function()
    DoScreenFadeOut(1000)
    Wait(1000)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, Config.Camera.coords.x, Config.Camera.coords.y, Config.Camera.coords.z)
    PointCamAtCoord(cam, Config.Camera.coords.x, Config.Camera.coords.y, Config.Camera.coords.z - 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 0, true, true)

    SetEntityCoordsNoOffset(PlayerPedId(), Config.Camera.coords.x, Config.Camera.coords.y, Config.Camera.coords.z - 1, false, false, false)
    SetEntityHeading(PlayerPedId(), Config.Camera.heading)

    ShutdownLoadingScreen()
    DoScreenFadeIn(1000)

    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'open' })
end)

RegisterNUICallback('submitData', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })

    -- apply base model for ox_appearance after character created
    local model = data.gender == "m" and `mp_m_freemode_01` or `mp_f_freemode_01`
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)

    TriggerEvent('ox_appearance:openCreator')
    TriggerServerEvent('char_creator:saveCharacter', data)
    cb('ok')
end)
