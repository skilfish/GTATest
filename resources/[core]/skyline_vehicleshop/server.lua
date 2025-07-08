SKYLINE = nil
TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

local wb = "https://discord.com/api/webhooks/986679371454640150/KDgjIh-atZC_7nA-4OvJAJp9MzKRFCwScM4_52j7xrvcbWLUYk5-oKiCvRDMMzFpcP7h"
 

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



SKYLINE.RegisterServerCallback('sc-vehicleshop:checkPlatePrice', function(source, cb, plate) 
    local xPlayer = SKYLINE.GetPlayerFromId(source)
    if tonumber(xPlayer.getQuantity("cash")) >= 3000 then 
      cardata = MySQl.Sync.execute("SELECT plate FROM owned_vehicles WHERE plate='"..plate.."' ", {})
      if #cardata == 0 then 
        cb(true)
        xPlayer.removeInventoryItem("cash", 3000)
      end
    else
        TriggerClientEvent("skyline_notify:Alert", source, "AUTO-SHOP" , "Du hast nicht genug Geld dabei!" , 4000 , "error")
    end
end)

RegisterNetEvent('SKYLINE_vehicleshop:setJobVehicleState')
AddEventHandler('SKYLINE_vehicleshop:setJobVehicleState', function(plate, state)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate AND job = @job', {
		['@stored'] = state,
		['@plate'] = plate,
		['@job'] = xPlayer.job.name
	}, function(rowsChanged)
		if rowsChanged == 0 then
			--print(('[SKYLINE_vehicleshop] [^3WARNING^7] %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)


SKYLINE.RegisterServerCallback('SKYLINE_vehicleshop:retrieveJobVehicles', function(source, cb, type)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.execute('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type,
		['@job'] = xPlayer.job.name
	}, function(result)
		cb(result)
	end)
end)

SKYLINE.RegisterServerCallback('SKYLINE_vehicleshop:isPlateTaken', function (source, cb, plate)
    MySQL.Async.execute('SELECT * FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function (result)
        cb(result[1] ~= nil)
    end)
end)


SKYLINE.RegisterServerCallback('skyline_vehicleshop:checkPrice', function(source, cb, data) 
    local src = source
    local xPlayer = SKYLINE.GetPlayerFromId(src)
    local money = xPlayer.getMoney()

    
    if(money >= data.price) then 
        xPlayer.removeMoney(data.price)

        local msg = {
            {
                ["color"] = "2123412",
                ["title"] = "Auto gekauft",
                ["description"] = "**Welches Auto gekauft wurde:** " .. data.name .. "\n**Preis: **" .. data.price .. "$\n **Wo: **" .. data.shop .. " \n \n **Gekauft von: **" .. xPlayer.getName() .. "\nLizenz: " .. xPlayer.getIdentifier() .. " \nDiscord: <@" .. getDCId(xPlayer.source) .. ">",
                ["footer"] = {
                    ["text"] = "Copyright © Jucktnicht 2022",
                    ["icon_url"] = "",
                },
            }
        }
    
        PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })

        cb(true)
    else 
        cb(false)
    end 
end)

SKYLINE.RegisterServerCallback('skyline_vehicleshop:isPlateTaken', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

 

RegisterNetEvent('skyline_vehicleshop:server:givecar')
AddEventHandler('skyline_vehicleshop:server:givecar', function(props)
    local src = source
    local Player = SKYLINE.GetPlayerFromId(src)
    MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES ('"..Player.identifier.."', '"..props.plate.."', '"..json.encode(props).."')", {  })
    local info = {model = props.model, plaka = props.plate}
    Player.addInventoryItem('carkey', 1, false, info)
end)
