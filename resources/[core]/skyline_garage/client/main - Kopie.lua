SKYLINE = nil

Citizen.CreateThread(function()
    while SKYLINE == nil do
        TriggerEvent("skylineistback:getSharedObject", function(obj) SKYLINE = obj end)
        Citizen.Wait(0)
    end
end)

local currentgarage = nil

function toggleField(bool, name)
    SetNuiFocus(bool, bool)

    SendNUIMessage({
        action = 'show',
        state = bool,
        name = name
    })
end

function AddCar(model, plate, nickname, isFav)
    SendNUIMessage({
        action = 'addCar',
        model = model,
        plate = plate,
        nickname = nickname,
        isFav = isFav
    })
end

RegisterNUICallback(GetCurrentResourceName(), function()
    TriggerServerEvent("jucktnicht_garage:securitykick")
end)

function GetAvailableVehicleSpawnPoint(station)
    local found = false 
    local foundSpawnPoint = nil

    for k,v in pairs(Config.Garages[station].SpawnPoints) do
        if SKYLINE.Game.IsSpawnPointClear(v.coords, v.radius) then
            found = true
            foundSpawnPoint = v
            break
        end
    end

    if found then
        return true, foundSpawnPoint
    else
        TriggerEvent("skyline_notify:Alert", "GARAGE" , "<b style=color:red;>Alle Ausparkpunkte belegt!" , 4000 , "error")
        return false
    end
end


RegisterNUICallback('escape', function(data, cb)
    SetNuiFocus(false, false)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local pos = GetEntityCoords(playerPed)

        for k,v in pairs(Config.Garages) do
            local dist = GetDistanceBetweenCoords(pos, v.location)


            if dist <= 50.0 then
                DrawMarker(36, v.location.x,  v.location.y,  v.location.z , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 171, 245, 255, false, false, 2, true, nil, nil, false)
            end

            if dist <= 2.0 then
                SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um auf die Garage zuzugreifen")

                if IsControlJustReleased(0, 38) then
                    toggleField(true, v.name)
                    currentgarage = k
                end
            end
        end
    end
end)

RegisterNUICallback('enable-parkout', function(data, cb)
    SKYLINE.TriggerServerCallback('jucktnicht_garage:loadVehicles', function(ownedCars)
        if #ownedCars == 0 then
            TriggerEvent("skyline_notify:Alert", "GARAGE" , "<b style=color:red;>Du hast keine Fahrzeuge in deiner Garage!" , 5000 , "error")
        else
            for k,v in pairs(ownedCars) do
                local hashVehicule = v.vehicle.model
                local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
                local modelName = GetLabelText(aheadVehName)
                AddCar(aheadVehName, v.plate, v.name, v.isFav)
            end
        end
    end)
end)

RegisterNUICallback('enable-parking', function(data, cb)
    local vehicles = SKYLINE.Game.GetVehiclesInArea(GetEntityCoords(PlayerPedId()), 25.0)

    for key, value in pairs(vehicles) do
        SKYLINE.TriggerServerCallback('jucktnicht_garage:isOwned', function(owned)
            if owned ~= nil then
                AddCar(GetDisplayNameFromVehicleModel(GetEntityModel(value)), SKYLINE.Game.GetVehicleProperties(value).plate, owned[1], owned[2])
            end
        end, SKYLINE.Game.GetVehicleProperties(value).plate)
    end
    
    cb('ok')
end)

RegisterNUICallback('setvehfav', function(data, cb)
    TriggerServerEvent("jucktnicht_garage:setvehfav", data.plate, data.state)
end)

RegisterNUICallback('rename', function(data, cb)
    TriggerServerEvent("jucktnicht_garage:setvehnickname", data.plate, data.nickname)
end)

RegisterNUICallback('park-in', function(data, cb)
    local vehicles = SKYLINE.Game.GetVehiclesInArea(GetEntityCoords(PlayerPedId()), 25.0)

    for k,v in pairs(vehicles) do
        if SKYLINE.Game.GetVehicleProperties(v).plate == data.plate then
            TriggerServerEvent('jucktnicht_garage:saveProps', data.plate, SKYLINE.Game.GetVehicleProperties(v))
            TriggerServerEvent('jucktnicht_garage:changeState', data.plate, 1)
            SKYLINE.Game.DeleteVehicle(v)
        end
    end
end)

RegisterNUICallback('park-out', function(data, cb)
    
    SKYLINE.TriggerServerCallback('jucktnicht_garage:loadVehicle', function(vehicle)
        local props = json.decode(vehicle[1].vehicle)
        local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(currentgarage)

        if foundSpawn then
            SKYLINE.Game.SpawnVehicle(props.model, spawnPoint.coords, spawnPoint.heading, function(callback_vehicle)
                SKYLINE.Game.SetVehicleProperties(callback_vehicle, props)
                SetVehRadioStation(callback_vehicle, "OFF")
                if Config.teleportinvehicle then
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
                end
            end)
        end

        TriggerServerEvent('jucktnicht_garage:changeState', data.plate, 0)
    end, data.plate)
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Garages) do
        local blip = AddBlipForCoord(v.location)

        SetBlipSprite(blip, 473)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 11)
        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garage")
        EndTextCommandSetBlipName(blip)
    end
end)