local Instances = {}

function GetInstancedPlayers()
	local players = {}

	for k,v in pairs(Instances) do
		for i=1, #v.players, 1 do
			table.insert(players, v.players[i])
		end
	end

	return players
end

function CreateInstance(type, player, data)
	Instances[player] = {
		type    = type,
		host    = player,
		players = {},
		data    = data
	}

	TriggerEvent('instanceistgay:onCreate', Instances[player])
	TriggerClientEvent('instanceistgay:onCreate', player, Instances[player])
	TriggerClientEvent('instanceistgay:onInstancedPlayersData', -1, GetInstancedPlayers())
end

function CloseInstance(instance)
	if Instances[instance] ~= nil then

		for i=1, #Instances[instance].players, 1 do
			TriggerClientEvent('instanceistgay:onClose', Instances[instance].players[i])
		end

		Instances[instance] = nil

		TriggerClientEvent('instanceistgay:onInstancedPlayersData', -1, GetInstancedPlayers())
		TriggerEvent('instanceistgay:onClose', instance)
	end
end

function AddPlayerToInstance(instance, player)
	local found = false

	for i=1, #Instances[instance].players, 1 do
		if Instances[instance].players[i] == player then
			found = true
			break
		end
	end

	if not found then
		table.insert(Instances[instance].players, player)
	end

	TriggerClientEvent('instanceistgay:onEnter', player, Instances[instance])

	for i=1, #Instances[instance].players, 1 do
		if Instances[instance].players[i] ~= player then
			TriggerClientEvent('instanceistgay:onPlayerEntered', Instances[instance].players[i], Instances[instance], player)
		end
	end

	TriggerClientEvent('instanceistgay:onInstancedPlayersData', -1, GetInstancedPlayers())
end

function RemovePlayerFromInstance(instance, player)

	if Instances[instance] ~= nil then

		TriggerClientEvent('instanceistgay:onLeave', player, Instances[instance])

		if Instances[instance].host == player then

			for i=1, #Instances[instance].players, 1 do
				if Instances[instance].players[i] ~= player then
					TriggerClientEvent('instanceistgay:onPlayerLeft', Instances[instance].players[i], Instances[instance], player)
				end
			end

			CloseInstance(instance)

		else

			for i=1, #Instances[instance].players, 1 do
				if Instances[instance].players[i] == player then
					Instances[instance].players[i] = nil
				end
			end

			for i=1, #Instances[instance].players, 1 do
				if Instances[instance].players[i] ~= player then
					TriggerClientEvent('instanceistgay:onPlayerLeft', Instances[instance].players[i], Instances[instance], player)
				end

			end

			TriggerClientEvent('instanceistgay:onInstancedPlayersData', -1, GetInstancedPlayers())

		end

	end

end

function InvitePlayerToInstance(instance, type, player, data)
	TriggerClientEvent('instanceistgay:onInvite', player, instance, type, data)
end

RegisterServerEvent('instanceistgay:create')
AddEventHandler('instanceistgay:create', function(type, data)
	CreateInstance(type, source, data)
end)

RegisterServerEvent('instanceistgay:close')
AddEventHandler('instanceistgay:close', function()
	CloseInstance(source)
end)

RegisterServerEvent('instanceistgay:enter')
AddEventHandler('instanceistgay:enter', function(instance)
	AddPlayerToInstance(instance, source)
end)

RegisterServerEvent('instanceistgay:leave')
AddEventHandler('instanceistgay:leave', function(instance)
	RemovePlayerFromInstance(instance, source)
end)

RegisterServerEvent('instanceistgay:invite')
AddEventHandler('instanceistgay:invite', function(instance, type, player, data)
	InvitePlayerToInstance(instance, type, player, data)
end)
