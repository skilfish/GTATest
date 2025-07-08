SKYLINE = nil

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

function getDCId(source) 
    local discord = ""
    local id = ""
    
identifiers = GetNumPlayerIdentifiers(source)
for i = 0, identifiers + 1 do
    if GetPlayerIdentifier(source, i) ~= nil then
        if string.match(GetPlayerIdentifier(source, i), "discord") then
            discord = GetPlayerIdentifier(source, i)
            id = string.sub(discord, 9, -1)
        end
    end
end

return id

end 

function getIdentity(source, callback)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT identifier, firstname, lastname, dateofbirth, sex, height FROM `users` WHERE `identifier` = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1].firstname ~= nil then
			local data = {
				identifier	= result[1].identifier,
				firstname	= result[1].firstname,
				lastname	= result[1].lastname,
				dateofbirth	= result[1].dateofbirth,
				sex			= result[1].sex,
				height		= result[1].height
			}

			callback(data)
		else
			local data = {
				identifier	= '',
				firstname	= '',
				lastname	= '',
				dateofbirth	= '',
				sex			= '',
				height		= ''
			}

			callback(data)
		end
	end)
end

function setIdentity(identifier, data, callback)
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function updateIdentity(playerId, data, callback)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= xPlayer.identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(rowsChanged)
		if callback then
			TriggerEvent('skyline_identity:characterUpdated', playerId, data)
			callback(true)
		end
	end)
end

function deleteIdentity(source)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= xPlayer.identifier,
		['@firstname']		= '',
		['@lastname']		= '',
		['@dateofbirth']	= '',
		['@sex']			= '',
		['@height']			= '',
	})
end

RegisterServerEvent('skyline_identity:setIdentity')
AddEventHandler('skyline_identity:setIdentity', function(data, myIdentifiers)
	local xPlayer = SKYLINE.GetPlayerFromId(source)
	setIdentity(myIdentifiers.steamid, data, function(callback)
		if callback then
			TriggerClientEvent('skyline_identity:identityCheck', myIdentifiers.playerid, true)
			TriggerEvent('skyline_identity:characterUpdated', myIdentifiers.playerid, data)
			local msg = {
				{
					["color"] = "1752220",
					["title"] = "Charakter - Registriert",
					["description"] = "**" .. GetPlayerName(xPlayer.source) .. "** hat sich als ** " .. xPlayer.getName() .. " ** registriert. \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">" ,
					["footer"] = {
						["text"] = "Copyright © Skyline 2022",
						["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
					},
				}
			}
		
			PerformHttpRequest("https://discord.com/api/webhooks/985091491921805352/9hxU6JA2t5ABvQnXQdtI8BClH-K2E_WGlPz7BFlwAf1RyFXj_P_MWjr5FTeBXylRQNTg", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

		else
			xPlayer.TriggerEvent("skyline_notify:Alert", "SYSTEM" , "Bitte übeprüfe deine Eingaben.. falls du Hilfe brauch komm in den Support!" , 4000 , "error")
		end
	end)
end)

AddEventHandler('skyline:playerLoaded', function(playerId, xPlayer)
	local myID = {
		steamid = xPlayer.identifier,
		playerid = playerId
	}

	TriggerClientEvent('skyline_identity:saveID', playerId, myID)

	getIdentity(playerId, function(data)
		if data.firstname == '' then
			TriggerClientEvent('skyline_identity:identityCheck', playerId, false)
			TriggerClientEvent('skyline_identity:showRegisterIdentity', playerId)
		else
			TriggerClientEvent('skyline_identity:identityCheck', playerId, true)
			TriggerEvent('skyline_identity:characterUpdated', playerId, data)
		end
	end)
end)

AddEventHandler('skyline_identity:characterUpdated', function(playerId, data)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)

	if xPlayer then
		xPlayer.setName(('%s %s'):format(data.firstname, data.lastname))
		xPlayer.set('firstName', data.firstname)
		xPlayer.set('lastName', data.lastname)
		xPlayer.set('dateofbirth', data.dateofbirth)
		xPlayer.set('sex', data.sex)
		xPlayer.set('height', data.height)
	end
end)

-- Set all the client side variables for connected users one new time
AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(3000)
		local xPlayers = SKYLINE.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = SKYLINE.GetPlayerFromId(xPlayers[i])

			if xPlayer then
				local myID = {
					steamid  = xPlayer.identifier,
					playerid = xPlayer.source
				}
	
				TriggerClientEvent('skyline_identity:saveID', xPlayer.source, myID)
	
				getIdentity(xPlayer.source, function(data)
					if data.firstname == '' then
						TriggerClientEvent('skyline_identity:identityCheck', xPlayer.source, false)
						TriggerClientEvent('skyline_identity:showRegisterIdentity', xPlayer.source)
					else
						TriggerClientEvent('skyline_identity:identityCheck', xPlayer.source, true)
						TriggerEvent('skyline_identity:characterUpdated', xPlayer.source, data)
					end
				end)
			end
		end
	end
end)
