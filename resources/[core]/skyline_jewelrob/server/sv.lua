local rob = false
local robbers = {}
PlayersCrafting    = {}
local CopsConnected  = 0
ESX = nil

TriggerEvent('skylineistback:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

RegisterServerEvent('juwelenraubduhs:toofar')
AddEventHandler('juwelenraubduhs:toofar', function(robb)
	print("aaa")
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			TriggerClientEvent('skyline:showNotification', xPlayers[i], "~r~ Raub abgebrochen bei: ~b~" .. Stores[robb].nameofstore)
			TriggerClientEvent('juwelenraubduhs:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('juwelenraubduhs:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('skyline:showNotification', source, "~r~ Raub wurde abgebrochen: ~b~'" .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('juwelenraubduhs:endrob')
AddEventHandler('juwelenraubduhs:endrob', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			TriggerClientEvent('skyline:showNotification', xPlayers[i], "Der Juwelier wurde ausgeraubt.")
			TriggerClientEvent('juwelenraubduhs:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('juwelenraubduhs:robberycomplete', source)
		robbers[source] = nil
		TriggerClientEvent('skyline:showNotification', source, "Raub wurde beendet: " .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('juwelenraubduhs:rob')
AddEventHandler('juwelenraubduhs:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < Config.SecBetwNextRob and store.lastrobbed ~= 0 then

			local b = Config.SecBetwNextRob - (os.time() - store.lastrobbed) / 60

            TriggerClientEvent('juwelenraubduhs:togliblip', source)
			TriggerClientEvent("skyline_notify:Alert", source, "RAUB" , "Dieser Laden wurde erst vor kurzem ausgeraubt. Bitte warte: " ..  b .. " Minuten" , 4000 , "error")
			return
		end

		if rob == false then

			rob = true
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == 'police' then
					TriggerClientEvent("skyline_notify:Alert", xPlayers[i], "ALARM" , "Der Juwelier wird ausgeraubt!!!" , 5000 , "police")
					TriggerClientEvent('juwelenraubduhs:setblip', xPlayers[i], Stores[robb].position)
				end
			end


			TriggerClientEvent("skyline_notify:Alert", source, "RAUB" ,  "Raub wurde gestartet!" , 3000 , "success")
			TriggerClientEvent('juwelenraubduhs:currentlyrobbing', source, robb)
            CancelEvent()
			Stores[robb].lastrobbed = os.time()
		else
			TriggerClientEvent('skyline:showNotification', source, "~r~Ein Raub ist bereits im gange.")
		end
	end
end)

RegisterServerEvent('juwelenraubduhs:gioielli')
AddEventHandler('juwelenraubduhs:gioielli', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('jewels', math.random(Config.MinJewels, Config.MaxJewels))
end)


ESX.RegisterServerCallback('juwelenraubduhs:conteggio', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(CopsConnected)
end)