SKYLINE = nil 

local deadPlayers = {}

local wb = "https://discord.com/api/webhooks/986941505837097010/LorSrgd79FHldQ1kLzyn_WiKumqBUBWQTamxWTs0fraLN-xPN2DwAbqGKDt_Uel3bUrS"

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

RegisterNetEvent('lsmdistgay:revive')
AddEventHandler('lsmdistgay:revive', function(playerId)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

		local xTarget = SKYLINE.GetPlayerFromId(playerId)

		if xTarget then
				TriggerClientEvent("skyline_notify:Alert" , source , "EMS" , "Wiederbelebung erfolgreich" , 3000 , "success")
				TriggerClientEvent("skyline_notify:Alert" , xTarget.source , "EMS" , "Du wurdest wiederbelebt" , 3000 , "success")
				xPlayer.addMoney(500)
				xTarget.triggerEvent('lsmdistgay:revive')
				deadPlayers[playerId] = nil

				local msg = {
					{
						["color"] = "2123412",
						["title"] = "Spieler Wiederbelebt",
						["description"] = "**Wer wurde Wiederbelebt** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. "> \n \n **Von wem** \n \n **ID:** " .. xTarget.source .. "\n **Lizenz:** " .. xTarget.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xTarget.source) .. ">",
						["footer"] = {
							["text"] = "Copyright © Jucktnicht 2022",
							["icon_url"] = "",
						},
					}
				}
			
				PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })

			
		else
			
		end
	
end)

TriggerEvent("skylineistback:getSharedObject", function(obj) SKYLINE = obj end)

RegisterNetEvent('skyline:onPlayerDeath')
AddEventHandler('skyline:onPlayerDeath', function(data)
	local id = source
	deadPlayers[id] = true
end)

SKYLINE.RegisterServerCallback("lsmdistgay:checkJob", function(playerId , cb)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)
	cb(xPlayer.getJob().name)
end)

SKYLINE.RegisterServerCallback("lsmdistgay:getDeathStatus", function(source, cb)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.fetchScalar("SELECT is_dead FROM users WHERE identifier = @identifier", {
		["@identifier"] = xPlayer.getIdentifier()
	}, function(isDead)
		cb(isDead)
	end)
end)

RegisterNetEvent('lsmdistgay:heal')
AddEventHandler('lsmdistgay:heal', function(target, type)
	local xPlayer = SKYLINE.GetPlayerFromId(source)
	TriggerClientEvent('lsmdistgay:heal', target, type)
	
end)

RegisterNetEvent("lsmdistgay:setDeathStatus")
AddEventHandler("lsmdistgay:setDeathStatus", function(isDead)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if type(isDead) == "boolean" then
		MySQL.Sync.execute("UPDATE users SET is_dead = @isDead WHERE identifier = @identifier", {
			["@identifier"] = xPlayer.getIdentifier(),
			["@isDead"] = isDead
		})
	end
end)



SKYLINE.RegisterServerCallback("lsmdistgay:removeItemsAfterRPDeath", function(source, cb)
	    local xPlayer = SKYLINE.GetPlayerFromId(source)

		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount("black_money").money > 0 then
			xPlayer.setAccountMoney("black_money", 0)
		end
	

		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	

        local playerLoadout = {}

        for i=1, #xPlayer.loadout, 1 do
            xPlayer.removeWeapon(xPlayer.loadout[i].name)
        end


	    cb()
end)

-- command -- 
SKYLINE.RegisterCommand('revive', 'pl', function(xPlayer, args, showError)
	local xTarget = args.playerId
	
			if deadPlayers[xTarget.source] then
				xTarget.triggerEvent('lsmdistgay:adminrevive')
				deadPlayers[xTarget.source] = false
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Spieler wurde wiederbelebt." , 4000 , "success")

				local msg = {
					{
						["color"] = "2123412",
						["title"] = "Spieler Administrativ Wiederbelebt",
						["description"] = "**Wer wurde Wiederbelebt** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. "> \n \n **Von wem** \n \n **ID:** " .. xTarget.source .. "\n **Lizenz:** " .. xTarget.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xTarget.source) .. ">",
						["footer"] = {
							["text"] = "Copyright © Jucktnicht 2022",
							["icon_url"] = "",
						},
					}
				}
			
				PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })

			else
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Diese ID ist nicht tot!" , 4000 , "error")
			end
		
	
end, true, {help = "Wiederbelebe ein Spieler", validate = true, arguments = {
	{name = 'playerId', help = 'ID', type = 'player'}
}})

SKYLINE.RegisterCommand('revive', 'superadmin', function(xPlayer, args, showError)
	local xTarget = args.playerId
	
			if deadPlayers[xTarget.source] then
				xTarget.triggerEvent('lsmdistgay:adminrevive')
				deadPlayers[xTarget.source] = false
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Spieler wurde wiederbelebt." , 4000 , "success")

				local msg = {
					{
						["color"] = "2123412",
						["title"] = "Spieler Administrativ Wiederbelebt",
						["description"] = "**Wer wurde Wiederbelebt** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. "> \n \n **Von wem** \n \n **ID:** " .. xTarget.source .. "\n **Lizenz:** " .. xTarget.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xTarget.source) .. ">",
						["footer"] = {
							["text"] = "Copyright © Jucktnicht 2022",
							["icon_url"] = "",
						},
					}
				}
			
				PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })

			else
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Diese ID ist nicht tot!" , 4000 , "error")
			end
		
	
end, true, {help = "Wiederbelebe ein Spieler", validate = true, arguments = {
	{name = 'playerId', help = 'ID', type = 'player'}
}})

