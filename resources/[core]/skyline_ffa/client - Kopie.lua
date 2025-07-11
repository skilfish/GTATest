ESX = nil 
Citizen.CreateThread(function() 
while ESX == nil do 
--TriggerEvent('' .. Config.GetShared .. '', function(obj) ESX = obj end) 
TriggerEvent('skylineistback:getSharedObject', function(obj) ESX = obj end)
Citizen.Wait(0) 
end 
end)

local kills = 0
local deaths = 0

local isDead = false
local istInDimension = false

local display = false
local isMenuOpen = false
local notify = false
local hasRun = false
local isDead = false


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(24)
  
        if (not isDead and NetworkIsPlayerActive(PlayerId()) and IsPedFatallyInjured(PlayerPedId())) then
            isDead = true
            DisableControlAction(   46, true)
        elseif (isDead and NetworkIsPlayerActive(PlayerId()) and not IsPedFatallyInjured(PlayerPedId())) then
            isDead = false
            EnableControlAction(   46, true)
        end
    end
  end)

  RegisterCommand("quitffa", function ()
    if istInDimension and not isDead then
    Citizen.CreateThread(function (dimension)
    local dimension = Config.Teleports.standart.dimension
    SetEntityCoords(GetPlayerPed(-1), Config.marker, false, false, false, false)
    TriggerServerEvent('dunutte::setDimension', dimension)
    TriggerServerEvent('dunutte::saveInfo', kills, deaths)
    TriggerEvent('removeloadout')
    TriggerServerEvent('removein')
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(GetPlayerPed(-1), true, true)
    drinnen = false
    end)
end
end, false)


Citizen.CreateThread(function()
Citizen.Wait(2500)
ESX.TriggerServerCallback('getInfo', function(info)
        if info[1].kills ~= nil then
    kills = info[1].kills 
    deaths = info[1].deaths
    end
end)
end)

RegisterNetEvent("dunutte::addKill")
AddEventHandler("dunutte::addKill", function()
  kills = kills + 1
end)

RegisterNetEvent("dunutte::addDeath")
AddEventHandler("dunutte::addDeath", function()
deaths = deaths + 1
end)



Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        DrawMarker(1, Config.marker.x,Config.marker.y,Config.marker.z -1, 0, 0, 0, 0, 0, 0, 1.1, 1.1, 1.1, 0, 0, 255, 145, false, false, 2, false, nil, nil, false)
            if GetDistanceBetweenCoords(coords, Config.marker, true) <= 0.75 then
                ESX.ShowHelpNotification(Config.EnterMessage)
              if IsControlJustReleased(0, 38) and not isMenuOpen then
                        OpenMenu()
              end
            end
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(10)
            if istInDimension then     
            DisableControlAction(0, 47, true) -- G
			DisableControlAction(0, 29, true) -- B
        end
        end
    end)

