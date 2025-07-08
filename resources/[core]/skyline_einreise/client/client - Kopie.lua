SKYLINE = nil 
E = false
needHelp = false
hasJob = false
isPrinting = false
local bug = false 

local einreiseSpawn = vector3(tonumber("-1140.36") , tonumber("-2806.41") ,tonumber("27.71") )

Citizen.CreateThread(function()
    while SKYLINE == nil do
        TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
        Citizen.Wait(0)
    end

    Citizen.Wait(2000)

    SKYLINE.TriggerServerCallback("jucktnicht_einreise:checkJob", function(d) 
        hasJob = d
    end)

    SKYLINE.TriggerServerCallback("jucktnicht_einreise:hasEinreise", function(hasEinreise) 
        if not hasEinreise then 

            SKYLINE.Game.Teleport(PlayerPedId(), einreiseSpawn, function() end)
            
            needHelp = true

            Citizen.Wait(5000)
            bug = true
        else 
            E = true
        end 
    end)
end)


RegisterNetEvent('skyline:playerLoaded')
AddEventHandler('skyline:playerLoaded', function(xPlayer) 
	SKYLINE.TriggerServerCallback("jucktnicht_einreise:hasEinreise", function(hasEinreise) 
        if not hasEinreise then 

            SKYLINE.Game.Teleport(PlayerPedId(), einreiseSpawn, function() end)
            
            needHelp = true

            Citizen.Wait(5000)
            bug = true
        else 
            E = true
        end 
    end)


    a = false 

    for _,v in pairs(Config.Groups) do 
       if v == xPlayer.group then 
            hasJob = true
        break
       end 
    end 
   
end)


