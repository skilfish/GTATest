ESX = nil

TriggerEvent('skylineistback:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("jucktnicht_frakgarage:load", function(playerId , cb)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local job = xPlayer.job 

    cb(job.name , job.grade)
end)

ESX.RegisterServerCallback('jucktnicht_frakgarage:isVehOk', function(source, cb, plate , job)
    local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate and owner = @owner and job = @job', {
		['@plate'] = plate,
        ['@owner'] = xPlayer.identifier,
        ['@job'] = job
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback("jucktnicht_frakgarage:buyVehicle", function(playerId , cb , plate , job , props , id)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local price = 1

    for _,v in pairs(Config.Jobs[job].Cars) do 
        if v.id == id then 
            price = v.price
            break
        end 
    end 

    if xPlayer.getMoney() >= price then 
       xPlayer.removeMoney(price)

       MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, stored) VALUES (@owner, @plate, @vehicle, @type, @job, @stored)', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate,
        ['@vehicle'] = json.encode(props),
        ['@type'] = "car",
        ['@job'] = job,
        ['@stored'] = 0
    }, function (rowsChanged)
    end)

        cb(true)
    else 
        cb(false)
    end 


end)

RegisterNetEvent("jucktnicht_frakgarage:setStored")
AddEventHandler("jucktnicht_frakgarage:setStored" , function( plate,stored)
        MySQL.Async.execute('UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate',
    { ['@stored'] = stored, ['@plate'] = plate},
    function(affectedRows)
    end)
end)


ESX.RegisterServerCallback('jucktnicht_frakgarage:isPlateTaken', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)


ESX.RegisterServerCallback('jucktnicht_frakgarage:getVehicles', function(source, cb)
	
	local s = source
	local xPlayer = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND stored = 1 AND job = @job', {['@owner'] = xPlayer.identifier , ['@job'] = xPlayer.job.name}, function(vehicles)
		cb(vehicles)
	end)
end)