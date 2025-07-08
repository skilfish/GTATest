SKYLINE = nil
local connectedPlayers = {}

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

SKYLINE.RegisterServerCallback('jucktnicht_scoreboard:getConnectedPlayers', function(source, cb)
	cb(connectedPlayers)
end)

AddEventHandler('skyline:setJob', function(playerId, job, lastJob)
	connectedPlayers[playerId].job = job.name

	TriggerClientEvent('jucktnicht_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end)

AddEventHandler('skyline:playerLoaded', function(playerId, xPlayer)
	AddPlayerToScoreboard(xPlayer, true)
end)

AddEventHandler('skyline:playerDropped', function(playerId)
	connectedPlayers[playerId] = nil

	TriggerClientEvent('jucktnicht_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		UpdatePing()
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			AddPlayersToScoreboard()
		end)
	end
end)

function AddPlayerToScoreboard(xPlayer, update)
	local playerId = xPlayer.source

	connectedPlayers[playerId] = {}
	connectedPlayers[playerId].ping = GetPlayerPing(playerId)
	connectedPlayers[playerId].id = playerId
	connectedPlayers[playerId].name = xPlayer.getName()
	connectedPlayers[playerId].job = xPlayer.job.name

	if update then
		TriggerClientEvent('jucktnicht_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
	end

	if xPlayer.getGroup() == 'user' then
		Citizen.CreateThread(function()
			Citizen.Wait(3000)
			TriggerClientEvent('jucktnicht_scoreboard:toggleID', playerId, false)
		end)
	end
end

function AddPlayersToScoreboard()
	local players = SKYLINE.GetPlayers()

	for i=1, #players, 1 do
		local xPlayer = SKYLINE.GetPlayerFromId(players[i])
		AddPlayerToScoreboard(xPlayer, false)
	end

	TriggerClientEvent('jucktnicht_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end

function UpdatePing()
	for k,v in pairs(connectedPlayers) do
		v.ping = GetPlayerPing(k)
	end

	TriggerClientEvent('jucktnicht_scoreboard:updatePing', -1, connectedPlayers)
end

SKYLINE.RegisterServerCallback('zetka-ping', function(source, cb)
	local data = GetPlayerPing(source)
	cb(data)
end)