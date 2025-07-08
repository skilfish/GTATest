SKYLINE = nil 

TriggerEvent('skylineistback:getSharedObject', function(obj)
	SKYLINE = obj
end)

SKYLINE.RegisterServerCallback('impoundduhs:getVehicles', function(source, cb)
	
	local s = source
	local xPlayer = SKYLINE.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND stored = 1 AND job = @job AND NOT type = @type', {['@owner'] = xPlayer.identifier , ['@job'] = "civ", ['@type'] = "heli"}, function(vehicles)
		cb(vehicles)
	end)
end)



SKYLINE.RegisterServerCallback('impoundduhs:getImpoundVehicles', function(source, cb)
	
	local s = source
	local xPlayer = SKYLINE.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND stored = 0 AND NOT type = @type', {['@owner'] = xPlayer.identifier, ['@type'] = "heli"}, function(vehicles)
		cb(vehicles)
	end)
end)

SKYLINE.RegisterServerCallback("impoundduhs:payImpound", function(source , cb)
      local s = source
      local xPlayer = SKYLINE.GetPlayerFromId(s)
      
      if xPlayer.getMoney() >= 2000 then 
        xPlayer.removeMoney(2000)
        cb(true)
      else 
        cb(false)
      end 
end)


SKYLINE.RegisterServerCallback('impoundduhs:getVehicle', function(plate , cb)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {['@plate'] = plate}, function(vehicles)
		cb(vehicles)
	end)
end)

SKYLINE.RegisterServerCallback('impoundduhs:isOwned', function(source, cb, plate)
	
	local s = source
	local x = SKYLINE.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate AND owner = @owner', {['@plate'] = plate, ['@owner'] = x.identifier}, function(vehicle)
		if next(vehicle) then
			cb(true)
		else
			cb(false)
		end
	end)
end)



SKYLINE.RegisterServerCallback('impoundduhs:isCivVehicle', function(source, cb, plate)
	
	local s = source
	local x = SKYLINE.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate AND job = @job', {['@plate'] = plate, ['@job'] = "civ"}, function(vehicle)
		if next(vehicle) then
			cb(true)
		else
			cb(false)
		end
	end)
end)

RegisterNetEvent("impoundduhs:setStored")
AddEventHandler("impoundduhs:setStored" , function( plate,stored)
    MySQL.Async.execute('UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate',
  { ['@stored'] = stored, ['@plate'] = plate},
  function(affectedRows)
  end)

end)

SKYLINE.RegisterServerCallback('impoundduhs:retrieveJobVehicles', function(source, cb, type)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type,
		['@job'] = xPlayer.job.name
	}, function(result)
		cb(result)
	end)
end)


MySQL.ready(function()
	MySQL.Sync.execute('UPDATE owned_vehicles SET stored = @stored',
  { ['@stored'] = 1},
  function(affectedRows)
  end)
end)