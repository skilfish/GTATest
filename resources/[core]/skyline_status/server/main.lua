SKYLINE = nil

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	local players = SKYLINE.GetPlayers()

	for _,playerId in ipairs(players) do
		local xPlayer = SKYLINE.GetPlayerFromId(playerId)

		MySQL.Async.fetchAll('SELECT status FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			local data = {}

			if result[1].status then
				data = json.decode(result[1].status)
			end

			xPlayer.set('status', data)
			TriggerClientEvent('statusundso:load', playerId, data)
		end)
	end
end)

AddEventHandler('skyline:playerLoaded', function(source)
	local _source        = source
	local xPlayer        = SKYLINE.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT status FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
	}, function(result)
		local data = {}

		if result[1].status ~= nil then
			data = json.decode(result[1].status)
		end

		xPlayer.set('status', data)
		TriggerClientEvent('statusundso:load', _source, data)
	end)
end)

AddEventHandler('skyline:playerDropped', function(playerId, reason)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)
	local status = xPlayer.get('status')

	MySQL.Async.execute('UPDATE users SET status = @status WHERE identifier = @identifier', {
		['@status']     = json.encode(status),
		['@identifier'] = xPlayer.identifier
	})
end)

AddEventHandler('statusundso:getStatus', function(playerId, statusName, cb)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)
	local status  = xPlayer.get('status')

	for i=1, #status, 1 do
		if status[i].name == statusName then
			cb(status[i])
			break
		end
	end
end)

RegisterServerEvent('statusundso:update')
AddEventHandler('statusundso:update', function(status)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.set('status', status)
	end
end)

function SaveData()
	local xPlayers = SKYLINE.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = SKYLINE.GetPlayerFromId(xPlayers[i])
		local status  = xPlayer.get('status')

		MySQL.Async.execute('UPDATE users SET status = @status WHERE identifier = @identifier', {
			['@status']     = json.encode(status),
			['@identifier'] = xPlayer.identifier
		})
	end

	SetTimeout(10 * 60 * 1000, SaveData)
end

SaveData()
