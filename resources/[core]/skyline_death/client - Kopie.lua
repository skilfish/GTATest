ESX = nil
IsDead = false
local seconds = 8
local tick = 8
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('skylineistback:getSharedObject', function(obj)ESX = obj end)
        Wait(10)
    end
end)

function IsPedDeath()
    local PedKiller = GetPedSourceOfDeath(PlayerPedId())
    local Killer = NetworkGetPlayerIndexFromPed(PedKiller)
    local killername = GetPlayerName(Killer)
    if killername == "**Invalid**" then
        killername = "DIR SELBST"
    end
	if seconds > 0 then	
		SendNUIMessage({
			message	= "showdeathscreen"
		})
		SendNUIMessage({
			message	= "updatetext",
			killedby = killername
		})
		SendNUIMessage({
			message	= "updatetime",
			remainingseconds = seconds
		})
	end
    
    if seconds < 1 then 
        print("donne")
		SendNUIMessage({message = "hide"})	
        IsDead = false 

        Citizen.Wait(500)

        seconds = 8
        tick = 8
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(490)
        if seconds > 0 and IsDead == true then 
            print(seconds)
            seconds = seconds -1
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(460)
        if tick > 0 and IsDead == true then 
            SendNUIMessage({message = "tick"})
            tick = tick -1
        end
    end
end)


AddEventHandler("skyline:onPlayerDeath", function()
    if exports["skyline_ffa"]:isInFFA() then 
        IsDead = true 
    end 
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsDead then 
            Citizen.Wait(0)
            IsPedDeath()

            if GetEntityHealth(PlayerPedId()) > 0 then 
                IsDead = false 
            end 
        end 

      
	end
end)

