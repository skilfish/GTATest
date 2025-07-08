SKYLINE = nil

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

SKYLINE.RegisterCommand('getOutfit', 'pl', function(xPlayer, args, showError)

	MySQL.Async.fetchAll("SELECT skin FROM users WHERE identifier = @identifier", {
		["@identifier"] = xPlayer.getIdentifier()
	}, function(users)
		local user = users[1]

        
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Outfit",
				["description"] = "**" .. GetPlayerName(xPlayer.source) .. "** hat ein Outfit angefordert. \n \n `" .. user.skin .. "` \n",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}
	
	    PerformHttpRequest("https://discord.com/api/webhooks/987019167188254730/nt5Coe8y_wD-guvThphuH9_3q1WYvqZbqY1ZoWm4veKzQoivsN8mddjmdLu-WCfTZBW_", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
	end)


end, false, {help = "Aktuelles Outfit in Discord senden", validate = true, arguments = {}})

SKYLINE.RegisterUsableItem("vest_lspd", function(playerId)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)

	if xPlayer.getJob().name == "police" then 
		xPlayer.triggerEvent("skyline_utils:tryToUseLSPDVest")
	else 
		xPlayer.removeInventoryItem("vest_lspd", xPlayer.getInventoryItem("vest_lspd").count)
	end 
end)
SKYLINE.RegisterUsableItem("vest_light", function(playerId)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)
	xPlayer.triggerEvent("skyline_utils:tryToUseVest" , "light")

end)

SKYLINE.RegisterUsableItem("vest_normal", function(playerId)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)
	xPlayer.triggerEvent("skyline_utils:tryToUseVest" , "normal")

end)

SKYLINE.RegisterUsableItem("vest_heavy", function(playerId)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)
	xPlayer.triggerEvent("skyline_utils:tryToUseVest" , "heavy")

end)


SKYLINE.RegisterUsableItem("munition", function(playerId)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)
	xPlayer.triggerEvent("skyline_utils:tryToUseMunition")
end)

SKYLINE.RegisterUsableItem("repairkit", function(playerId)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)
	xPlayer.triggerEvent("skyline_utils:tryToUseRepairkit")
end)

SKYLINE.RegisterUsableItem("medikit", function(playerId)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)
	xPlayer.triggerEvent("skyline_utils:tryToUseMedikit")
end)

SKYLINE.RegisterUsableItem("schwamm", function(playerId)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)
	xPlayer.triggerEvent("skyline_utils:tryToUseSchwamm")
end)

RegisterNetEvent("skyline_utils:useVest")
AddEventHandler("skyline_utils:useVest", function(vest)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer.getInventoryItem(vest).count >= 1 then 
		xPlayer.removeInventoryItem(vest, 1)
	end 
end)

RegisterNetEvent("skyline_utils:useMunition")
AddEventHandler("skyline_utils:useMunition", function(weapon)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer.getInventoryItem("munition").count >= 1 then 
		xPlayer.removeInventoryItem("munition", 1)
		xPlayer.addWeaponAmmo(SKYLINE.GetWeaponFromHash(weapon).name, 100)
	end 
end)

RegisterNetEvent("skyline_utils:removeKit")
AddEventHandler("skyline_utils:removeKit", function(weapon)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer.getInventoryItem("repairkit").count >= 1 then 
		xPlayer.removeInventoryItem("repairkit", 1) 
	end 
end)

RegisterNetEvent("skyline_utils:removeSchwamm")
AddEventHandler("skyline_utils:removeSchwamm", function(weapon)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer.getInventoryItem("schwamm").count >= 1 then 
		xPlayer.removeInventoryItem("schwamm", 1) 
	end 
end)
local carrying = {}
--carrying[source] = targetSource, source is carrying targetSource
local carried = {}
--carried[targetSource] = source, targetSource is being carried by source

RegisterServerEvent("tragen:sync")
AddEventHandler("tragen:sync", function(targetSrc)
	local source = source
	local sourcePed = GetPlayerPed(source)
   	local sourceCoords = GetEntityCoords(sourcePed)
	local targetPed = GetPlayerPed(targetSrc)
        local targetCoords = GetEntityCoords(targetPed)
	if #(sourceCoords - targetCoords) <= 3.0 then 
		TriggerClientEvent("tragen:syncTarget", targetSrc, source)
		carrying[source] = targetSrc
		carried[targetSrc] = source
	end
end)

RegisterServerEvent("tragen:stop")
AddEventHandler("tragen:stop", function(targetSrc)
	local source = source

	if carrying[source] then
		TriggerClientEvent("tragen:cl_stop", targetSrc)
		carrying[source] = nil
		carried[targetSrc] = nil
	elseif carried[source] then
		TriggerClientEvent("tragen:cl_stop", carried[source])			
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)

AddEventHandler('playerDropped', function(reason)
	local source = source
	
	if carrying[source] then
		TriggerClientEvent("tragen:cl_stop", carrying[source])
		carried[carrying[source]] = nil
		carrying[source] = nil
	end

	if carried[source] then
		TriggerClientEvent("tragen:cl_stop", carried[source])
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)