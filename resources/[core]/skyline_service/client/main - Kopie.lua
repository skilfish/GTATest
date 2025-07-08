SKYLINE = nil

Citizen.CreateThread(function()
	while SKYLINE == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('serviceistcool:notifyAllInService')
AddEventHandler('serviceistcool:notifyAllInService', function(target , notification , name)
	target = GetPlayerFromServerId(target)

	local targetPed = GetPlayerPed(target)
	local mugshot, mugshotStr = SKYLINE.Game.GetPedMugshot(targetPed)

    if notification == "on_lsmd" then 
        SKYLINE.ShowAdvancedNotification("LSMD - Dienst-System", "Mediziener im Dienst", "Der Mediziener ~g~" .. name .. "~w~ ist jetzt im Dienst.", mugshotStr, 1, false, false, 140)
    end 

    if notification == "off_lsmd" then 
        SKYLINE.ShowAdvancedNotification("LSMD - Dienst-System", "Mediziener außer Dienst", "Der Mediziener ~r~" .. name .. "~w~ ist nicht mehr Dienst.", mugshotStr, 1, false, false, 140)
    end 

	UnregisterPedheadshot(mugshot)
end)