ESX = nil
local Vehicles

TriggerEvent('skylineistback:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('skyline_lscustom:buyMod')
AddEventHandler('skyline_lscustom:buyMod', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)



		if price < xPlayer.getMoney() then
			TriggerClientEvent('skyline_lscustom:installMod', _source)
			--TriggerClientEvent('skyline:showNotification', _source, _U('purchased'))
			xPlayer.removeMoney(price)
		else
			TriggerClientEvent('skyline_lscustom:cancelInstallMod', _source)
		--	TriggerClientEvent('skyline:showNotification', _source, _U('not_enough_money'))
		end
	
end)

RegisterServerEvent('skyline_lscustom:refreshOwnedVehicle')
AddEventHandler('skyline_lscustom:refreshOwnedVehicle', function(vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate
	}, function(result)
		if result[1] then
			local vehicle = json.decode(result[1].vehicle)

			if vehicleProps.model == vehicle.model then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					['@plate'] = vehicleProps.plate,
					['@vehicle'] = json.encode(vehicleProps)
				})
			else
				print(('skyline_lscustom: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)

ESX.RegisterServerCallback('skyline_lscustom:isMechanic', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(true)

end)
ESX.RegisterServerCallback('skyline_lscustom:getVehiclesPrices', function(source, cb)
	if not Vehicles then
		MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)