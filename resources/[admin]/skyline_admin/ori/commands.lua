RegisterCommand("ooc", function(source , args)
    local argString = table.concat(args, " ")
    if argString ~= nil then
        
        local closestPlayer, closestPlayerDistance = SKYLINE.Game.GetClosestPlayer()

        if closestPlayer == -1 or closestPlayerDistance > 3.0 then
            SKYLINE.ShowNotification('Keiner in der Nähe!')
        else
            SKYLINE.ShowNotification('~y~ OOC Nachricht geschickt')
            TriggerServerEvent("skyline_admin:sendOOCMSG", GetPlayerServerId(closestPlayer) , argString)
        end
    end
end)

RegisterCommand("support_on", function(source , args)
    SKYLINE.TriggerServerCallback("skyline_admin:rangcheck", function(group) 
        if group == "mod" or group == "admin" or group == "superadmin" or group == "pl" then 
            SetNuiFocus(true, true)

            SendNUIMessage({
                display = true,
            })
        end 
    end)
end)

RegisterCommand("nervNichtAuto", function()
    SKYLINE.TriggerServerCallback("skyline_admin:rangcheck", function(group) 
        if group == "superadmin" then 
           if IsPedInAnyVehicle(PlayerPedId(), false) then 


     
                local list = 
                {
                   {label = "Normal", value = -1},
                    {label = "<span style=color:white;>Weiß</span>", value = 0},
                    {label = "<span style=color:blue;>Blau</span>", value = 1},    
                    {label = "<span style=color:lightblue;>Hell-Blau</span>", value = 2},    
                    {label = "<span style=color:lightgreen;>Minz-Grün</span>", value = 3},    
                    {label = "<span style=color:green;>Lime-Grün</span>", value = 4},
                    {label = "<span style=color:yellow;>Gelb</span>", value = 5},
                    {label = "<span style=color:gold;>Gold</span>", value = 6},
                    {label = "<span style=color:orange;>Orange</span>", value = 7},
                    {label = "<span style=color:red;>Rot</span>", value = 8},
                    {label = "<span style=color:lightpink;>Pony-Pink</span>", value = 9},
                    {label = "<span style=color:pink;>Pink</span>", value = 10},
                    {label = "<span style=color:purple;>Lila</span>", value = 11},
                    {label = "<span style=color:grey;>Schwarzlicht</span>", value = 12},
                }


            SKYLINE.UI.Menu.Open("default", GetCurrentResourceName(), "nervNichtAuto", {
                title = "Welche Farbe sollen die Scheinwerfer sein?",
                align    = 'top-left',
                elements = list
            }, 
            function(data , menu)
                local veh = GetVehiclePedIsUsing(PlayerPedId())
                props = {}

                props = SKYLINE.Game.GetVehicleProperties(veh)
                props['modXenon'] = 1
                props['xenonColor'] = data.current.value
          
                SKYLINE.Game.SetVehicleProperties(veh, props)
                
                SKYLINE.TriggerServerCallback("skyline_admin:updateCar", function(cb) 
                    
                end, props) 
                menu.close()

            end,
            function(data,menu)
                menu.close()
            end)
           else
            SKYLINE.ShowNotification("~y~ Du musst in einem Fahrzeug sein.")
           end 
        end 
    end)
    
end)