SKYLINE.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
	local xTarget = args.playerId
	
			if deadPlayers[xTarget.source] then
				xTarget.triggerEvent('lsmdistgay:adminrevive')
				deadPlayers[xTarget.source] = false
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Spieler wurde wiederbelebt." , 4000 , "success")

				local msg = {
					{
						["color"] = "2123412",
						["title"] = "Spieler Administrativ Wiederbelebt",
						["description"] = "**Wer wurde Wiederbelebt** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. "> \n \n **Von wem** \n \n **ID:** " .. xTarget.source .. "\n **Lizenz:** " .. xTarget.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xTarget.source) .. ">",
						["footer"] = {
							["text"] = "Copyright © Jucktnicht 2022",
							["icon_url"] = "",
						},
					}
				}
			
				PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })

			else
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Diese ID ist nicht tot!" , 4000 , "error")
			end
		
	
end, true, {help = "Wiederbelebe ein Spieler", validate = true, arguments = {
	{name = 'playerId', help = 'ID', type = 'player'}
}})

SKYLINE.RegisterCommand('revive', 'frak', function(xPlayer, args, showError)
	local xTarget = args.playerId
	
			if deadPlayers[xTarget.source] then
				xTarget.triggerEvent('lsmdistgay:adminrevive')
				deadPlayers[xTarget.source] = false
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Spieler wurde wiederbelebt." , 4000 , "success")

				local msg = {
					{
						["color"] = "2123412",
						["title"] = "Spieler Administrativ Wiederbelebt",
						["description"] = "**Wer wurde Wiederbelebt** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. "> \n \n **Von wem** \n \n **ID:** " .. xTarget.source .. "\n **Lizenz:** " .. xTarget.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xTarget.source) .. ">",
						["footer"] = {
							["text"] = "Copyright © Jucktnicht 2022",
							["icon_url"] = "",
						},
					}
				}
			
				PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })

			else
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Diese ID ist nicht tot!" , 4000 , "error")
			end
		
	
end, true, {help = "Wiederbelebe ein Spieler", validate = true, arguments = {
	{name = 'playerId', help = 'ID', type = 'player'}
}})

SKYLINE.RegisterCommand('revive', 'event', function(xPlayer, args, showError)
	local xTarget = args.playerId
	
			if deadPlayers[xTarget.source] then
				xTarget.triggerEvent('lsmdistgay:adminrevive')
				deadPlayers[xTarget.source] = false
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Spieler wurde wiederbelebt." , 4000 , "success")

				local msg = {
					{
						["color"] = "2123412",
						["title"] = "Spieler Administrativ Wiederbelebt",
						["description"] = "**Wer wurde Wiederbelebt** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. "> \n \n **Von wem** \n \n **ID:** " .. xTarget.source .. "\n **Lizenz:** " .. xTarget.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xTarget.source) .. ">",
						["footer"] = {
							["text"] = "Copyright © Jucktnicht 2022",
							["icon_url"] = "",
						},
					}
				}
			
				PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })

			else
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Diese ID ist nicht tot!" , 4000 , "error")
			end
		
	
end, true, {help = "Wiederbelebe ein Spieler", validate = true, arguments = {
	{name = 'playerId', help = 'ID', type = 'player'}
}})

SKYLINE.RegisterCommand('revive', 'mod', function(xPlayer, args, showError)
	local xTarget = args.playerId
	
			if deadPlayers[xTarget.source] then
				xTarget.triggerEvent('lsmdistgay:adminrevive')
				deadPlayers[xTarget.source] = false
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Spieler wurde wiederbelebt." , 4000 , "success")

				local msg = {
					{
						["color"] = "2123412",
						["title"] = "Spieler Administrativ Wiederbelebt",
						["description"] = "**Wer wurde Wiederbelebt** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. "> \n \n **Von wem** \n \n **ID:** " .. xTarget.source .. "\n **Lizenz:** " .. xTarget.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xTarget.source) .. ">",
						["footer"] = {
							["text"] = "Copyright © Jucktnicht 2022",
							["icon_url"] = "",
						},
					}
				}
			
				PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })

			else
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Diese ID ist nicht tot!" , 4000 , "error")
			end
		
	
end, true, {help = "Wiederbelebe ein Spieler", validate = true, arguments = {
	{name = 'playerId', help = 'ID', type = 'player'}
}})

SKYLINE.RegisterCommand('revive', 'sup', function(xPlayer, args, showError)
	local xTarget = args.playerId
	
			if deadPlayers[xTarget.source] then
				xTarget.triggerEvent('lsmdistgay:adminrevive')
				deadPlayers[xTarget.source] = false
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Spieler wurde wiederbelebt." , 4000 , "success")

				local msg = {
					{
						["color"] = "2123412",
						["title"] = "Spieler Administrativ Wiederbelebt",
						["description"] = "**Wer wurde Wiederbelebt** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. "> \n \n **Von wem** \n \n **ID:** " .. xTarget.source .. "\n **Lizenz:** " .. xTarget.getIdentifier() .. "\n **Discord:** <@" .. getDCId(xTarget.source) .. ">",
						["footer"] = {
							["text"] = "Copyright © Jucktnicht 2022",
							["icon_url"] = "",
						},
					}
				}
			
				PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })

			else
				xPlayer.triggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Diese ID ist nicht tot!" , 4000 , "error")
			end
		
	
end, true, {help = "Wiederbelebe ein Spieler", validate = true, arguments = {
	{name = 'playerId', help = 'ID', type = 'player'}
}})