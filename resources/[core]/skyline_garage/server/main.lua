SKYLINE = nil
local allow = true

TriggerEvent("skylineistback:getSharedObject", function(obj)
	SKYLINE = obj
end)

RegisterNetEvent("jucktnicht_garage:securitykick")
AddEventHandler("jucktnicht_garage:securitykick", function()
	local s = source
	local x = SKYLINE.GetPlayerFromId(s)

   -- DropPlayer(s, "Security kick!")
end)

SKYLINE.RegisterServerCallback('jucktnicht_garage:loadVehicles', function(source, cb)
	local ownedCars = {}
	local s = source
	local x = SKYLINE.GetPlayerFromId(s)
	
    if allow then
        if Config.showcarsfromcertainjob then
            MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND stored = 1 AND job = @job', {['@owner'] = x.identifier, ['@job'] = Config.certainjobname}, function(vehicles)
                               --'SELECT * FROM owned_vehicles WHERE stored = 1 AND owner = @owner OR keyowner1 = @owner OR keyowner2 = @owner'
                for _,v in pairs(vehicles) do
                    local vehicle = json.decode(v.vehicle)
                    table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate, name = v.nickname, isFav = v.isFav})
                end
                cb(ownedCars)
            end)
        else
            MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND stored = 1', {['@owner'] = x.identifier}, function(vehicles)

                for _,v in pairs(vehicles) do
                    local vehicle = json.decode(v.vehicle)
                    table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate, name = v.nickname, isFav = v.isFav})
                end
                cb(ownedCars)
            end)
        end
    end
end)

SKYLINE.RegisterServerCallback('jucktnicht_garage:isOwned', function(source, cb, plate)
	local s = source
	local x = SKYLINE.GetPlayerFromId(s)

    if allow then
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate AND owner = @owner', {['@plate'] = plate, ['@owner'] = x.identifier}, function(result)
                           -- 'SELECT * FROM owned_vehicles WHERE plate = @plate AND owner = @owner OR keyowner1 = @owner OR keyowner2 = @owner'
            if #result ~= 0 then
                if result[1].owner == x.identifier then
                    cb({result[1].nickname, result[1].isFav})
                else
                    cb(nil)
                end
            end
        end)
    end
end)

SKYLINE.RegisterServerCallback('jucktnicht_garage:loadVehicle', function(source, cb, plate)
	
	local s = source
	local x = SKYLINE.GetPlayerFromId(s)
	
    if allow then
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE `plate` = @plate', {['@plate'] = plate}, function(vehicle)
            
            cb(vehicle)
        end)
    end
end)

RegisterNetEvent('jucktnicht_garage:setvehfav')
AddEventHandler('jucktnicht_garage:setvehfav', function(plate, state)
	if allow then

    

        MySQL.Sync.execute("UPDATE owned_vehicles SET isFav = @isFav WHERE plate = @plate", {['@plate'] = plate, ['@isFav'] = state})
    end
end)

RegisterNetEvent('jucktnicht_garage:setvehnickname')
AddEventHandler('jucktnicht_garage:setvehnickname', function(plate, nickname)
    if allow then
	    MySQL.Sync.execute("UPDATE owned_vehicles SET nickname = @nickname WHERE plate = @plate", {['@plate'] = plate, ['@nickname'] = nickname})
    end
end)

RegisterNetEvent('jucktnicht_garage:changeState')
AddEventHandler('jucktnicht_garage:changeState', function(plate, state)
    if allow then
	    MySQL.Sync.execute("UPDATE owned_vehicles SET `stored` = @state WHERE `plate` = @plate", {['@state'] = state, ['@plate'] = plate})
    end
end)

RegisterNetEvent('jucktnicht_garage:saveProps')
AddEventHandler('jucktnicht_garage:saveProps', function(plate, props)
	local xProps = json.encode(props)
    print(xProps)
    if allow then
	    MySQL.Sync.execute("UPDATE owned_vehicles SET `vehicle` = @props WHERE `plate` = @plate", {['@plate'] = plate, ['@props'] = xProps})
    end
end)