function TeleportSP(coords, dimension) -- SKATEPARK
    local coords = Config.Teleports.pr.spawnpoints[math.random(#Config.Teleports.pr.spawnpoints)]  
    local dimension = Config.Teleports.pr.dimension 
    SetEntityCoords(GetPlayerPed(-1), coords, false, false, false, false)
    TriggerServerEvent('dunutte::setDimension', dimension)
    TriggerEvent('loadout')
end

function TeleportWP(coords, dimension) -- WUERFELPARK
    local coords = Config.Teleports.wp.spawnpoints[math.random(#Config.Teleports.wp.spawnpoints)]
    local dimension = Config.Teleports.wp.dimension 
    SetEntityCoords(GetPlayerPed(-1), coords, false, false, false, false)
    TriggerServerEvent('dunutte::setDimension', dimension)
    TriggerEvent('loadout')
end

function TeleportPR(coords, dimension) -- PRISON
    local coords = Config.Teleports.sg.spawnpoints[math.random(#Config.Teleports.sg.spawnpoints)]
    local dimension = Config.Teleports.sg.dimension 
    SetEntityCoords(GetPlayerPed(-1), coords, false, false, false, false)
    TriggerServerEvent('dunutte::setDimension', dimension)
    TriggerEvent('loadout')
end

function TeleportFR(coords, dimension) -- FLUEGZEUGHAFEN
    local coords = Config.Teleports.fr.spawnpoints[math.random(#Config.Teleports.fr.spawnpoints)]
    local dimension = Config.Teleports.fr.dimension 
    SetEntityCoords(GetPlayerPed(-1), coords, false, false, false, false)
    TriggerServerEvent('dunutte::setDimension', dimension)
    TriggerEvent('loadout')
end

function OpenMenu()
    ESX.TriggerServerCallback('getpindi', function(count)
        local eins = count.eins
        local zwei = count.zwei
        local drei = count.drei
        local vier = count.vier
        
         
  
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'general_menu', {
        title = "FFA",
        align = "right",
        elements = {
            {label = "Würfelpark | " .. zwei .. "/20", value='teleport_wuerfelpark'},
            {label = "Trailerpark | " .. drei .. "/20", value='teleport_skatepark'},
            {label = "Prison | " .. eins .. "/20", value='teleport_prison'},
            {label = "Flugzeugfriedhof | " .. vier .. "/20", value='teleport_fluegzeug'},
        }
    }, function (data, menu)
        ESX.UI.Menu.CloseAll()
            RemoveAllPedWeapons(GetPlayerPed(-1), true)

            if data.current.value == 'teleport_wuerfelpark' then

                    if count.zwei < 20 then
                        TriggerServerEvent('insertin')
                        TeleportWP() --wuerfelpark
                        DisplayPoints()
                    elseif count.zwei >= 20 then
                        TriggerEvent('skyline_notify:Alert', 'FFA', 'Es sind bereits 20 Personen in dieser FFA-Arena' , 4000 , "error")
                    end
                
                
                
            end
            if data.current.value == 'teleport_skatepark' then
                
               
                    if count.drei < 20 then
                        TriggerServerEvent('insertin')
                        TeleportSP() --skatepark
                        DisplayPoints()
                    elseif count.drei >= 20 then
                        TriggerEvent('skyline_notify:Alert', 'FFA', 'Es sind bereits 20 Personen in dieser FFA-Arena' , 4000 , "error")
                    end
               
            
            end
            if data.current.value == 'teleport_fluegzeug' then
                
               
                if count.vier < 20 then
                    TriggerServerEvent('insertin')
                    TeleportFR() --flugzeug
                    DisplayPoints()
                elseif count.vier >= 20 then
                    TriggerEvent('skyline_notify:Alert', 'FFA', 'Es sind bereits 20 Personen in dieser FFA-Arena' , 4000 , "error")
                end
           
        
        end
            if data.current.value == 'teleport_prison' then
                
                    if count.eins < 20 then
                        TriggerServerEvent('insertin')

                        TeleportPR() --prison
                        DisplayPoints()
                    elseif count.eins >= 20 then
                        TriggerEvent('skyline_notify:Alert', 'FFA', 'Es sind bereits 20 Personen in dieser FFA-Arena' , 4000 , "error")
                    end
               

            end
            
        
        
        
    end, 
    function (data, menu) 
        menu.close()
        
    end)

end)
end

AddEventHandler('skyline:onPlayerDeath', function(data)
    if istInDimension then
    TriggerServerEvent('killed', data.killerServerId)
    Citizen.Wait(4000)

    for k, v in pairs(Config.Teleports) do
        if GetDistanceBetweenCoords(v.spawnpoints[1], GetEntityCoords(GetPlayerPed(-1)), true) <= 200.0  then
            local coords = v.spawnpoints[math.random(#v.spawnpoints)]
            SetEntityCoords(GetPlayerPed(-1), coords, false, false, false, false) 
        end
    end
    TriggerEvent('lsmdistgay:revive')
    TriggerEvent('weapontrigger')
    TriggerEvent('weapontrigger2')
    TriggerEvent('weapontrigger3')
    AddArmourToPed(PlayerPedId(-1), 200)
    SetEntityHealth(PlayerPedId(-1), 200)
    SetPedArmour(PlayerPedId(-1), 200)
    NetworkSetFriendlyFireOption(false)
    SetCanAttackFriendly(GetPlayerPed(-1), false, false)
    --SetEntityInvincible(GetPlayerPed(-1), true)
    Citizen.Wait(3000)
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(GetPlayerPed(-1), true, true)
    AddAmmoToPed(PlayerPedId(-1), 0x61012683, 700)
    AddAmmoToPed(PlayerPedId(-1), 0xAF113F99, 700)
    AddAmmoToPed(PlayerPedId(-1), 0x83BF0278, 700)
    AddAmmoToPed(PlayerPedId(-1), 0x22D8FE39, 700)
    AddAmmoToPed(PlayerPedId(-1), 0xD205520E, 700)
    --SetEntityInvincible(GetPlayerPed(-1), false)
    end
end)



RegisterNetEvent('ffahud:off')
AddEventHandler('ffahud:off', function()
    SendNUIMessage({
        status = false,
        plinks = -1,
        prechts = -1,
        bombe = -1,
    })

end)

local blips = {
    {title="FFA", scale=0.9, colour=43, id=433, x =  396.7939, y = -1171.1233, z = 29.3978}
 }


Citizen.CreateThread(function(name)
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

local firstspawn = true
AddEventHandler('playerSpawned', function(spawn)
if not firstspawn then
    firstspawn = true
    while GetEntityModel(GetPlayerPed(-1)) ~= 1885233650 do
    Citizen.Wait(200)
      
    end
    ESX.TriggerServerCallback('isIn', function(bool) 
        
        if bool then
            
            RemoveAllPedWeapons(GetPlayerPed(-1), false)
        end
    end)
end
end)
-- WICHTIG !! ZONE

local function insidePolygon( point)
    local oddNodes = false
    for i = 1, #Config.Zones do
        local Zone = Config.Zones[i]
        local j = #Zone
        for i = 1, #Zone do
            if (Zone[i][2] < point.y and Zone[j][2] >= point.y or Zone[j][2] < point.y and Zone[i][2] >= point.y) then
                if (Zone[i][1] + ( point[2] - Zone[i][2] ) / (Zone[j][2] - Zone[i][2]) * (Zone[j][1] - Zone[i][1]) < point.x) then
                    oddNodes = not oddNodes;
                end
            end
            j = i;
        end
    end
    return oddNodes 
end

RegisterNetEvent('heal')
AddEventHandler('heal', function ()
    TriggerEvent('weapontrigger2')
    TriggerEvent('weapontrigger3')
    SetPedArmour(PlayerPedId(), 200)
    SetEntityHealth(PlayerPedId(), 200)
end) 


Citizen.CreateThread(function()
    while true do
        local iPed = PlayerPedId()
        Citizen.Wait(0)
        point = GetEntityCoords(iPed)
        local inZone = insidePolygon(point)
        if Config.ShowBorder then
            drawPoly(inZone)
        end
        if inZone then
            for _, players in ipairs(GetActivePlayers()) do
                if IsPedInAnyVehicle(GetPlayerPed(players), true) then
                    veh = GetVehiclePedIsUsing(GetPlayerPed(players))
                    SetEntityNoCollisionEntity(iPed, veh, true)
                end
            end
            hasRun = false
        else
            if not hasRun and istInDimension then
                hasRun = true
             Citizen.Wait(44)
             SetEntityHealth(PlayerPedId(-1), 0)
             TriggerEvent('skyline_notify:Alert', 'FFA', 'Du hast die Zone verlassen und wirst jetzt wieder an einen Spawnpunkt gesendet!' , "error" , 3000)
                end
            end
        end
end)

function isInFFA() 
    return istInDimension
end 

function DisplayHelpText(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringKeyboardDisplay(text)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end


function drawPoly(isEntityZone)
    local iPed = GetPlayerPed(-1)
    for i = 1, #Config.Zones do
        local Zone = Config.Zones[i]
        local j = #Zone
        for i = 1, #Zone do
                
            local zone = Zone[i]
            if i < #Zone then
                local p2 = Zone[i+1]
                _drawWall(zone, p2)
            end
        end
    
        if #Zone > 2 then
            local firstPoint = Zone[1]
            local lastPoint = Zone[#Zone]
            _drawWall(firstPoint, lastPoint)
        end
    end
end

  function _drawWall(p1, p2)
    if istInDimension then
        
    local bottomLeft = vector3(p1[1], p1[2], p1[3] - 1.5)
    local topLeft = vector3(p1[1], p1[2],  p1[3] + Config.BorderHight)
    local bottomRight = vector3(p2[1], p2[2], p2[3] - 1.5)
    local topRight = vector3(p2[1], p2[2], p2[3] + Config.BorderHight)
    
    DrawPoly(bottomLeft,topLeft,bottomRight,255,0,0,50)
    DrawPoly(topLeft,topRight,bottomRight,255,0,0,50)
    DrawPoly(bottomRight,topRight,topLeft,255,0,0,50)
    DrawPoly(bottomRight,topLeft,bottomLeft,255,0,0,50)
end
  end

  RegisterNetEvent('loadout')
  AddEventHandler('loadout', function ()
      TriggerEvent('weapontrigger')
      TriggerEvent('weapontrigger')
      TriggerEvent('weapontrigger')
      TriggerEvent('weapontrigger2')
      TriggerEvent('weapontrigger3')
      SetEntityHealth(PlayerPedId(-1), 200)
      SetPedArmour(PlayerPedId(-1), 200)
      GiveWeaponToPed(PlayerPedId(-1), 0x61012683, 700, 0, 0)
      GiveWeaponToPed(PlayerPedId(-1), 0xAF113F99, 700, 0, 0)
      GiveWeaponToPed(PlayerPedId(-1), 0x83BF0278, 700, 0, 0)
      GiveWeaponToPed(PlayerPedId(-1), 0x5EF9FEC4, 700, 0, 0)
      GiveWeaponToPed(PlayerPedId(-1), 0x1B06D571, 700, 0, 0)
      TriggerEvent('skyline_notify:Alert', 'FFA', 'Du hast die FFA Zone betreten, mit dem Command /quitffa kannst du die Zone Verlassen' , 4000 , "success")
      
      istInDimension = true
  end)
  
  RegisterNetEvent('removeloadout')
  AddEventHandler('removeloadout', function ()
    TriggerEvent('weapontrigger2')
    TriggerEvent('weapontrigger3')
      SetEntityHealth(PlayerPedId(-1), 200)
      SetPedArmour(PlayerPedId(-1), 0)
      RemoveAllPedWeapons(PlayerPedId(), true)
      TriggerEvent('skyline_notify:Alert' , 'FFA', 'Du hast die FFA Zone verlassen' , 2500 , "error")
      TriggerEvent('ffahud:off', true)
      TriggerEvent('skyline:restoreLoadout')
      istInDimension = false
  end)

function DisplayPoints()
    drinnen = true
while true do
Citizen.Wait(350)
if drinnen then
    DisableControlAction(0, 29, true)
    DisableControlAction(0, 47, true)
    DisableControlAction(0, 289, true)
    DisableControlAction(0, 38, true)
    DisableControlAction(0, 46, true)
    DisableControlAction(0, 51, true)
    DisableControlAction(0, 54, true)
    DisableControlAction(0, 86, true)
    DisableControlAction(0, 103, true)
    DisableControlAction(0, 119, true)
    DisableControlAction(0, 153, true)
    DisableControlAction(0, 184, true)
    DisableControlAction(0, 206, true)
    DisableControlAction(0, 350, true)
    DisableControlAction(0, 351, true)
    DisableControlAction(0, 355, true)
    DisableControlAction(0, 356, true)
    if deaths ~= 0 then

    SendNUIMessage({
        status = true,
        plinks = kills,
        prechts = deaths,
        bombe = ESX.Math.Round(kills / deaths, 2),
    })
    else
        SendNUIMessage({
            status = true,
            plinks = kills,
            prechts = deaths,
            bombe = kills,
        })
    end
end
end
end



  