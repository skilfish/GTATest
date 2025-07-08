SKYLINE = nil 

Citizen.CreateThread(function()
    while SKYLINE == nil do
      TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
      Citizen.Wait(0)
    end
end)


local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["F11"] = 344,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}




local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 500
local displayIDHeight = 1.5 


local red = 255
local green = 255
local blue = 255

local isGamerTagOn = false

RegisterNetEvent("skyline_admin:enableGamerTag")
AddEventHandler("skyline_admin:enableGamerTag", function()
    SKYLINE.TriggerServerCallback("skyline_admin:rangcheck", function(group) 
        if group == "sup" or group == "event" or group == "mod" or group == "admin" or group == "superadmin" or group == "dev" or group == "pl" or group == "frak" then 
            isGamerTagOn = true
            TriggerEvent("skyline_notify:Alert", "SYSTEM" , "Nametags Aktiviert!" , 3000 ,  "success")

        else 
            TriggerEvent("skyline_notify:Alert", "SYSTEM" , "Dazu hast du keine Rechte!" , 3000 , "error")
        end 
    end)
end)

RegisterNetEvent("skyline_admin:disbaleGamerTag")
AddEventHandler("skyline_admin:disbaleGamerTag", function()
    SKYLINE.TriggerServerCallback("skyline_admin:rangcheck", function(group) 
        if group == "sup" or group == "event" or group == "mod" or group == "admin" or group == "superadmin" or group == "dev" or group == "pl" or group == "frak" then 
            isGamerTagOn = false
            TriggerEvent("skyline_notify:Alert", "SYSTEM" , "Nametags Deaktiviert!" , 3000 ,  "error")
        else 
            TriggerEvent("skyline_notify:Alert", "SYSTEM" , "Dazu hast du keine Rechte!" , 3000 , "error")
        end 
    end)
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if  IsControlJustPressed(0, Keys["F11"])  then 
                if isGamerTagOn then 
                    TriggerEvent("skyline_admin:disbaleGamerTag")
                    TriggerServerEvent("skyline_admin:nametags" , true)
                else               
                    TriggerEvent("skyline_admin:enableGamerTag")
                    TriggerServerEvent("skyline_admin:nametags" , false)

                end 
             
          
        end 
    end 
end)



function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        if dist < 16 then 
            SetTextScale(0.4*scale, 0.4*scale)
        else 
            SetTextScale(1.8*scale, 1.8*scale)

        end 
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end





Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        while isGamerTagOn do
            for i=0,99 do
                N_0x31698aa80e0223f8(i)
            end
            for id = 0, 255 do
                if GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
                    ped = GetPlayerPed( id )
                    blip = GetBlipFromEntity( ped ) 
     
                    x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                    x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                    distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
    
                    if(ignorePlayerNameDistance) then
    
                            red = 255
                            green = 255
                            blue = 255
                            DrawText3D(x2, y2, z2 + displayIDHeight, "[" .. GetPlayerServerId(id) .. "] " .. GetPlayerName(id))
                                            
                            
                    end
    
                    if ((distance < playerNamesDist)) then
                        if not (ignorePlayerNameDistance) then
                
                                red = 255
                                green = 0
                                blue = 0
                                DrawText3D(x2, y2, z2 + displayIDHeight, "[" .. GetPlayerServerId(id) .. "] " .. GetPlayerName(id))
                                          
                        end
                    end  
                end
            end
            Citizen.Wait(0)
        end
    end 
   
end)
