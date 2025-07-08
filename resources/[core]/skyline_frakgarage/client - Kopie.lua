ESX = nil

local job = nil 
local grade = nil 
local isInMenu = false
local spawnedVehicles = {}
local inOther = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("skylineistback:getSharedObject", function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    Citizen.Wait(1000)

    ESX.TriggerServerCallback("jucktnicht_frakgarage:load", function(a , b) 
        job = a 
        grade = b
    end)
end)


RegisterNetEvent("skyline:playerLoaded")
AddEventHandler("skyline:playerLoaded", function(xPlayer)
    job = xPlayer.job.name 
    grade = xPlayer.job.grade
end)

RegisterNetEvent("skyline:setJob")
AddEventHandler("skyline:setJob", function()
    ESX.TriggerServerCallback("jucktnicht_frakgarage:load", function(a , b) 
        job = a 
        grade = b
    end)
end)

-- Plate -- 
local NumberCharset = {}
local Charset = {}
local spawnedVehicles = {}

PlateLetters  = 3
PlateNumbers  = 3
PlateUseSpace = true

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomNumber(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		if PlateUseSpace then
			generatedPlate = string.upper(GetRandomLetter(PlateLetters) .. ' ' .. GetRandomNumber(PlateNumbers))
		else
			generatedPlate = string.upper(GetRandomLetter(PlateLetters) .. GetRandomNumber(PlateNumbers))
		end

		ESX.TriggerServerCallback('jucktnicht_frakgarage:isPlateTaken', function(isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end


-- Plate --



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
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function enterGarage()
    inOther = true 
    ESX.UI.Menu.CloseAll()
    ESX.Game.Teleport(PlayerPedId(), vector3(Config.Jobs[job].View.x , Config.Jobs[job].View.y , Config.Jobs[job].View.z) , function() 
        
        FreezeEntityPosition(PlayerPedId(), true)
        SetEntityVisible(PlayerPedId(), false, 0)
        

        ESX.TriggerServerCallback("jucktnicht_frakgarage:getVehicles", function(cb) 

            local elements = {}

            for _, veh in pairs(cb) do 
                print(veh.plate)
            
                local decoded_props = json.decode(veh.vehicle)


                table.insert(elements,{label = veh.plate .. " | " .. GetLabelText((GetDisplayNameFromVehicleModel(decoded_props.model)))  , value = "", props = decoded_props , plate = veh.plate})
            end 

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), job .. "_garage_d", {
		title    = Config.Jobs[job].label .. " - Garage",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), job .. "_g_confirm", {
			title    = "Ausparken?",
			align    = 'top-left',
			elements = {
				{ label = "Nein", value = 'no' },
				{ label = "Ja", value = 'yes' }
			}
		}, function(data2, menu2)

            if data2.current.value == 'yes' then
                currentModel = data.current.props.model

                DeleteSpawnedVehicles()

                FreezeEntityPosition(PlayerPedId(), false)
                SetEntityVisible(PlayerPedId(), true, 0)
                isInMenu = false


                 parkOut = {
					x = Config.Jobs[job].ParkOut.x, y = Config.Jobs[job].ParkOut.y, z = Config.Jobs[job].ParkOut.z
                 }

                 h = Config.Jobs[job].ParkOut.h

  
                ESX.Game.Teleport(PlayerPedId(), vector3(parkOut.x , parkOut.y , parkOut.z), function()
                    WaitForVehicleToLoad(data.current.props.model)
                    ESX.Game.SpawnVehicle(data.current.props.model, vector3(parkOut.x , parkOut.y , parkOut.z), h, function(vehicle) 
                        ESX.Game.SetVehicleProperties(vehicle, data.current.props)
                        SetVehicleNumberPlateText(vehicle, data.current.plate)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                    end)
     
                end)

                TriggerServerEvent("jucktnicht_frakgarage:setStored" , data.current.plate , 0)


                ESX.UI.Menu.CloseAll()



            elseif data2.current.value == 'no' then
                menu2.close()
            end

		end, function(data2, menu2)

			menu2.close()
		end)



		end, function(data, menu)
            isInMenu = false 
            DeleteSpawnedVehicles()
            inOther = false
            FreezeEntityPosition(PlayerPedId(), false)
            SetEntityVisible(PlayerPedId(), true, 0)
            ESX.Game.Teleport(PlayerPedId(), Config.Jobs[job].Shop_Leave)

            menu.close()
           
            end, function(data, menu)
		DeleteSpawnedVehicles()


        WaitForVehicleToLoad(data.current.props.model)
        ESX.Game.SpawnLocalVehicle(data.current.props.model, vector3(Config.Jobs[job].View.x , Config.Jobs[job].View.y , Config.Jobs[job].View.z), Config.Jobs[job].View.h, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, data.current.props)
            table.insert(spawnedVehicles, vehicle)
            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
            SetVehicleEngineOn(vehicle, false, true, true)
        end)
    end)

    WaitForVehicleToLoad(elements[1].props.model)
    ESX.Game.SpawnLocalVehicle(elements[1].props.model, vector3(Config.Jobs[job].View.x , Config.Jobs[job].View.y , Config.Jobs[job].View.z), Config.Jobs[job].View.h, function(vehicle)
        ESX.Game.SetVehicleProperties(vehicle, elements[1].props)
        table.insert(spawnedVehicles, vehicle)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        SetVehicleEngineOn(vehicle, false, true, true)
    end)

    
    end) 

   end)
