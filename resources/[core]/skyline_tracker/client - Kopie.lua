SKYLINE = nil
local isLoading = true
local display = false 
local blips_pos = {}
local prev_pos = {}
local time_out = {}

Citizen.CreateThread(function()
	while true do
		Wait(5)
		if SKYLINE ~= nil then
		
		else
			SKYLINE = nil
			TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
		end
	end
end)


RegisterCommand("tracker", function()
    local playerData = SKYLINE.GetPlayerData()
    
    if  playerData.job.name == "police" then 
        SetNuiFocus(true, true)
        SendNUIMessage({type = 'ui', display = true})
    end

end, false)




Citizen.CreateThread(function()
    while isLoading == true do 
        Citizen.Wait(5000)     -- Roughly takes around 20-30 secs to load everything including vehicles 
        local playerData = SKYLINE.GetPlayerData()

        if SKYLINE.IsPlayerLoaded(PlayerId) and playerData.job.name == "police" then 
            TriggerServerEvent("skyline_tracker:getActivePlates")
            isLoading = false
        end
    end 

end)

RegisterNetEvent("skyline_tracker:updateTimer")
AddEventHandler("skyline_tracker:updateTimer", function(plate)
    time_out[plate] = time_out[nil]
end)

RegisterNetEvent("skyline_tracker:updateActivePlate")
AddEventHandler("skyline_tracker:updateActivePlate", function(plate)

    for v,k in pairs(time_out) do 
        if time_out[v] == plate then 
            time_out[plate] = true 
        end
    end
   
end)



RegisterNetEvent("skyline_tracker:getActivePlates")
AddEventHandler("skyline_tracker:getActivePlates", function(plates)
    time_out = plates
    for v,k in pairs(time_out) do
        checkVehicle(v)
    end
end)

RegisterNetEvent('skyline_tracker:plate')
AddEventHandler('skyline_tracker:plate', function(plate)
    checkVehicle(plate)
end)

RegisterNUICallback('searchPlate', function(data, cb)
    local vehicle = SKYLINE.Game.GetVehicles()
    local miss = 0



    for i=1, #vehicle, 1 do 
        local vehicleProps = SKYLINE.Game.GetVehicleProperties(vehicle[i])

        local plate = ""

        if #data.plate <= 7 then 
            plate = data.plate .. " "
        end 

        if plate == vehicleProps.plate then 
            local nCheck = 0
            for _ in pairs(time_out) do 
                nCheck=nCheck + 1
            end

            if nCheck >= Config.maxTracker then 
                SendNUIMessage({type = "maxPlate"})
            else
                SendNUIMessage({
                    type = "ui",
                    display = false
                  })
            
                SetNuiFocus(false)
                TriggerServerEvent("skyline_tracker", data.plate)
            end
        else 
            miss = miss + 1 
        end 
    end

    if #vehicle == miss then 
        SendNUIMessage({type = "noPlate"})
    end
end)


RegisterNUICallback("removeSearch", function(data, cb)
    local vehicle = SKYLINE.Game.GetVehicles()
    local miss = 0

    for i=1, #vehicle, 1 do 
        local vehicleProps = SKYLINE.Game.GetVehicleProperties(vehicle[i])
       
        local plate = ""

        if #data.plate <= 7 then 
            plate = data.plate .. " "
        end 

        if plate == vehicleProps.plate then 
            TriggerServerEvent("skyline_tracker:removeActivePlate", data.plate)
            SendNUIMessage({
                type = "ui",
                display = false
              })
        
            SetNuiFocus(false)
        else 
            miss = miss + 1 
        end 
    end

    if #vehicle == miss then 
        SendNUIMessage({type = "noPlate"})
    end
end)


RegisterNUICallback("close", function(data, cb)
    SendNUIMessage({
        type = "ui",
        display = false
      })

    SetNuiFocus(false)
end)


function checkVehicle(plate)
    local vehicle = SKYLINE.Game.GetVehicles()
    for i=1, #vehicle, 1 do 
        local vehicleProps = SKYLINE.Game.GetVehicleProperties(vehicle[i])
        
        local plate1 = ""

        if #plate <= 7 then 
            plate1 = plate .. " "
        end 

        if plate1 == vehicleProps.plate then 
            TriggerServerEvent("skyline_tracker:setActivePlates", plate)
            time_out[plate] = false
            createVehicleTracker(vehicle[i], plate) 
        end 
    end

end

function triggerTimer(plate)
    TriggerServerEvent("skyline_tracker:triggerTimer", plate)
end

function isInVehicle()
    if Config.inVehicle then 
        return IsPedInAnyVehicle(PlayerPedId(), false)
    else
        return true 
    end 
end

function createVehicleTracker(vehicle, plate) 
    triggerTimer(plate)

    TriggerEvent("skyline_notify:Alert", "LSPD - Ortung" , "Verbinndung zum Fahrzeug <b>" .. plate .. "</b> hergestellt!" , 2000 , "police")
        Citizen.CreateThread(function()
            while time_out[plate] == false do
                Wait(50)

                if DoesEntityExist(vehicle) then 
           

                    local x, y, z = table.unpack(GetEntityCoords(vehicle))
         

                    if prev_pos == table.unpack(GetEntityCoords(vehicle)) then 
                
                    else 


                        RemoveBlip(blips_pos[plate])
 
                        local new_pos_blip = AddBlipForCoord(x,y,z)
      
                        SetBlipSprite(new_pos_blip, 432)
                        SetBlipDisplay(new_pos_blip, 4)
                        SetBlipColour(new_pos_blip, 75)
                        SetBlipScale(new_pos_blip, 1.0)


                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString("Fahrzeug: " .. plate)
                        EndTextCommandSetBlipName(new_pos_blip)

    
                        blips_pos[plate] = new_pos_blip
                        prev_pos = table.unpack(GetEntityCoords(vehicle))
                    end

                else
                    time_out[plate] = time_out[nil]
                    TriggerServerEvent("skyline_tracker:removeActivePlate", plate)
                    TriggerEvent("skyline_notify:Alert", "LSPD - Ortung" , "Verbinndung zum Fahrzeug <b>" .. plate .. "</b> verloren!" , 3500 , "police")
                end
            end 
            RemoveBlip(blips_pos[plate])
            time_out[plate] = time_out[nil]
            TriggerServerEvent("skyline_tracker:removeActivePlate", plate)
            TriggerEvent("skyline_notify:Alert", "LSPD - Ortung" , "Verbinndung zum Fahrzeug <b>" .. plate .. "</b> verloren!" , 3500 , "police")
    
        end)
end 



