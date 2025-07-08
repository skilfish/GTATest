function Alert(title, message, time, type)
	SendNUIMessage({
		action = 'open',
		title = title,
		type = type,
		message = message,
		time = time,
	})
end

RegisterNetEvent('skyline_notify:Alert')
AddEventHandler('skyline_notify:Alert', function(title, message, time, type)
	Alert(title, message, time, type)
end)


RegisterCommand("id", function()
	TriggerEvent("skyline_notify:Alert" , "SYSTEM" , "Deine ID: <b style=color:white;>" .. GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) , 5000 , "long")
end, false)