end 

function openCarShop()
    inOther = true
    local ped = PlayerPedId()
    ESX.UI.Menu.CloseAll()
    FreezeEntityPosition(ped, true)
    SetEntityVisible(ped, false)

    Citizen.Wait(150)

    local table_cars = {}

    for _,v in pairs(Config.Jobs[job].Cars) do 
        if v.grade <= grade then 
            table.insert(table_cars , v)
        end 
    end 

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), job .. "_shop", {
		title    = "Wähle ein Auto",
		align    = 'top-left',
		elements = table_cars
	}, function(data, menu)

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), job .. "_confirm", {
			title    = "Willst du dieses Auto wirklich kaufen?",
			align    = 'top-left',
			elements = {
				{ label = "<b style=color:red;>Nein", value = 'no' },
				{ label = "<b style=color:green;>Ja", value = 'yes' }
			}
		}, function(data2, menu2)

			if data2.current.value == 'yes' then

                local props = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(ped, false))
                local plate = GeneratePlate()

                ESX.TriggerServerCallback("jucktnicht_frakgarage:buyVehicle", function(worked) 
                    if worked then 
                        
                        DeleteSpawnedVehicles()
                        FreezeEntityPosition(PlayerPedId(), false)
                        SetEntityVisible(PlayerPedId(), true)
                        isInMenu = false
                        ESX.UI.Menu.CloseAll()

                        ESX.Game.SpawnVehicle(data.current.value, vector3(Config.Jobs[job].Shop_Buyed.x , Config.Jobs[job].Shop_Buyed.y , Config.Jobs[job].Shop_Buyed.z), Config.Jobs[job].Shop_Buyed.h, function(car) 
                            ESX.Game.SetVehicleProperties(car, props)
                            SetVehicleNumberPlateText(car, plate)
                            TaskWarpPedIntoVehicle(PlayerPedId(), car, -1)
                        end)
                    
                        TriggerEvent("notifications", "red", "Frak-Garage" , "Dir gehört nun dieses Auto. (Kennzeichen: " .. plate .. ")")
                    else 
                        TriggerEvent("notifications", "red" , "Frak-Garage" , "Du hast nicht Genug geld dabei!")
                        DeleteSpawnedVehicles()
                        ESX.UI.Menu.CloseAll()
                        FreezeEntityPosition(ped, false)
		                SetEntityVisible(ped, true)
                        isInMenu = false
		                ESX.Game.Teleport(ped, Config.Jobs[job].Shop_Leave)
                    end 
                end, plate , job , props , data.current.id)

			end

		end, function(data2, menu2)

			menu2.close()

		end)



		end, function(data, menu)

	

		isInMenu = false
		ESX.UI.Menu.CloseAll()
        inOther = false


        
		DeleteSpawnedVehicles()
		FreezeEntityPosition(ped, false)
		SetEntityVisible(ped, true)

		ESX.Game.Teleport(ped, Config.Jobs[job].Shop_Leave)
	end, function(data, menu)
		DeleteSpawnedVehicles()


		
        ESX.Game.SpawnLocalVehicle(data.current.value, vector3(Config.Jobs[job].Shop_View.x , Config.Jobs[job].Shop_View.y , Config.Jobs[job].Shop_View.z), Config.Jobs[job].Shop_View.h, function(vehicle)
            SetVehicleColours(vehicle, Config.Jobs[job].Colors.primary, Config.Jobs[job].Colors.secondary)
            table.insert(spawnedVehicles, vehicle)
			TaskWarpPedIntoVehicle(ped, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
		end)

	end)

	

	WaitForVehicleToLoad(Config.Jobs[job].Cars[1].value)
	ESX.Game.SpawnLocalVehicle(Config.Jobs[job].Cars[1].value, vector3(Config.Jobs[job].Shop_View.x , Config.Jobs[job].Shop_View.y , Config.Jobs[job].Shop_View.z), Config.Jobs[job].Shop_View.h, function(vehicle)
        SetVehicleColours(vehicle, Config.Jobs[job].Colors.primary, Config.Jobs[job].Colors.secondary)
        table.insert(spawnedVehicles, vehicle)
		TaskWarpPedIntoVehicle(ped, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
	end)

end 

function openMain()
    isInMenu = true

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), job .. "_garage", {
        title = Config.Jobs[job].label .. " - Garage",
        align    = 'top-left',
        elements = {
          {label = "<b style=color:green;>Deine Autos", value = "garage"},
          {label = "<b style=color:yellow;>Auto Shop", value = "shop"},
          {label = "<b style=color:orange;>Dein Auto einparken", value = "parkIn"}

        }, 
    }, function(data , menu)

        if data.current.value == "shop" then 
            Citizen.Wait(5)

            openCarShop()
        end 

        if data.current.value == "garage" then 
            enterGarage()
        end 

        if data.current.value == "parkIn" then 
            local playerPed = PlayerPedId()
		    local coords = GetEntityCoords(playerPed)

            if IsAnyVehicleNearPoint(coords, 10.0) then
                local vehicle = GetClosestVehicle(coords, 10.0, 0, 71)

                if DoesEntityExist(vehicle) then
                    local props = ESX.Game.GetVehicleProperties(vehicle)

                    ESX.TriggerServerCallback("jucktnicht_frakgarage:isVehOk", function(isOk) 
                        if isOk then 
                                ESX.Game.DeleteVehicle(vehicle)
                                TriggerServerEvent("jucktnicht_frakgarage:setStored" , props.plate , true)
                        else 
                            TriggerEvent("notifications", "red" , "Garage" , "Kein Auto von dir in der Nähe!")
                        end 
                
                    end, props.plate , job)
                end    
             
            else 
                TriggerEvent("notifications", "red" , "Garage" , "Kein Auto von dir in der Nähe!")
     
            end
                isInMenu = false
                menu.close()
        end
    end, function(data , menu) 
        isInMenu = false
        menu.close()
    end)
end 

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if Config.Jobs[job] ~= nil then 
            local ped = PlayerPedId()
            local coords = GetEntityCoords(PlayerPedId())
            local config = Config.Jobs[job]

            -- Marker -- 
            if GetDistanceBetweenCoords(coords, config.pos, true) < 50.0 then 
                DrawMarker(36, config.pos.x, config.pos.y, config.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, config.markerColor.r, config.markerColor.g, config.markerColor.b, 255, false, false, 2, true, nil, nil, false)
            end 
            -- Marker --

            -- Trigger -- 
            if GetDistanceBetweenCoords(coords, config.pos, true) < 1.5 then 
                if not isInMenu then 
                    ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um die ~y~Garage ~w~zu benutzten")

                    if IsControlJustPressed(0, 38) then 
                        openMain()
                    end 
                end 
            end 
            -- Trigger --

        end 
    end 
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)


        if isInMenu and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()) , Config.Jobs[job].pos , true) > 2.0 then 
            ESX.UI.Menu.Close("default", GetCurrentResourceName(), job .. "_garage")
            isInMenu = false
        end 
    end 
end)


