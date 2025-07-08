local ESX	 = nil
local currLevel = 2
local isTokovoip = false
local isShow = true 
-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	DisplayRadar(true)
end)

Citizen.CreateThread(function()
    while true do 

        if isShow and exports["skyline_ffa"]:isInFFA() then 
            isShow = false 
            SendNUIMessage({action = "hideH"})
        end 

        if not isShow and not exports["skyline_ffa"]:isInFFA() then 
            isShow = true 
            SendNUIMessage({action = "showH"})
        end 

        Citizen.Wait(1000)
    end 
end)

function getMapPosition()
	local minimap = {}
	local resX, resY = GetActiveScreenResolution()
	local aspectRatio = GetAspectRatio()
	local scaleX = 1/resX
	local scaleY = 1/resY
	local minimapRawX, minimapRawY
	SetScriptGfxAlign(string.byte('L'), string.byte('B'))
	if IsBigmapActive() then
		minimapRawX, minimapRawY = GetScriptGfxPosition(-0.003975, 0.022 + (-0.460416666))
		minimap.width = scaleX*(resX/(2.52*aspectRatio))
		minimap.height = scaleY*(resY/(2.3374))
	else
		minimapRawX, minimapRawY = GetScriptGfxPosition(-0.0045, 0.002 + (-0.188888))
		minimap.width = scaleX*(resX/(4*aspectRatio))
		minimap.height = scaleY*(resY/(5.674))
	end
	ResetScriptGfxAlign()
	minimap.leftX = minimapRawX
	minimap.rightX = minimapRawX+minimap.width
	minimap.topY = minimapRawY
	minimap.bottomY = minimapRawY+minimap.height
	minimap.X = minimapRawX+(minimap.width/2)
	minimap.Y = minimapRawY+(minimap.height/2)
	return minimap
end


Citizen.CreateThread(function()
    while true do
        SendNUIMessage({action = "rescale" , val = getMapPosition().rightX})
        Citizen.Wait(1000)
    end 
end)

-- Remove MiniMap HealthBar

function checkMini()
    if not exports["skyline_ffa"]:isInFFA() then 
        local minimap = RequestScaleformMovie("minimap")
        SetRadarBigmapEnabled(true, false)
        Wait(0)
        SetRadarBigmapEnabled(false, false)

        while true do
            Wait(0)

        if exports["skyline_ffa"]:isInFFA() then 
            checkMini()
            break
        end 

        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
        end
    else 
        local minimap = RequestScaleformMovie("minimap")
        SetRadarBigmapEnabled(true, false)
        Wait(0)
        SetRadarBigmapEnabled(false, false)

        while true do 
            Wait(0)
            if not exports["skyline_ffa"]:isInFFA() then 
                checkMini()
                break
            end     
        end 

    end 
end 

Citizen.CreateThread(function()
    if not exports["skyline_ffa"]:isInFFA() then 
        local minimap = RequestScaleformMovie("minimap")
        SetRadarBigmapEnabled(true, false)
        Wait(0)
        SetRadarBigmapEnabled(false, false)

        while true do
            Wait(0)

        if exports["skyline_ffa"]:isInFFA() then 
            checkMini()
            break
        end 

        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
        end
    else 
        local minimap = RequestScaleformMovie("minimap")
        SetRadarBigmapEnabled(true, false)
        Wait(0)
        SetRadarBigmapEnabled(false, false)
        checkMini()

    end 

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local health = (GetEntityHealth(GetPlayerPed(-1)) -100)
		local armor = GetPedArmour(GetPlayerPed(-1)) 
	
		SendNUIMessage({action = "hud",
						health = health,
						armor = armor,
						thirst = thrist,
						hunger = hunger,
						})

		TriggerEvent('statusundso:getStatus', 'thirst', function(status)
			thrist = status.getPercent()
		end)
		
		TriggerEvent('statusundso:getStatus', 'hunger', function(status)
			hunger = status.getPercent()
		end)
	end
end)


Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(200)

        if not exports["skyline_ffa"]:isInFFA() then
            if IsPauseMenuActive() then 
                SendNUIMessage({action = "hide"})
            else 
                SendNUIMessage({action = "show"})
            end 
        end 

	

	end 
end)




--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local ped = GetPlayerPed(-1)
		
		if IsPedInAnyVehicle(ped, false) then
			DisplayRadar(true)
			local inCar = GetVehiclePedIsIn(ped, false)
			carSpeed = math.ceil(GetEntitySpeed(inCar) * 1.23)
			fuel = math.floor(GetVehicleFuelLevel(inCar)+0.0)	
			SendNUIMessage({
				action = 'car',
				showhud = true,
				speed = carSpeed,
				fuel = fuel,
			})
		else
			DisplayRadar(false)
			SendNUIMessage({
				action = 'car',
				showhud = false,
			})
		end
	end
end)


RegisterNetEvent("seatbelt:client:ToggleSeatbelt")
AddEventHandler("seatbelt:client:ToggleSeatbelt", function(toggle)
    if toggle == nil then
        seatbeltOn = not seatbeltOn
        SendNUIMessage({
            action = "seatbelt",
            seatbelt = seatbeltOn,
        })
    else
        seatbeltOn = toggle
        SendNUIMessage({
            action = "seatbelt",
            seatbelt = toggle,
        })
    end
end)--]]