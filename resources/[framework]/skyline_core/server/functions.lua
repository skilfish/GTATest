SKYLINE.Trace = function(msg)
	if Config.EnableDebug then
		print(('[SKYLINE_core] [^2TRACE^7] %s^7'):format(msg))
	end
end

SKYLINE.SetTimeout = function(msec, cb)
	local id = SKYLINE.TimeoutCount + 1

	SetTimeout(msec, function()
		if SKYLINE.CancelledTimeouts[id] then
			SKYLINE.CancelledTimeouts[id] = nil
		else
			cb()
		end
	end)

	SKYLINE.TimeoutCount = id

	return id
end

SKYLINE.RegisterCommand = function(name, group, cb, allowConsole, suggestion)
	if type(name) == 'table' then
		for k,v in ipairs(name) do
			SKYLINE.RegisterCommand(v, group, cb, allowConsole, suggestion)
		end

		return
	end

	if SKYLINE.RegisteredCommands[name] then
	--	print(('[SKYLINE_core] [^3WARNING^7] An command "%s" is already registered, overriding command'):format(name))

		if SKYLINE.RegisteredCommands[name].suggestion then
			TriggerClientEvent('chat:removeSuggestion', -1, ('/%s'):format(name))
		end
	end

	if suggestion then
		if not suggestion.arguments then suggestion.arguments = {} end
		if not suggestion.help then suggestion.help = '' end

		TriggerClientEvent('chat:addSuggestion', -1, ('/%s'):format(name), suggestion.help, suggestion.arguments)
	end

	SKYLINE.RegisteredCommands[name] = {group = group, cb = cb, allowConsole = allowConsole, suggestion = suggestion}

	RegisterCommand(name, function(playerId, args, rawCommand)
		local command = SKYLINE.RegisteredCommands[name]

		if not command.allowConsole and playerId == 0 then
			print(('[SKYLINE_core] [^3WARNING^7] %s'):format(""))
		else
			local xPlayer, error = SKYLINE.GetPlayerFromId(playerId), nil

			if command.suggestion then
				if command.suggestion.validate then
					if #args ~= #command.suggestion.arguments then
						error = "Überprüfe die Argumente!"
					end
				end

				if not error and command.suggestion.arguments then
					local newArgs = {}

					for k,v in ipairs(command.suggestion.arguments) do
						if v.type then
							if v.type == 'number' then
								local newArg = tonumber(args[k])

								if newArg then
									newArgs[v.name] = newArg
								else
									error = "Achte auf die Anzahl der Argumente!"
								end
							elseif v.type == 'player' or v.type == 'playerId' then
								local targetPlayer = tonumber(args[k])

								if args[k] == 'me' then targetPlayer = playerId end

								if targetPlayer then
									local xTargetPlayer = SKYLINE.GetPlayerFromId(targetPlayer)

									if xTargetPlayer then
										if v.type == 'player' then
											newArgs[v.name] = xTargetPlayer
										else
											newArgs[v.name] = targetPlayer
										end
									else
										error = "ID ist nicht auf dem Server"
									end
								else
									error = "Achte auf die Argument Anzahl!"
								end
							elseif v.type == 'string' then
								newArgs[v.name] = args[k]
							elseif v.type == 'item' then
								if SKYLINE.Items[args[k]] then
									newArgs[v.name] = args[k]
								else
									error = "Ungültiges Item!"
								end
							elseif v.type == 'weapon' then
								if SKYLINE.GetWeapon(args[k]) then
									newArgs[v.name] = string.upper(args[k])
								else
									error = "Ungültige Waffe!"
								end
							elseif v.type == 'any' then
								newArgs[v.name] = args[k]
							end
						end

						if error then break end
					end

					args = newArgs
				end
			end

			if error then
				if playerId == 0 then
					print(('[SKYLINE_core] [^3WARNING^7] %s^7'):format(error))
				else
					xPlayer.triggerEvent('chat:addMessage', {args = {'^1SYSTEM', error}})
				end
			else
				cb(xPlayer or false, args, function(msg)
					if playerId == 0 then
						print(('[SKYLINE_core] [^3WARNING^7] %s^7'):format(msg))
					else
						xPlayer.triggerEvent('chat:addMessage', {args = {'^1SYSTEM', msg}})
					end
				end)
			end
		end
	end, true)

	if type(group) == 'table' then
		for k,v in ipairs(group) do
			ExecuteCommand(('add_ace group.%s command.%s allow'):format(v, name))
		end
	else
		ExecuteCommand(('add_ace group.%s command.%s allow'):format(group, name))
	end
