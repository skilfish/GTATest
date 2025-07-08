
-- check, if the config is fine
for job, data in pairs(Config.JobVehicles) do
    if (data.models == nil) then
        data.models = {}
    end

    if (data.plates == nil) then
        data.plates = {}
    end
end



ESX = nil
TriggerEvent('skylineistback:getSharedObject', function(obj) ESX = obj end)

local CB = exports["skyline_callbacks"]


-- create a new key
CB:Register("VKC:createNewKey", function(source, plate, count)
    local src = source
    
    if (plate == nil or count == nil) then
        print("^1[ERROR] \"plate\" or \"count\" was nil while creating new key for id " .. tostring(src))
        
        return false
    end

	local playerData = ESX.GetPlayerFromId(src)
    if (playerData) then
        local trimmedPlate = plate:gsub("^%s*(.-)%s*$", "%1"):upper()

        if (playerData.getMoney() >= Config.Costs.newKey) then
            local results = MySQL.Sync.fetchAll("SELECT count FROM vehicle_keys WHERE owner = @owner AND (plate = @plate OR plate = @trimmedPlate)", {
                ["@owner"]          = playerData.identifier,
                ["@plate"]          = plate,
                ["@trimmedPlate"]   = trimmedPlate
            })

            local rows = 0
            if (#results > 0) then
	            rows = MySQL.Sync.execute("UPDATE vehicle_keys SET count = count + @count WHERE owner = @owner AND (plate = @plate OR plate = @trimmedPlate)", {
                    ["@owner"]          = playerData.identifier,
                    ["@plate"]          = plate,
                    ["@trimmedPlate"]   = trimmedPlate,
                    ["@count"]          = count
                })
            else
	            rows = MySQL.Sync.execute("INSERT INTO vehicle_keys (owner, plate, count) VALUES (@owner, @trimmedPlate, @count)", {
                    ["@owner"]          = playerData.identifier,
                    ["@trimmedPlate"]   = trimmedPlate,
                    ["@count"]          = count
                })
            end
            
            if (rows == 0) then
                return false
            end
            
            playerData.removeMoney(Config.Costs.newKey)
        else
            return "noMoney"
        end
    else
        print("^1[ERROR] \"playerData\" was nil while creating new key for id " .. tostring(src))
    
        return false
    end

    return true
end)

-- remove a key from a plate
CB:Register("VKC:removeKey", function(source, plate, num)
    local src = source
    
    if (plate == nil or num == nil) then
        print("^1[ERROR] \"plate\" or \"num\" was nil while removing a key for id " .. tostring(src))
        
        return false
    end

	local playerData = ESX.GetPlayerFromId(src)
    if (playerData) then
        local trimmedPlate = plate:gsub("^%s*(.-)%s*$", "%1"):upper()

        local rows = MySQL.Sync.execute("DELETE FROM vehicle_keys WHERE owner = @owner and (plate = @plate OR plate = @trimmedPlate) and count = @num", {
            ["@owner"]          = playerData.identifier,
            ["@plate"]          = plate,
            ["@trimmedPlate"]   = trimmedPlate,
            ["@num"]            = num
        })

        if (rows == 0) then
            rows = MySQL.Sync.execute("UPDATE vehicle_keys SET count = count - @num WHERE owner = @owner and (plate = @plate OR plate = @trimmedPlate)", {
                ["@owner"]          = playerData.identifier,
                ["@plate"]          = plate,
                ["@trimmedPlate"]   = trimmedPlate,
                ["@num"]            = num
            })
        end

        if (rows == 0) then
            return false
        end
    else
        print("^1[ERROR] \"playerData\" was nil while removing a key for id " .. tostring(src))
    
        return false
    end

    return true
end)

-- give a key to another player
CB:Register("VKC:giveKeyToPlayer", function(source, plate, playerId)
    local src = source
    
    if (plate == nil or playerId == nil) then
        print("^1[ERROR] \"plate\" or \"playerId\" was nil while giving a key for id " .. tostring(src))
        
        return false
    end

    local trimmedPlate = plate:gsub("^%s*(.-)%s*$", "%1"):upper()

	local playerData = ESX.GetPlayerFromId(src)
	local playerData2 = ESX.GetPlayerFromId(playerId)
    if (playerData and playerData2) then
        local rows = MySQL.Sync.execute("DELETE FROM vehicle_keys WHERE owner = @owner and (plate = @plate OR plate = @trimmedPlate) and count = 1", {
            ["@owner"]          = playerData.identifier,
            ["@plate"]          = plate,
            ["@trimmedPlate"]   = trimmedPlate
        })

        if (rows == 0) then
            rows = MySQL.Sync.execute("UPDATE vehicle_keys SET count = count - 1 WHERE owner = @owner and (plate = @plate OR plate = @trimmedPlate)", {
                ["@owner"]          = playerData.identifier,
                ["@plate"]          = plate,
                ["@trimmedPlate"]   = trimmedPlate
            })
        end

        if (rows == 0) then
            return false
        else
            local results = MySQL.Sync.fetchAll("SELECT count FROM vehicle_keys WHERE owner = @owner AND (plate = @plate OR plate = @trimmedPlate)", {
                ["@owner"]          = playerData2.identifier,
                ["@plate"]          = plate,
                ["@trimmedPlate"]   = trimmedPlate
            })

            rows = 0
            if (#results > 0) then
	            rows = MySQL.Sync.execute("UPDATE vehicle_keys SET count = count + 1 WHERE owner = @owner AND (plate = @plate OR plate = @trimmedPlate)", {
                    ["@owner"]          = playerData2.identifier,
                    ["@plate"]          = plate,
                    ["@trimmedPlate"]   = trimmedPlate
                })
            else
	            rows = MySQL.Sync.execute("INSERT INTO vehicle_keys (owner, plate, count) VALUES (@owner, @trimmedPlate, 1)", {
                    ["@owner"]          = playerData2.identifier,
                    ["@trimmedPlate"]   = trimmedPlate
                })
            end
            
            if (rows == 0) then
                return false
            end
        end
    else
        print("^1[ERROR] \"playerData\" or \"playerData2\" was nil while giving a key for id " .. tostring(src))
    
        return false
    end

    TriggerClientEvent("VKC:giveKeyNotif", playerId, trimmedPlate)

    return true
end)

-- give a master key to another player
CB:Register("VKC:giveMasterKeyToPlayer", function(source, plate, playerId)
    local src = source
    
    if (plate == nil or playerId == nil) then
        print("^1[ERROR] \"plate\" or \"playerId\" was nil while giving a master key for id " .. tostring(src))
        
        return false
    end

    local trimmedPlate = plate:gsub("^%s*(.-)%s*$", "%1"):upper()

	local playerData = ESX.GetPlayerFromId(src)
	local playerData2 = ESX.GetPlayerFromId(playerId)
    if (playerData and playerData2) then
        local rows = MySQL.Sync.execute("UPDATE owned_vehicles SET owner = @newOwner WHERE owner = @oldOwner and (plate = @plate OR plate = @trimmedPlate)", {
            ["@newOwner"]       = playerData2.identifier,
            ["@oldOwner"]       = playerData.identifier,
            ["@plate"]          = plate,
            ["@trimmedPlate"]   = trimmedPlate
        })

        if (rows == 0) then
            return false
        end
    else
        print("^1[ERROR] \"playerData\" or \"playerData2\" was nil while giving master key for id " .. tostring(src))
    
        return false
    end

    TriggerClientEvent("VKC:giveMasterKeyNotif", playerId, trimmedPlate)

    return true
end)

-- remove all keys from a plate
CB:Register("VKC:removeAllKeys", function(source, plate)
    local src = source
    
    if (plate == nil) then
        print("^1[ERROR] \"plate\" was nil while removing all keys for " .. tostring(src))
        
        return false
    end

	local playerData = ESX.GetPlayerFromId(src)
    if (playerData) then
        local trimmedPlate = plate:gsub("^%s*(.-)%s*$", "%1"):upper()
        
        if (playerData.getMoney() >= Config.Costs.exchangeLocks) then
            MySQL.Sync.execute("DELETE FROM vehicle_keys WHERE plate = @trimmedPlate", {
                ["@trimmedPlate"] = trimmedPlate
            })
            
            playerData.removeMoney(Config.Costs.exchangeLocks)

            return true
        else
            return "noMoney"
        end
    end

    return false
end)

-- get all owned vehicles from player
function GetPlayerVehicleData(playerId)
    if (playerId == nil) then
		print("^1[ERROR] Parameter \"playerId\" was nil while triggering server export \"GetOwnedVehicles\"!")
		return
	end

    local vehicles = {}

	local playerData = ESX.GetPlayerFromId(playerId)
    if (playerData) then
        local results = MySQL.Sync.fetchAll("SELECT plate, vehicle FROM owned_vehicles WHERE owner = @owner", {
            ["@owner"] = playerData.identifier
        })
        
        for i = 1, #results, 1 do
            table.insert(vehicles, {
                results[i].plate,
                json.decode(results[i].vehicle).model
            })
        end
    else
        print("^1[ERROR] \"playerData\" was nil while getting owned vehicles for id " .. tostring(playerId))
    end

    return vehicles
end
CB:Register("VKC:getPlayerVehicleData", GetPlayerVehicleData)

-- get all owned keys from player
function GetPlayerKeys(playerId)
    if (playerId == nil) then
		print("^1[ERROR] Parameter \"playerId\" was nil while triggering server export \"GetOwnedKeys\"!")
		return
	end

    local keys = {}

	local playerData = ESX.GetPlayerFromId(playerId)
    if (playerData) then
        local results = MySQL.Sync.fetchAll("SELECT vehicle_keys.plate, vehicle_keys.count, owned_vehicles.vehicle FROM vehicle_keys INNER JOIN owned_vehicles ON vehicle_keys.plate = owned_vehicles.plate WHERE vehicle_keys.owner = @owner", {
            ["@owner"] = playerData.identifier
        })
        
        for i = 1, #results, 1 do
            table.insert(keys, {
                plate = results[i].plate,
                count = results[i].count,
                model = json.decode(results[i].vehicle).model
            })
        end
    else
        print("^1[ERROR] \"playerData\" was nil while getting owned keys for id " .. tostring(playerId))
    end

    return keys
end
CB:Register("VKC:getPlayerKeys", GetPlayerKeys)

-- return if playerId is owner of vehicle
function IsVehicleOwner(playerId, plate)
    if (playerId == nil) then
		print("^1[ERROR] Parameter \"playerId\" was nil while triggering server export \"IsVehicleOwner\"!")
		return
	end
    if (plate == nil) then
		print("^1[ERROR] Parameter \"plate\" was nil while triggering server export \"IsVehicleOwner\"!")
		return
	end

	local playerData = ESX.GetPlayerFromId(playerId)
    if (playerData) then
        local trimmedPlate = plate:gsub("^%s*(.-)%s*$", "%1"):upper()

        local results = MySQL.Sync.fetchAll("SELECT plate FROM owned_vehicles WHERE owner = @owner and (plate = @plate OR plate = @trimmedPlate)", {
            ["@owner"]          = playerData.identifier,
            ["@plate"]          = plate,
            ["@trimmedPlate"]   = trimmedPlate
        })
        
        if (#results > 0) then
            return true
        end
    else
        print("^1[ERROR] \"playerData\" was nil while getting vehicle ownership for id " .. tostring(playerId))
    end

    return false
end
CB:Register("VKC:isVehicleOwner", IsVehicleOwner)

-- return if playerId is owner of key
function IsKeyOwner(playerId, plate, model)
    if (playerId == nil) then
		print("^1[ERROR] Parameter \"playerId\" was nil while triggering server export \"IsKeyOwner\"!")
		return
	end
    if (plate == nil) then
		print("^1[ERROR] Parameter \"plate\" was nil while triggering server export \"IsKeyOwner\"!")
		return
	end
    if (model == nil) then
		print("^1[ERROR] Parameter \"model\" was nil while triggering server export \"IsKeyOwner\"!")
		return
	end

	local playerData = ESX.GetPlayerFromId(playerId)
    if (playerData) then
        local trimmedPlate = plate:gsub("^%s*(.-)%s*$", "%1"):upper()

        if (IsJobVehicle(playerData.job.name, trimmedPlate, model)) then
            return true
        end
        
        local results = MySQL.Sync.fetchAll("SELECT plate FROM vehicle_keys WHERE owner = @owner and (plate = @plate OR plate = @trimmedPlate)", {
            ["@owner"]          = playerData.identifier,
            ["@plate"]          = plate,
            ["@trimmedPlate"]   = trimmedPlate
        })
    
        if (#results > 0) then
            return true
        end
    else
        print("^1[ERROR] \"playerData\" was nil while getting key ownership for id " .. tostring(playerId))
    end

    return false
end
CB:Register("VKC:isKeyOwner", IsKeyOwner)

-- return if playerId is owner of vehicle or key
function IsVehicleOrKeyOwner(playerId, plate, model)
    if (playerId == nil) then
		print("^1[ERROR] Parameter \"playerId\" was nil while triggering server export \"IsVehicleOrKeyOwner\"!")
		return
	end
    if (plate == nil) then
		print("^1[ERROR] Parameter \"plate\" was nil while triggering server export \"IsVehicleOrKeyOwner\"!")
		return
	end
    if (model == nil) then
		print("^1[ERROR] Parameter \"model\" was nil while triggering server export \"IsVehicleOrKeyOwner\"!")
		return
	end

	local playerData = ESX.GetPlayerFromId(playerId)
    if (playerData) then
        local trimmedPlate = plate:gsub("^%s*(.-)%s*$", "%1"):upper()
        
        if (IsJobVehicle(playerData.job.name, trimmedPlate, model)) then
            return true
        end
        
        local results = MySQL.Sync.fetchAll("SELECT plate FROM owned_vehicles WHERE owner = @owner and (plate = @plate OR plate = @trimmedPlate)", {
            ["@owner"]          = playerData.identifier,
            ["@plate"]          = plate,
            ["@trimmedPlate"]   = trimmedPlate
        })
    
        if (#results > 0) then
            return true
        end
    
        results = MySQL.Sync.fetchAll("SELECT plate FROM vehicle_keys WHERE owner = @owner and (plate = @plate OR plate = @trimmedPlate)", {
            ["@owner"]          = playerData.identifier,
            ["@plate"]          = plate,
            ["@trimmedPlate"]   = trimmedPlate
        })
    
        if (#results > 0) then
            return true
        end
    else
        print("^1[ERROR] \"playerData\" was nil while getting vehicle or key ownership for id " .. tostring(playerId))
    end

    return false
end
CB:Register("VKC:isVehicleOrKeyOwner", IsVehicleOrKeyOwner)



-- if the given vehicle is a job vehicle
function IsJobVehicle(job, plate, model)
    local jobData = Config.JobVehicles[job]
    
    if (jobData == nil) then
        return false
    end

    for i, m in ipairs(jobData.models) do
        if (m == model) then
            return true
        end
    end
    
    for i, p in ipairs(jobData.plates) do
        if (plate:find(p:upper())) then
            return true
        end
    end

    return false
end



-- toggle door lock over network to ensure it always works
RegisterServerEvent("VKC:toggleLockNet")
AddEventHandler("VKC:toggleLockNet", function(vehicleNetId, unlocked)
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if (DoesEntityExist(vehicle)) then
        local entityOwner = NetworkGetEntityOwner(vehicle)
        TriggerClientEvent("VKC:toggleLockOnPlayer", entityOwner, vehicleNetId, unlocked)
    end
end)
RegisterServerEvent("VKC:playDoorLockSoundNet")
AddEventHandler("VKC:playDoorLockSoundNet", function(vehicleNetId, lock)
    TriggerClientEvent("VKC:playDoorLockSound", -1, vehicleNetId, lock)
end)