local printer = {
    {x = -1070.87 , y = -2821.53 , z = 27.71 , h = 239.13},
    {x = -1085.98, y = -2819.55 , z = 27.71 , h = 59.5},
    {x = -1080.52, y = -2809.93 , z = 27.71 , h = 62.18},
    {x = -1065.27, y = -2811.62 , z = 27.71 , h = 246.95}


}

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        local pCoords = GetEntityCoords(PlayerPedId())

        if hasJob then 
            for k,v in pairs(printer) do 
                if GetDistanceBetweenCoords(pCoords, v.x, v.y, v.z, true) <= 0.75 then 
                    if not isPrinting then 
                        SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um ein ~y~Einreise-Visum zu drucken.")
                    end 

                    if IsControlJustPressed(0, 38) then 
                        SetEntityHeading(GetPlayerPed(-1), v.h)

                        isPrinting = true 
                        
                        TriggerEvent("jucktnicht_progressbar:client:progress", {
                            name = "printer_einreiseamt",
                            duration = 7000,
                            label = "Visum wird gedruckt...",
                            useWhileDead = false,
                            canCancel = false,

                            animation = {
                                animDict = "amb@prop_human_parking_meter@male@idle_a",
                                anim = "idle_a",
                            },

                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            },
                        }, function(status)
                            print("ddd")


                            if not status then
                                isPrinting = false
                                ClearPedTasksImmediately(PlayerPedId())
                                TriggerServerEvent("jucktnicht_einreise:addTicket")
                            end
                              
                        end)
                    end 
                end 

                if GetDistanceBetweenCoords(pCoords, v.x, v.y, v.z, true) <= 15.0 then 
                    DrawMarker(23,  v.x, v.y, v.z - 0.9, tonumber("0.0"), tonumber("0.0"), tonumber("0.0"), tonumber("0.0"), tonumber("0.0"), tonumber("0.0"), tonumber("1.5"), tonumber("1.5"), tonumber("0.5"),0, 0, 255, 255, false, false, 2, true, nil, nil, false)
               
                    
                end 
            end 
        end 

     
    end 
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        local pCoords = GetEntityCoords(PlayerPedId())


        if GetDistanceBetweenCoords(pCoords, -1066.91, -2798.27, 27.71, true) <= 40.5 then 
            DrawMarker(7, -1065.7, -2798.67, 27.4, tonumber("0.0"), tonumber("0.0"), tonumber("0.0"), tonumber("0.0"), tonumber("0.0"), tonumber("0.0"), tonumber("1.0"), tonumber("1.0"), tonumber("1.0"),0, 0, 255, 255, false, false, 2, true, nil, nil, false)
        end 

        if GetDistanceBetweenCoords(pCoords, -1066.91, -2798.27, 27.71, true) <= 2.2 then 
            SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um ~y~Einzureisen.")

            if IsControlJustPressed(0, 38) then 
                SKYLINE.TriggerServerCallback("jucktnicht_einreise:checkEinreise", function(d) 
                
                    if d then 

                        SKYLINE.Game.Teleport(PlayerPedId(), {x = -1042.31, y = -2745.54, z = 21.36, heading = 331.14}, function() 
                            if not hasJob then 
                               -- TriggerEvent("notifications", "red" , "Einreise-Amt" , "Danke das du dich entschieden hast auf Diamond-V zu spielen!")
                                --TriggerServerEvent("SKYLINE_lastpos:save", GetEntityCoords(PlayerPedId()))
                                needHelp = false
                                bug = false
                            end 
                        end)
                       
                    end 
                end)
            end 
        end 

    end 
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        local pCoords = GetEntityCoords(PlayerPedId())


        if GetDistanceBetweenCoords(pCoords, -1042.71, -2746.17, 21.36, true) <= 35.5 then 
            if hasJob then 
                DrawMarker(1, -1042.71, -2746.17, 20.36, tonumber("0.0"), tonumber("0.0"), tonumber("0.0"), tonumber("0.0"), tonumber("0.0"), tonumber("0.0"), tonumber("1.5"), tonumber("1.5"), tonumber("0.5"),0, 0, 255, 255, false, false, 2, true, nil, nil, false)
           
                if GetDistanceBetweenCoords(pCoords, -1042.71, -2746.17, 21.36, true) <= 0.75 then 
                    SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um deinen ~y~Arbeitsplatz ~w~zu betreten.")

                    if IsControlJustPressed(0, 38) then 
                        SKYLINE.Game.Teleport(PlayerPedId(), {x = -1065.7, y = -2798.67, z =  27.4, heading = 151.14}, function() 
                            TriggerEvent("notifications", 1 , "Einreise-Amt" , "Viel Spaß bei der Arbeit!")
                        end)
                    end 
                end 
            end 
        end 

        

        while needHelp do 
            local pCoords = GetEntityCoords(PlayerPedId())


            Citizen.Wait(0)

            SetTextFont(0)
            SetTextProportional(1)
            SetTextScale(tonumber("0.0"),tonumber("0.4"))
            SetTextColour(0, 0, 0, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")

            if not Config.SimpleMode then 
                AddTextComponentString("~w~Melde dich bei einem ~g~Einreise-Beamten")
            end 

            DrawText(tonumber("0.4"), tonumber("0.95"))

            player = PlayerPedId()
            
            SetPlayerCanDoDriveBy(player, false)
            DisablePlayerFiring(player, true)
            DisableControlAction(0, 140) -- Melee R

            if bug then 
                if GetDistanceBetweenCoords(pCoords, einreiseSpawn, true) > tonumber("200.0")  then 
                    SKYLINE.Game.Teleport(PlayerPedId(), {x = tonumber("-1140.36") , y = tonumber("-2806.41") , z = tonumber("27.71") , heading = tonumber("250.2")}, function() end)
                end 
            end 
         
        end  
        
      
    end 
end)



RegisterCommand("banEinreise", function(source, args)
    SKYLINE.TriggerServerCallback("jucktnicht_einreise:getGroup", function(group) 
            local a = false 

            for _,v in pairs(Config.Groups) do 
                if v == group then 
                    a = true 
                    break
                end 
            end
            
            if a then 
              --  SKYLINE.Game.GetPlayers(onlyOtherPlayers, returnKeyValue, returnPeds)
                if args[1] ~= nil then 
                        SKYLINE.TriggerServerCallback("jucktnicht_einreise:isBanable", function(admin) 
                                if not admin then 
                                    TriggerServerEvent("jucktnicht_einreise:ban", args[1])
                                else
                                    TriggerEvent("notifications", "red" , "Admin-System" , "<span style=color:red;>Diese ID kann nicht gesperrt werden.<span>")
                                end 
                        end,args[1])
                else 
                    TriggerEvent("notifications", "red" , "Admin-System" , "<span style=color:red;>Gebe eine ID ein!<span>")
                end 
            else 
                TriggerEvent("notifications", "red" , "Admin-System" , "<span style=color:red;>Dazu hast du keine Rechte!<span>")
            end 
    end)
end)