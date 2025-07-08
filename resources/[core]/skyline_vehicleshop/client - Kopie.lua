SKYLINE = nil
curGarage = nil
vehicle = nil
rgb = {}
spawnedVehs = {}
local currentShop = nil
curVehName = ""
 
Citizen.CreateThread(function()
    while SKYLINE == nil do
        TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
        SetEntityVisible(PlayerPedId(), 1)
        Citizen.Wait(0)
    end

    for k,va in pairs(Config.Vehicles) do 
        for i,v in pairs(Config.Vehicles[k]) do
          if k == "super" then 
            v.fuel = math.random(80, 100)
            v.consumption = 3
            v.trunk = Config.TrunkCapacity
         elseif k == "vans" then 
            v.fuel = math.random(80, 100)
            v.consumption = 2
            v.trunk = Config.TrunkVanCapacity
         else 
            v.fuel = math.random(80, 100)
            v.consumption = 1
            v.trunk = Config.TrunkCapacity
         end
        end
    end
	
	for i,v in pairs(Config.Shops) do 
	   blip = AddBlipForCoord(v.coord.x, v.coord.y, v.coord.z)
       SetBlipSprite(blip, v.logo)
       SetBlipDisplay(blip, 4)
       SetBlipScale(blip, 0.7)
       SetBlipColour(blip, v.color)
       SetBlipAsShortRange(blip, true)
       BeginTextCommandSetBlipName("STRING")
       AddTextComponentString(v.name)
       EndTextCommandSetBlipName(blip)
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

		SKYLINE.TriggerServerCallback('skyline_vehicleshop:isPlateTaken', function(isPlateTaken)
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

function IsPlateTaken(plate)
	local callback = 'waiting'

	SKYLINE.TriggerServerCallback('skyline_vehicleshop:isPlateTaken', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
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

Citizen.CreateThread(function() 
     while 1 > 0 do 
      sleepThread = 2000
      PlayerData = SKYLINE.GetPlayerData()
      plyCoords = GetEntityCoords(PlayerPedId())
      
      for k,v in pairs(Config.Shops) do
         if GetDistanceBetweenCoords(plyCoords, v.coord)  <= v.dist then 
            sleepThread = 0
            auth = false
            if v.job == false then 
               DrawText3D(v.coord.x , v.coord.y  , v.coord.z, '[E] - '..v.name)
               auth = true
            elseif v.job == PlayerData.job.name then 
               DrawText3D(v.coord.x , v.coord.y  , v.coord.z, '[E] - '..v.name)
               auth = true
            end

            if auth == true and IsControlJustPressed(1, 38) and GetDistanceBetweenCoords(plyCoords, v.coord) <= 1.5 then 
               initGarage(k)
               currentShop = Config.Shops[k].name
               Wait(1500)
            end
         end
      end
      Citizen.Wait(sleepThread)
     end
end)
cam = nil
function initGarage(x)
   curGarage = Config.Shops[x]
   SetEntityVisible(PlayerPedId(), 0)
   cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
   SetCamCoord(cam, curGarage.camCoord)
   SetCamRot(cam, curGarage.camRot, 2)
   SetCamActive(cam, true)
   RenderScriptCams(true, true, 1)
   SendNUIMessage({ action = "load", garage = curGarage })
   SetNuiFocus(1, 1)
   DisplayRadar(0)
end

function destroyCam()
    if DoesCamExist(cam) then
        DestroyCam(cam, true)
        RenderScriptCams(false, true, 1)
        cam = nil
    end
end

RegisterNUICallback("close", function(data, cb)
    --SetPedCoordsKeepVehicle(PlayerPedId(), curGarage.coord)
	SetEntityCoords(PlayerPedId(), curGarage.coord)
	DisplayRadar(1)
    SetNuiFocus(0, 0)
    destroyCam()
    SetEntityVisible(PlayerPedId(), 1)
    deleteLastCar() 
end)


RegisterNUICallback("testdrive", function(data, cb)
    SetNuiFocus(0, 0)
	SetEntityVisible(PlayerPedId(), 1)
    destroyCam()
    startTestDrive()
end)

isTestDriving = false
function startTestDrive(dealer_object)
    if isTestDriving then
        return
    end
    if vehicle and DoesEntityExist(vehicle) then
        FreezeEntityPosition(vehicle,false)
        SetVehicleUndriveable(vehicle,false)
		SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
        SetPedCoordsKeepVehicle(PlayerPedId(), Config.TestDrive.coords)
		SendNUIMessage({ action = "startTest" })
    end
    local finished = nil
    CreateThread(function()
        local start = GetGameTimer()/1000
        while GetGameTimer()/1000 - start < Config.TestDrive.seconds and DoesEntityExist(vehicle) and not IsEntityDead(PlayerPedId()) do
            if #(GetEntityCoords(PlayerPedId()) - Config.TestDrive.coords) > Config.TestDrive.range then
                SetPedCoordsKeepVehicle(PlayerPedId(), Config.TestDrive.coords)
            end
            if GetVehiclePedIsIn(PlayerPedId(), false) == 0 and DoesEntityExist(vehicle) then
                SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
            end
            Wait(1000)
        end
        SetPedCoordsKeepVehicle(PlayerPedId(), curGarage.carSpawnCoord)
        FreezeEntityPosition(vehicle, true)
        SetVehicleUndriveable(vehicle, true)
        ClearPedTasksImmediately(PlayerPedId())
        SetEntityCoords(PlayerPedId(), curGarage.coord)
        finished = true
		SendNUIMessage({ action = "stopTest" })
		deleteLastCar() 
        DisplayRadar(1)
    end)
    while finished == nil or not finished do
        Wait(0)
    end
    return
end



RegisterNUICallback("moveright", function(data)
	moveCarRight(2)
end)

RegisterNUICallback("moveleft", function(data)
	moveCarLeft(2)
end)


RegisterNUICallback("buy", function(data, cb)
    blackMoney = data.blackMoney
    local PlayerPed = PlayerPedId()
    local veh = getVehicleFromName(curVehName)
    local plate = GeneratePlate()
	SKYLINE.TriggerServerCallback("skyline_vehicleshop:checkPrice", function(pg)  
        if pg == true then 
            Citizen.CreateThread(function() 
                RequestModel(GetHashKey(veh.name))
                while not HasModelLoaded(GetHashKey(veh.name)) do
                   Wait(1000)
                end
                local xVehicle = CreateVehicle(veh.name, curGarage.deliveryCoord, true, false)
                SetVehicleNumberPlateText(xVehicle, plate)
                 SetVehicleCustomPrimaryColour(xVehicle, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
                 SetVehicleCustomSecondaryColour(xVehicle, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
                SetPedIntoVehicle(PlayerPed, xVehicle, -1)
                Wait(500)
                TriggerEvent("skyline_notify:Alert", "AUTO-SHOP" , "Fahrzeug erfolgreich gekauft." , 3000 , "success")
                TriggerServerEvent('skyline_vehicleshop:server:givecar', SKYLINE.Game.GetVehicleProperties(xVehicle))
                rgb = {}
				DisplayRadar(1)
                SetNuiFocus(0, 0)
                destroyCam()
                SetEntityVisible(PlayerPed, 1)
                deleteLastCar() 
           end)
           Wait(500)
           cb(pg) 
        else 
           cb(false)
        end 
    end, { price = veh.price, blackMoney = blackMoney , name = veh.label , shop = currentShop })
end)

-- RegisterNUICallback('buy', function(data, cb)
--     local PlayerPed = PlayerPedId()
--     blackMoney = data.blackMoney 
--     SKYLINE.TriggerServerCallback('skyline_vehicleshop:checkPrice', function(pg)
--         local veh = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
--         if pg == true then
--             Citizen.CreateThread(function()
--                 RequestModel(GetHashKey(veh))
--                 while not HasModelLoaded(GetHashKey(veh)) do
--                     Citizen.Wait(2000)
--                 end
--                 local xVehicle = CreateVehicle(GetHashKey(veh), curGarage.deliveryCoord, true, true)
--                 local VehicleProps = SKYLINE.Game.GetVehicleProperties(xVehicle)
--                 SetPedIntoVehicle(PlayerPed, xVehicle, -1)
--                 SetVehicleNumberPlateText(xVehicle, GetVehicleNumberPlateText(vehicle))
--                 SetVehicleCustomPrimaryColour(xVehicle, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
--                 SetVehicleCustomSecondaryColour(xVehicle, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
--                 TriggerServerEvent('skyline_vehicleshop:server:givecar', VehicleProps)
--                 rgb = {}
--                 DisplayRadar(1)
--                 SetNuiFocus(0, 0)
--                 destroyCam()
--                 SetEntityVisible(PlayerPed, 1)
--                 deleteLastCar() 
--             end)
--             Citizen.Wait(20)
--             cb(pg) 
--         else
--             cb(false)
--         end
--     end, { price = 100, blackMoney = blackMoney })
-- end)

function getVehicleFromName(x)
   for k,va in pairs(curGarage.Vehicles) do 
      for i,v in pairs(curGarage.Vehicles[k]) do
         if v.name == x then 
            return v
         end
      end
   end
end
 
RegisterNUICallback("checkPlatePrice", function(data, cb)
    plate = data.plate 
	SKYLINE.TriggerServerCallback("skyline_vehicleshop:checkPlatePrice", function(pg)  cb(pg) if pg == true then SetVehicleNumberPlateText(vehicle, plate) end end, plate)
end)

function moveCarRight(value)
    if vehicle and DoesEntityExist(vehicle) then
        SetEntityRotation(vehicle, GetEntityRotation(vehicle) + vector3(0,0,value), false, false, 2, false)
    end
end

function moveCarLeft(value)
    if vehicle and DoesEntityExist(vehicle) then
        SetEntityRotation(vehicle, GetEntityRotation(vehicle) - vector3(0,0,value), false, false, 2, false)
    end
end
 
RegisterNUICallback("setcolour", function(data)
	if DoesEntityExist(vehicle) then
        rgb = data.rgb
		SetVehicleCustomPrimaryColour(vehicle, tonumber(data.rgb.r), tonumber(data.rgb.g), tonumber(data.rgb.b))
	end
end)
 
RegisterNUICallback("showCar", function(data, cb) showCar(data.name) end)
 
function deleteLastCar() 
    for i,v in pairs(spawnedVehs) do
       if DoesEntityExist(v) then
          DeleteEntity(v)
       end
       table.remove(spawnedVehs, i)
    end
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
        vehicle = nil
    end
end
 
function showCar(modelName)
    local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))
    
	Citizen.CreateThread(function()
 
        deleteLastCar() 

		local modelHash = model
        modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

        if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
            RequestModel(modelHash)
    
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(1)
            end
        end

        
		vehicle = CreateVehicle(model, curGarage.carSpawnCoord, false, false)
        curVehName = modelName
		SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
        table.insert(spawnedVehs, vehicle)
		local timeout = 0

		SetEntityAsMissionEntity(vehicle, true, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetVehRadioStation(vehicle, 'OFF')
		SetModelAsNoLongerNeeded(model)
		RequestCollisionAtCoord(curGarage.carSpawnCoord.x, curGarage.carSpawnCoord.y, curGarage.carSpawnCoord.z)

		while not HasCollisionLoadedAroundEntity(vehicle) and timeout < 2000 do
			Citizen.Wait(0)
			timeout = timeout + 1
		end

		if cb then
			cb(vehicle)
		end
	end)
end


 


 

function DrawText3D(x, y, z, text)
	SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 250
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end