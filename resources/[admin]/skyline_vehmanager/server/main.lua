SKYLINE = nil
TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

--give car with a random plate- 1: playerID 2: carModel (3: plate)
RegisterCommand('givecar', function(source, args)
	givevehicle(source, args, 'car')
end)

--give car with a random plate- 1: playerID 2: carModel (3: plate)
RegisterCommand('giveplane', function(source, args)
	givevehicle(source, args, 'airplane')
end)

--give car with a random plate- 1: playerID 2: carModel (3: plate)
RegisterCommand('giveboat', function(source, args)
	givevehicle(source, args, 'boat')
end)

--give car with a random plate- 1: playerID 2: carModel (3: plate)
RegisterCommand('giveheli', function(source, args)
	givevehicle(source, args, 'helicopter')
end)

function givevehicle(_source, _args, vehicleType)
	if havePermission(_source) then
		if _args[1] == nil or _args[2] == nil then
			TriggerClientEvent('skyline:showNotification', _source, '~r~/givevehicle playerID carModel [plate]')
		elseif _args[3] ~= nil then
			local playerName = GetPlayerName(_args[1])
			local plate = _args[3]
			if #_args > 3 then
				for i=4, #_args do
					plate = plate.." ".._args[i]
				end
			end	
			plate = string.upper(plate)
			TriggerClientEvent('idkfahrzeugeverwalten11:spawnVehiclePlate', _source, _args[1], _args[2], plate, playerName, 'player', vehicleType)
		else
			local playerName = GetPlayerName(_args[1])
			TriggerClientEvent('idkfahrzeugeverwalten11:spawnVehicle', _source, _args[1], _args[2], playerName, 'player', vehicleType)
		end
	else
		TriggerClientEvent('SKYLINE:showNotification', _source, '~r~You don\'t have permission to do this command!')
	end
end

RegisterCommand('_givecar', function(source, args)
	_givevehicle(source, args, 'car')
end)

RegisterCommand('_giveplane', function(source, args)
	_givevehicle(source, args, 'airplane')
end)

RegisterCommand('_giveboat', function(source, args)
	_givevehicle(source, args, 'boat')
end)

RegisterCommand('_giveheli', function(source, args)
	_givevehicle(source, args, 'helicopter')
end)

function _givevehicle(_source, _args, vehicleType)
	if _source == 0 then
		local sourceID = _args[1]
		if _args[1] == nil or _args[2] == nil then
			print("SYNTAX ERROR: _givevehicle <playerID> <carModel> [plate]")
		elseif _args[3] ~= nil then
			local playerName = GetPlayerName(sourceID)
			local plate = _args[3]
			if #_args > 3 then
				for i=4, #_args do
					plate = plate.." ".._args[i]
				end
			end
			plate = string.upper(plate)
			TriggerClientEvent('idkfahrzeugeverwalten11:spawnVehiclePlate', sourceID, _args[1], _args[2], plate, playerName, 'console', vehicleType)
		else
			local playerName = GetPlayerName(_args[1])
			TriggerClientEvent('idkfahrzeugeverwalten11:spawnVehicle', sourceID, _args[1], _args[2], playerName, 'console', vehicleType)
		end
	end
end

RegisterCommand('delcarplate', function(source, args)
	if havePermission(source) then
		if args[1] == nil then
			TriggerClientEvent('SKYLINE:showNotification', source, '~r~/delcarplate <plate>')
		else
			local plate = args[1]
			if #args > 1 then
				for i=2, #args do
					plate = plate.." "..args[i]
				end		
			end
			plate = string.upper(plate)
			
			local result = MySQL.Sync.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
				['@plate'] = plate
			})
			if result == 1 then
				TriggerClientEvent('SKYLINE:showNotification', source, _U('del_car', plate))
			elseif result == 0 then
				TriggerClientEvent('SKYLINE:showNotification', source, _U('del_car_error', plate))
			end		
		end
	else
		TriggerClientEvent('SKYLINE:showNotification', source, '~r~You don\'t have permission to do this command!')
	end		
end)

RegisterCommand('_delcarplate', function(source, args)
    if source == 0 then
		if args[1] == nil then	
			print("SYNTAX ERROR: _delcarplate <plate>")
		else
			local plate = args[1]
			if #args > 1 then
				for i=2, #args do
					plate = plate.." "..args[i]
				end		
			end
			plate = string.upper(plate)
			
			local result = MySQL.Sync.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
				['@plate'] = plate
			})
			if result == 1 then
				print('Deleted car plate: ' ..plate)
			elseif result == 0 then
				print('Can\'t find car with plate is ' ..plate)
			end
		end
	end
end)


--functions--

RegisterServerEvent('idkfahrzeugeverwalten11:setVehicle')
AddEventHandler('idkfahrzeugeverwalten11:setVehicle', function (vehicleProps, playerID, vehicleType)
	local _source = playerID
	local xPlayer = SKYLINE.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored, type) VALUES (@owner, @plate, @vehicle, @stored, @type)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@stored']  = 1,
		['type'] = vehicleType
	}, function ()
		if Config.ReceiveMsg then
			TriggerClientEvent("skyline_notify:Alert",_source , "ADMIN-SYSTEM" , "<b style=color:green;>Du hast ein Auto erhalten, mit dem Kennzeichen: " .. vehicleProps.plate , 5000 , "success")
		end
	end)
end)

RegisterServerEvent('idkfahrzeugeverwalten11:printToConsole')
AddEventHandler('idkfahrzeugeverwalten11:printToConsole', function(msg)
	print(msg)
end)

function havePermission(_source)
	local xPlayer = SKYLINE.GetPlayerFromId(_source)
	local playerGroup = xPlayer.getGroup()
	local isAdmin = false

	for k,v in pairs(Config.AuthorizedRanks) do
		if v == playerGroup then
			isAdmin = true
			break
		end
	end
		
	return isAdmin
end

SKYLINE.RegisterServerCallback('idkfahrzeugeverwalten11:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)