end

SKYLINE.ClearTimeout = function(id)
	SKYLINE.CancelledTimeouts[id] = true
end

SKYLINE.RegisterServerCallback = function(name, cb)
	SKYLINE.ServerCallbacks[name] = cb
end

SKYLINE.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if SKYLINE.ServerCallbacks[name] then
		SKYLINE.ServerCallbacks[name](source, cb, ...)
	else
		print(('[SKYLINE_core] [^3WARNING^7] Server callback "%s" does not exist. Make sure that the server sided file really is loading, an error in that file might cause it to not load.'):format(name))
	end
end

SKYLINE.SavePlayer = function(xPlayer, cb)
	local asyncTasks = {}

	table.insert(asyncTasks, function(cb2)
		MySQL.Async.execute('UPDATE users SET accounts = @accounts, job = @job, job_grade = @job_grade, `group` = @group, loadout = @loadout, position = @position, inventory = @inventory WHERE identifier = @identifier', {
			['@accounts'] = json.encode(xPlayer.getAccounts(true)),
			['@job'] = xPlayer.job.name,
			['@job_grade'] = xPlayer.job.grade,
			['@group'] = xPlayer.getGroup(),
			['@loadout'] = json.encode(xPlayer.getLoadout(true)),
			['@position'] = json.encode(xPlayer.getCoords()),
			['@identifier'] = xPlayer.getIdentifier(),
			['@inventory'] = json.encode(xPlayer.getInventory(true))
		}, function(rowsChanged)
			cb2()
		end)
	end)

	Async.parallel(asyncTasks, function(results)
		print(('[SKYLINE_core] [^2INFO^7] Saved player "%s^7"'):format(xPlayer.getName()))

		if cb then
			cb()
		end
	end)
end

SKYLINE.SavePlayers = function(cb)
	local xPlayers, asyncTasks = SKYLINE.GetPlayers(), {}

	for i=1, #xPlayers, 1 do
		table.insert(asyncTasks, function(cb2)
			local xPlayer = SKYLINE.GetPlayerFromId(xPlayers[i])
			SKYLINE.SavePlayer(xPlayer, cb2)
		end)
	end

	Async.parallelLimit(asyncTasks, 8, function(results)
		print(('[SKYLINE_core] [^2INFO^7] Saved %s player(s)'):format(#xPlayers))
		if cb then
			cb()
		end
	end)
end

SKYLINE.StartDBSync = function()
	function saveData()
		SKYLINE.SavePlayers()
		SetTimeout(10 * 60 * 1000, saveData)
	end

	SetTimeout(10 * 60 * 1000, saveData)
end

SKYLINE.GetPlayers = function()
	local sources = {}

	for k,v in pairs(SKYLINE.Players) do
		table.insert(sources, k)
	end

	return sources
end

SKYLINE.GetPlayerFromId = function(source)
	return SKYLINE.Players[tonumber(source)]
end

SKYLINE.GetPlayerFromIdentifier = function(identifier)
	for k,v in pairs(SKYLINE.Players) do
		if v.identifier == identifier then
			return v
		end
	end
end

SKYLINE.RegisterUsableItem = function(item, cb)
	SKYLINE.UsableItemsCallbacks[item] = cb
end

SKYLINE.UseItem = function(source, item)
	SKYLINE.UsableItemsCallbacks[item](source, item)
end

SKYLINE.GetItemLabel = function(item)
	if SKYLINE.Items[item] then
		return SKYLINE.Items[item].label
	end
end

SKYLINE.CreatePickup = function(type, name, count, label, playerId, components, tintIndex)
	local pickupId = (SKYLINE.PickupId == 65635 and 0 or SKYLINE.PickupId + 1)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)
	local coords = xPlayer.getCoords()

	SKYLINE.Pickups[pickupId] = {
		type = type, name = name,
		count = count, label = label,
		coords = coords
	}

	if type == 'item_weapon' then
		SKYLINE.Pickups[pickupId].components = components
		SKYLINE.Pickups[pickupId].tintIndex = tintIndex
	end

	TriggerClientEvent('skyline:createPickup', -1, pickupId, label, coords, type, name, components, tintIndex)
	SKYLINE.PickupId = pickupId
end

SKYLINE.DoesJobExist = function(job, grade)
	grade = tostring(grade)

	if job and grade then
		if SKYLINE.Jobs[job] and SKYLINE.Jobs[job].grades[grade] then
			return true
		end
	end

	return false
end

SKYLINE.GetJobs = function()
    return SKYLINE.Jobs
end