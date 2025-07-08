SKYLINE = nil
currentEnterCoords = nil
currentGarageId = -1
currentImpoundId = -1
currentModel = nil

local spawnedVehicles = {}


Citizen.CreateThread(function()
	while SKYLINE == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()



    
    for _, info in pairs(Config.Impounds) do
        info.blip = AddBlipForCoord(info.x_1, info.y_1, info.z_1)
        SetBlipSprite(info.blip, Config.Impound_Blip.sprite)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, Config.Impound_Blip.scale)
        SetBlipColour(info.blip,Config.Impound_Blip.color)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Impound_Blip.title)
        EndTextCommandSetBlipName(info.blip)
      end
end)


function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName("Fahrzeug lädt... Bitte Warten.")
		EndTextCommandBusyspinnerOn(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		BusyspinnerOff()
	end
end

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		SKYLINE.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end





function exitImpound(tp)
    isInImpound = false 

    DeleteSpawnedVehicles()

    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityVisible(PlayerPedId(), true, 0)

    if tp then 
        SKYLINE.Game.Teleport(PlayerPedId(), currentEnterCoords, function()
            FreezeEntityPosition(PlayerPedId(), false)
            SetEntityVisible(PlayerPedId(), true, 0)
        end)
    
    end 
    
end






function enterImpound()

    isInImpound = true

    SKYLINE.Game.Teleport(PlayerPedId(), vector3(Config.Impound_View.x , Config.Impound_View.y , Config.Impound_View.z) , function() 
        
        FreezeEntityPosition(PlayerPedId(), true)
        SetEntityVisible(PlayerPedId(), false, 0)
        

        SKYLINE.TriggerServerCallback("impoundduhs:getImpoundVehicles", function(cb) 

            local elements = {}

            for _, veh in pairs(cb) do 
            
                local decoded_props = json.decode(veh.vehicle)


                table.insert(elements,{label = veh.plate .. " | " .. GetLabelText((GetDisplayNameFromVehicleModel(decoded_props.model)))  , value = "", props = decoded_props , plate = veh.plate})
            end 

            
            if next(elements) == nil then 
                SKYLINE.UI.Menu.CloseAll()
                exitImpound(true)
                TriggerEvent("skyline_notify:Alert", "ABSCHLEPPHOF" , "<b style=color:red;>Du hast keine Fahrzeuge im Abschlepphof!" , 3000 , "error")
           
            else 
                SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'garage', {
                    title    = "Abschlepphof | Pro Fahrzeug 2000$",
                    align    = 'top-left',
                    elements = elements
                }, function(data, menu)
            
                    SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm', {
                        title    = "In Garage parken?",
                        align    = 'top-left',
                        elements = {
                            { label = "Nein", value = 'no' },
                            { label = "Ja", value = 'yes' }
                        }
                    }, function(data2, menu2)
            
                        if data2.current.value == 'yes' then
                            currentModel = data.current.props.model
            
                            exitImpound(true)
            
                            SKYLINE.TriggerServerCallback("impoundduhs:payImpound", function(successful) 
                                if successful then 
                                    TriggerServerEvent("impoundduhs:setStored" , data.current.plate , 1)
                                    TriggerEvent("skyline_notify:Alert", "ABSCHLEPPHOF" , "2000$ Gezahlt. Fahrzeug ist jetzt in der Garage. (Kennzeichen: " .. data.current.plate ..")" , 3000 , "success")

                                else 
                                    TriggerEvent("skyline_notify:Alert", "ABSCHLEPPHOF" , "Du hast nicht genug Geld dabei! (2000$ benötigt)" , 3000 , "error")
                                end 
                            end, PlayerPedId())
            
            
            
                            SKYLINE.UI.Menu.CloseAll()
            
            
            
                        elseif data2.current.value == 'no' then
                            menu2.close()
                        end
            
                    end, function(data2, menu2)
            
                        menu2.close()
            
                    end)
            
            
            
                    end, function(data, menu)
                        menu.close()
                        exitImpound(true)
                end, function(data, menu)
                    DeleteSpawnedVehicles()
            
            
                    WaitForVehicleToLoad(data.current.props.model)
                    SKYLINE.Game.SpawnLocalVehicle(data.current.props.model,  vector3(Config.Impound_View.x , Config.Impound_View.y , Config.Impound_View.z), Config.Impound_View.h, function(vehicle)
                        SKYLINE.Game.SetVehicleProperties(vehicle, data.current.props)
                        table.insert(spawnedVehicles, vehicle)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                        SetVehicleEngineOn(vehicle, false, true, true)
                    end)
                end)
            
                WaitForVehicleToLoad(elements[1].props.model)
                
                SKYLINE.Game.SpawnLocalVehicle(elements[1].props.model, vector3(Config.Impound_View.x , Config.Impound_View.y , Config.Impound_View.z), Config.Impound_View.h, function(vehicle)
                    SKYLINE.Game.SetVehicleProperties(vehicle, elements[1].props)
                    table.insert(spawnedVehicles, vehicle)
                    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                    SetVehicleEngineOn(vehicle, false, true, true)
                end)
            
            end 


        end)
    end)

