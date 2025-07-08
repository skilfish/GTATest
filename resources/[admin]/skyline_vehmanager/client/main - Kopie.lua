

SKYLINE = nil

Citizen.CreateThread(function()
	while SKYLINE == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
		Citizen.Wait(0)
	end
end)


local NumberCharset = {}
local Charset = {}

PlateLetters  = 3
PlateNumbers  = 3
PlateUseSpace = true

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end



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

		SKYLINE.TriggerServerCallback('idkfahrzeugeverwalten11:isPlateTaken', function(isPlateTaken)
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



TriggerEvent('chat:addSuggestion', '/givecar', 'Gebe ein Auto einen Spieler', {
	{ name="id", help="ID" },
    { name="vehicle", help="Welches Modell?" },
    { name="<plate>", help="Kennzeichen, leer lassen wenn ein zufälliges genommen werden soll" }
})

TriggerEvent('chat:addSuggestion', '/giveplane', 'Ein Flugzeug/Helikopter einen Spieler geben', {
	{ name="id", help="ID" },
    { name="vehicle", help="Welches Modell?" },
    { name="<plate>", help="Kennzeichen, leer lassen wenn ein zufälliges genommen werden soll" }
})

TriggerEvent('chat:addSuggestion', '/giveboat', 'Give a boat to player', {
	{ name="id", help="ID" },
    { name="vehicle", help="Welches Modell?" },
    { name="<plate>", help="Kennzeichen, leer lassen wenn ein zufälliges genommen werden soll" }
})

TriggerEvent('chat:addSuggestion', '/giveheli', 'Give a helicopter to player', {
	{ name="id", help="ID" },
    { name="vehicle", help="Welches Modell?" },
    { name="<plate>", help="Kennzeichen, leer lassen wenn ein zufälliges genommen werden soll" }
})

TriggerEvent('chat:addSuggestion', '/delcarplate', 'Delete a owned vehicle by plate number', {
	{ name="plate", help="Vehicle's plate number" }
})

RegisterNetEvent('idkfahrzeugeverwalten11:spawnVehicle')
AddEventHandler('idkfahrzeugeverwalten11:spawnVehicle', function(playerID, model, playerName, type, vehicleType)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local carExist  = false

	SKYLINE.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) --get vehicle info
		if DoesEntityExist(vehicle) then
			carExist = true
			SetEntityVisible(vehicle, false, false)
			SetEntityCollision(vehicle, false)
			
			local newPlate     = GeneratePlate()
			SetVehicleNumberPlateText(vehicle, newPlate)
			local vehicleProps = SKYLINE.Game.GetVehicleProperties(vehicle)
			vehicleProps.plate = newPlate
			TriggerServerEvent('idkfahrzeugeverwalten11:setVehicle', vehicleProps, playerID, vehicleType)
			TriggerEvent("skyline_notify:Alert", 1 , "ADMIN-SYSTEM" , "<b style=color:green;>Fahrzeug erfolgreich an " .. playerName .. " gegeben.</b> <span style=color:yellow;>(Fahrzeug Infos: Modell: " .. model .. " Kennzeichen: " .. newPlate .. ")" , 4000 , "success")
			SKYLINE.Game.DeleteVehicle(vehicle)	
			if type ~= 'console' then
			
			else
				local msg = ('addCar: ' ..model.. ', plate: ' ..newPlate.. ', toPlayer: ' ..playerName)
				TriggerServerEvent('idkfahrzeugeverwalten11:printToConsole', msg)
			end				
		end		
	end)
	
	Wait(2000)
	if not carExist then
		if type ~= 'console' then
			TriggerEvent("skyline_notify:Alert", 1 , "ADMIN-SYSTEM" , "<b style=color:red;>Modell wurde nicht gefunden!" , 3000 , "error")
		else
			TriggerServerEvent('idkfahrzeugeverwalten11:printToConsole', "ERROR: "..model.." is an unknown Welches Modell?")
		end		
	end
end)

RegisterNetEvent('idkfahrzeugeverwalten11:spawnVehiclePlate')
AddEventHandler('idkfahrzeugeverwalten11:spawnVehiclePlate', function(playerID, model, plate, playerName, type, vehicleType)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local generatedPlate = string.upper(plate)
	local carExist  = false

	SKYLINE.TriggerServerCallback('idkfahrzeugeverwalten11:isPlateTaken', function (isPlateTaken)
		if not isPlateTaken then
			SKYLINE.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) --get vehicle info	
				if DoesEntityExist(vehicle) then
					carExist = true
					SetEntityVisible(vehicle, false, false)
					SetEntityCollision(vehicle, false)	
					
					local newPlate     = string.upper(plate)
					local vehicleProps = SKYLINE.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					TriggerServerEvent('idkfahrzeugeverwalten11:setVehicle', vehicleProps, playerID, vehicleType)
					SKYLINE.Game.DeleteVehicle(vehicle)
					if type ~= 'console' then
						TriggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "<b style=color:green;>Fahrzeug erfolgreich an " .. playerName .. " gegeben.</b> <span style=color:yellow;>(Fahrzeug Infos: Modell: " .. model .. " Kennzeichen: " .. newPlate .. ")" , 4000 , "success")
					else
						local msg = ('addCar: ' ..model.. ', plate: ' ..newPlate.. ', toPlayer: ' ..playerName)
						TriggerServerEvent('idkfahrzeugeverwalten11:printToConsole', msg)
					end				
				end
			end)
		else
			carExist = true
			TriggerEvent("skyline_notify:Alert", 1 , "ADMIN-SYSTEM" , "<b style=color:red;>Kennzeichen ist bereits vergeben!" , 3000 , "error")				
		end
	end, generatedPlate)
	
	Wait(2000)
	if not carExist then
		if type ~= 'console' then
			TriggerEvent("skyline_notify:Alert", 1 , "ADMIN-SYSTEM" , "<b style=color:red;>Modell wurde nicht gefunden!" , 3000 , "error")
		else
			TriggerServerEvent('idkfahrzeugeverwalten11:printToConsole', "ERROR: "..model.." is an unknown Welches Modell?")
		end		
	end	
end)