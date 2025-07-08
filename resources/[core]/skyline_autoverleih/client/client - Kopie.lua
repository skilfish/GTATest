local display = false
local spielermoney = 0
local firstspawn = false
local isinrent = 0
SKYLINE                           = nil
local locked = false

Citizen.CreateThread(function()
	while SKYLINE == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
		Citizen.Wait(0)
	end
end)


RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNetEvent('autoverleihdufotze:antwort')
AddEventHandler('autoverleihdufotze:antwort', function(_meingeld)
    spielermoney = _meingeld
end)


RegisterNetEvent('autoverleihdufotze:antwortrent')
AddEventHandler('autoverleihdufotze:antwortrent', function(_baller4, _blista)
    baller4 = _baller4
    blista = _blista
end)

RegisterNUICallback("main", function(data)
    TriggerServerEvent("autoverleihdufotze:genuggeld")
    TriggerServerEvent("autoverleihdufotze:antwortrentabfragen")
    local playerPed = GetPlayerPed(-1)
    local rechnung = data.bezahlen
    local bike = data.fahrrad
    local renttime = data.bezahlen/1250    
    
    if spielermoney >= data.bezahlen  then
        if bike == "baller4" and rs7rent == true then
            ShowAboveRadarMessage("[Mietwagen GmbH]  Der Baller ist zurzeit auf den Straßen unterwegs.")
        elseif bike == "BLISTA" and blista == true then
            ShowAboveRadarMessage("[Mietwagen GmbH]  Der Blista ist zurzeit auf den Straßen unterwegs.")
        else
            if isinrent < 1 then 
                SetEntityHeading(playerPed, Config.SpawnHeading)
                SetEntityCoords(playerPed, Config.SpawnAutoX, Config.SpawnAutoY, Config.SpawnAutoZ, false, false, false, true)
                TriggerServerEvent("autoverleihdufotze:bezahlen", data.bezahlen)
                TriggerEvent('skyline:spawnVehicle', bike)
                isinrent = isinrent + 1
                TriggerServerEvent("autoverleihdufotze:rented", bike, true)
                SetDisplay(false)
                Citizen.Wait(500)
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetVehicleNumberPlateText(vehicle, Config.FahrzeugKennzeichen)
                ShowAboveRadarMessage("Du hast dir ein " .. string.upper(bike) .. " für " .. renttime .. " minuten ausgeliehen. Rechnung: $" .. rechnung)
                Citizen.Wait(renttime*50000) --renttime
                DisplayHelpText("Dein Mietvertrag für dein " .. string.upper(bike) .. " läuft bald aus!")
                Citizen.Wait(renttime*10000) --renttime
                DisplayHelpText("Dein Mietvertrag für dein " .. string.upper(bike) .. " läuft in 1 Minute aus!")
                Citizen.Wait(60000)
                SetEntityAsMissionEntity(vehicle, true, true)
                DeleteVehicle(vehicle)
                DisplayHelpText("Dein Mietvertrag für dein " .. string.upper(bike) .. " ist ausgelaufen!")
                TriggerServerEvent("autoverleihdufotze:rented", bike, false)
                isinrent = isinrent - 1
            else
                ShowAboveRadarMessage("Wir vermieten maximal 1 Fahrzeug pro Person")
                SetDisplay(false)
            end      
        end
    else
        ShowAboveRadarMessage("Dafür hast du zu wenig Geld")
        SetDisplay(false)
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

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

function DisplayHelpText(str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentScaleform(str)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped),  Config.VerleihX, Config.VerleihY , Config.VerleihZ, true) < 2 then

                    if IsControlJustReleased(1, 51) then
                        TriggerServerEvent("autoverleihdufotze:antwortrentabfragen")
                        TriggerServerEvent("autoverleihdufotze:genuggeld")
                        SetDisplay(not display)
                    end
            end
        end
 end)
    

Citizen.CreateThread(function()
    local hash = GetHashKey("u_m_y_baygor")
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Citizen.Wait(100)
    end
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
    if firstspawn == false then
        local npc = CreatePed(6, hash, Config.VerleihX, Config.VerleihY , Config.VerleihZ, Config.PedHeading, false, false)
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        SetPedDiesWhenInjured(npc, false)
        SetPedCanRagdollFromPlayerImpact(npc, false)
        SetPedCanRagdoll(npc, false)
        SetEntityAsMissionEntity(npc, true, true)
        SetEntityDynamic(npc, true)
		SetBlockingOfNonTemporaryEvents(npc, true)
    end
end)
      
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(Config.Blip.Blip.Pos)
    local blipname = Config.Blip.Blip.Name

	SetBlipSprite (blip, 326)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.7)
	SetBlipAsShortRange(blip, true)
    SetBlipColour(blip ,0)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(blipname)
	EndTextCommandSetBlipName(blip)
end)




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if isinrent >= 1 then
            local ped = GetPlayerPed(-1)
            local vehicleped = GetLastDrivenVehicle(ped)
            local platetext = GetVehicleNumberPlateText(vehicleped)
            if IsControlPressed(0,182) then
                if string.match(platetext, Config.FahrzeugKennzeichen) then
                    if locked == true then                   
                        SetVehicleDoorsLocked(vehicleped, 0)
                        locked = false
                        print('unlocked')
                        ShowAboveRadarMessage("Du hast deinen Mietwagen aufgesperrt")
                    else
                        SetVehicleDoorsLocked(vehicleped, 2)
                        locked = true
                        ShowAboveRadarMessage("Du hast deinen Mietwagen zugesperrt")
                    end
                else
                end
            end
        end
    end
  end)


  function ShowAboveRadarMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end