end


isInMarker = false
isInGarage = false
isInMarker_2 = false
isInImpound = false

-- Draw Help Text and Key Triggers
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        
        if isInMarker_2 and not IsPedInAnyVehicle(PlayerPedId(), false) then  
            SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den ~y~Abschlepphof~s~ zu betreten.")

            if IsControlJustReleased(0 , 38) then 
                currentEnterCoords = GetEntityCoords(PlayerPedId())
                enterImpound()
            end 

        end    
    end

end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)

		if isInGarage or isInImpound then 
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end

	end 

end)



-- Draw Markers
Citizen.CreateThread(function()

    while true do 
        Citizen.Wait(0)

        local coords = GetEntityCoords(PlayerPedId())


        for _, impounds in pairs(Config.Impounds) do 
            if GetDistanceBetweenCoords(coords, impounds.x_1,  impounds.y_1, impounds.z_1) < 50 then
                DrawMarker(Config.ImpoundMarker.id,  impounds.x_1, impounds.y_1, impounds.marker_z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.ImpoundMarker.size,  Config.ImpoundMarker.size,  Config.ImpoundMarker.size,  Config.ImpoundMarker.r,  Config.ImpoundMarker.g,  Config.ImpoundMarker.b, 1.0, false, true, 2, nil, nil, false)
            end 
        end 
 
    end 

end)

-- Trigger Virtual Events for cheking is in Marker
Citizen.CreateThread(function()

    while true do 
        Citizen.Wait(0)

        local coords = GetEntityCoords(PlayerPedId())
        local d_2 = Config.ImpoundMarker.size - 0.5

      

        for _, impounds in pairs(Config.Impounds) do 
            if isInMarker_2 and GetDistanceBetweenCoords(coords, impounds.x_1, impounds.y_1, impounds.z_1) > d_2 then
                isInMarker_2 = false
                break
            end 

            if not isInMarker_2 and GetDistanceBetweenCoords(coords, impounds.x_1, impounds.y_1, impounds.z_1) < d_2 then
                isInMarker_2 = true
                currentImpoundId = impounds.id
                break
            end
        end 

    end 

end)

-- Buf fix stuck in Garage
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        local coords = GetEntityCoords(PlayerPedId())


        if GetDistanceBetweenCoords(coords, Config.Impound_View.x ,  Config.Impound_View.y , Config.Impound_View.z) < 30.0 then
            DrawMarker(1, 973.13293457031, -2995.2607421875, -39.646949768066, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5 , 1.5, 255, 0, 0, 1.0, false, true, 2, nil, nil, false)
        end

     

    end 
end)