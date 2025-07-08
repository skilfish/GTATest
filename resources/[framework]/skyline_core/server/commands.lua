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



-- SETJOB -- 
SKYLINE.RegisterCommand('setjob', 'frak', function(xPlayer, args, showError)
	if SKYLINE.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob(args.job, args.grade)

		SKYLINE.SavePlayer(args.playerId ,function()end)


		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Job geändert",
				["description"] = "**Von wem wurde der Job geändert** \n **ID:** " .. args.playerId.source .. "\n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n**Neuer Job:** " .. args.job .. " \n \n **Wer hat den Job geändert** \n  **ID:** " .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}
	
		PerformHttpRequest("https://discord.com/api/webhooks/984462466618650644/Ansz-G-8GGjQcfFGXp2TG0r5D9vnfIgK7wJRAYxIE1WVnGnU5cxv3ywNtIIXarJNgMKh", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

		if args.playerId.source == xPlayer.source then 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Dein Job wurde <b style=color:red;>Administrativ</b> auf <b style=color:yellow;>" .. args.job .. "</b> gesetzt." , 5000 , "long")
		else 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Job erfolgreich den Spieler gegeben." , 5000 , "success")

			TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Dein Job wurde <b style=color:red;>Administrativ</b> auf <b style=color:yellow;>" .. args.job .. "</b> gesetzt." , 5000 , "long")
		end 
	else
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Den Job oder Rang gibt es nicht!" , 5000 , "info")
	end
end, false, {help = "Setze den Job von einem Spieler", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'job', help ="Job", type = 'string'},
	{name = 'grade', help = "Job-Rang", type = 'number'}
}})

SKYLINE.RegisterCommand('setjob', 'superadmin', function(xPlayer, args, showError)
	if SKYLINE.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob(args.job, args.grade)

		SKYLINE.SavePlayer(args.playerId ,function()end)

		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Job geändert",
				["description"] = "**Von wem wurde der Job geändert** \n **ID:** " .. args.playerId.source .. "\n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n**Neuer Job:** " .. args.job .. " \n \n **Wer hat den Job geändert** \n  **ID:** " .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}
	
		PerformHttpRequest("https://discord.com/api/webhooks/984462466618650644/Ansz-G-8GGjQcfFGXp2TG0r5D9vnfIgK7wJRAYxIE1WVnGnU5cxv3ywNtIIXarJNgMKh", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

		if args.playerId.source == xPlayer.source then 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Dein Job wurde <b style=color:red;>Administrativ</b> auf <b style=color:yellow;>" .. args.job .. "</b> gesetzt." , 5000 , "long")
		else 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Job erfolgreich den Spieler gegeben." , 5000 , "success")

			TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Dein Job wurde <b style=color:red;>Administrativ</b> auf <b style=color:yellow;>" .. args.job .. "</b> gesetzt." , 5000 , "long")
		end 
	else
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Den Job oder Rang gibt es nicht!" , 5000 , "info")
	end
end, false, {help = "Setze den Job von einem Spieler", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'job', help ="Job", type = 'string'},
	{name = 'grade', help = "Job-Rang", type = 'number'}
}})


SKYLINE.RegisterCommand('setjob', 'pl', function(xPlayer, args, showError)
	if SKYLINE.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob(args.job, args.grade)
		SKYLINE.SavePlayer(args.playerId ,function()end)



		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Job geändert",
				["description"] = "**Von wem wurde der Job geändert** \n **ID:** " .. args.playerId.source .. "\n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n**Neuer Job:** " .. args.job .. " \n \n **Wer hat den Job geändert** \n  **ID:** " .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}
	
		PerformHttpRequest("https://discord.com/api/webhooks/984462466618650644/Ansz-G-8GGjQcfFGXp2TG0r5D9vnfIgK7wJRAYxIE1WVnGnU5cxv3ywNtIIXarJNgMKh", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

		if args.playerId.source == xPlayer.source then 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Dein Job wurde <b style=color:red;>Administrativ</b> auf <b style=color:yellow;>" .. args.job .. "</b> gesetzt." , 5000 , "long")
		else 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Job erfolgreich den Spieler gegeben." , 5000 , "success")

			TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Dein Job wurde <b style=color:red;>Administrativ</b> auf <b style=color:yellow;>" .. args.job .. "</b> gesetzt." , 5000 , "long")
		end 
	else
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Den Job oder Rang gibt es nicht!" , 5000 , "info")
	end
end, false, {help = "Setze den Job von einem Spieler", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'job', help ="Job", type = 'string'},
	{name = 'grade', help = "Job-Rang", type = 'number'}
}})
-- SETJOB -- 


-- Car
SKYLINE.RegisterCommand('car', 'pl', function(xPlayer, args, showError)
	xPlayer.triggerEvent('skyline:spawnVehicle', args.car)
	xPlayer.triggerEvent("skyline_notify:Alert" , "ADMIN-SYSTEM" , "Fahrzeug gespawnt." , 3000 , "success")

	local msg = {
		{
			["color"] = "1752220",
			["title"] = "Fahrzeug gespawnt",
			["description"] = "**Welches Fahrzeug: **" .. args.car .. "\n \n **Von wem** \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
			["footer"] = {
				["text"] = "Copyright © Skyline 2022",
				["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
			},
		}
	}

	PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
end, false, {help ="Erschaffe ein Fahrzeug", validate = false, arguments = {
	{name = 'car', help = "Welches Fahrzeug?", type = 'any'}
}})

SKYLINE.RegisterCommand('car', 'superadmin', function(xPlayer, args, showError)
	xPlayer.triggerEvent('skyline:spawnVehicle', args.car)
	xPlayer.triggerEvent("skyline_notify:Alert" , "ADMIN-SYSTEM" , "Fahrzeug gespawnt." , 3000 , "success")

	local msg = {
		{
			["color"] = "1752220",
			["title"] = "Fahrzeug gespawnt",
			["description"] = "**Welches Fahrzeug: **" .. args.car .. "\n \n **Von wem** \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
			["footer"] = {
				["text"] = "Copyright © Skyline 2022",
				["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
			},
		}
	}

	PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
end, false, {help ="Erschaffe ein Fahrzeug", validate = false, arguments = {
	{name = 'car', help = "Welches Fahrzeug?", type = 'any'}
}})

SKYLINE.RegisterCommand('car', 'admin', function(xPlayer, args, showError)
	xPlayer.triggerEvent('skyline:spawnVehicle', args.car)
	xPlayer.triggerEvent("skyline_notify:Alert" , "ADMIN-SYSTEM" , "Fahrzeug gespawnt." , 3000 , "success")

	local msg = {
		{
			["color"] = "1752220",
			["title"] = "Fahrzeug gespawnt",
			["description"] = "**Welches Fahrzeug: **" .. args.car .. "\n \n **Von wem** \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
			["footer"] = {
				["text"] = "Copyright © Skyline 2022",
				["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
			},
		}
	}

	PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
end, false, {help ="Erschaffe ein Fahrzeug", validate = false, arguments = {
	{name = 'car', help = "Welches Fahrzeug?", type = 'any'}
}})

SKYLINE.RegisterCommand('car', 'frak', function(xPlayer, args, showError)
	xPlayer.triggerEvent('skyline:spawnVehicle', args.car)
	xPlayer.triggerEvent("skyline_notify:Alert" , "ADMIN-SYSTEM" , "Fahrzeug gespawnt." , 3000 , "success")

	local msg = {
		{
			["color"] = "1752220",
			["title"] = "Fahrzeug gespawnt",
			["description"] = "**Welches Fahrzeug: **" .. args.car .. "\n \n **Von wem** \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
			["footer"] = {
				["text"] = "Copyright © Skyline 2022",
				["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
			},
		}
	}

	PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
end, false, {help ="Erschaffe ein Fahrzeug", validate = false, arguments = {
	{name = 'car', help = "Welches Fahrzeug?", type = 'any'}
}})

SKYLINE.RegisterCommand('car', 'event', function(xPlayer, args, showError)
	xPlayer.triggerEvent('skyline:spawnVehicle', args.car)
	xPlayer.triggerEvent("skyline_notify:Alert" , "ADMIN-SYSTEM" , "Fahrzeug gespawnt." , 3000 , "success")

	local msg = {
		{
			["color"] = "1752220",
			["title"] = "Fahrzeug gespawnt",
			["description"] = "**Welches Fahrzeug: **" .. args.car .. "\n \n **Von wem** \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
			["footer"] = {
				["text"] = "Copyright © Skyline 2022",
				["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
			},
		}
	}

	PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
end, false, {help ="Erschaffe ein Fahrzeug", validate = false, arguments = {
	{name = 'car', help = "Welches Fahrzeug?", type = 'any'}
}})
-- CAR -- 

-- Dv --
SKYLINE.RegisterCommand({'cardel', 'dv'}, 'pl', function(xPlayer, args, showError)
	xPlayer.triggerEvent('skyline:deleteVehicle', args.radius)
	xPlayer.triggerEvent("skyline_notify:Alert" , "ADMIN-SYSTEM" , "Fahrzeug(e) gelöscht." , 3000 , "success")
	

	

	if args.radius ~= nil then 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Fahrzeug(e) gelöscht",
				["description"] = "**Radius: **" .. args.radius .. "\n \n **Von wem** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

	else 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Eigenes Fahrzeug gelöscht",
				["description"] = "**Von wem** \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
	
	end 
	


end, false, {help = "Fahrzeug im Radius löschen", validate = false, arguments = {
	{name = 'radius', help ="Radius", type = 'any'}
}})

SKYLINE.RegisterCommand({'cardel', 'dv'}, 'superadmin', function(xPlayer, args, showError)
	xPlayer.triggerEvent('skyline:deleteVehicle', args.radius)
	xPlayer.triggerEvent("skyline_notify:Alert" , "ADMIN-SYSTEM" , "Fahrzeug(e) gelöscht." , 3000 , "success")
	

	

	if args.radius ~= nil then 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Fahrzeug(e) gelöscht",
				["description"] = "**Radius: **" .. args.radius .. "\n \n **Von wem** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

	else 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Eigenes Fahrzeug gelöscht",
				["description"] = "**Von wem** \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
	
	end 
	


end, false, {help = "Fahrzeug im Radius löschen", validate = false, arguments = {
	{name = 'radius', help ="Radius", type = 'any'}
}})

SKYLINE.RegisterCommand({'cardel', 'dv'}, 'admin', function(xPlayer, args, showError)
	xPlayer.triggerEvent('skyline:deleteVehicle', args.radius)
	xPlayer.triggerEvent("skyline_notify:Alert" , "ADMIN-SYSTEM" , "Fahrzeug(e) gelöscht." , 3000 , "success")
	

	

	if args.radius ~= nil then 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Fahrzeug(e) gelöscht",
				["description"] = "**Radius: **" .. args.radius .. "\n \n **Von wem** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

	else 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Eigenes Fahrzeug gelöscht",
				["description"] = "**Von wem** \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
	
	end 
	


end, false, {help = "Fahrzeug im Radius löschen", validate = false, arguments = {
	{name = 'radius', help ="Radius", type = 'any'}
}})

SKYLINE.RegisterCommand({'cardel', 'dv'}, 'mod', function(xPlayer, args, showError)
	xPlayer.triggerEvent('skyline:deleteVehicle', args.radius)
	xPlayer.triggerEvent("skyline_notify:Alert" , "ADMIN-SYSTEM" , "Fahrzeug(e) gelöscht." , 3000 , "success")
	

	

	if args.radius ~= nil then 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Fahrzeug(e) gelöscht",
				["description"] = "**Radius: **" .. args.radius .. "\n \n **Von wem** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

	else 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Eigenes Fahrzeug gelöscht",
				["description"] = "**Von wem** \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
	
	end 
	


end, false, {help = "Fahrzeug im Radius löschen", validate = false, arguments = {
	{name = 'radius', help ="Radius", type = 'any'}
}})

SKYLINE.RegisterCommand({'cardel', 'dv'}, 'sup', function(xPlayer, args, showError)
	xPlayer.triggerEvent('skyline:deleteVehicle', args.radius)
	xPlayer.triggerEvent("skyline_notify:Alert" , "ADMIN-SYSTEM" , "Fahrzeug(e) gelöscht." , 3000 , "success")
	

	

	if args.radius ~= nil then 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Fahrzeug(e) gelöscht",
				["description"] = "**Radius: **" .. args.radius .. "\n \n **Von wem** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

	else 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Eigenes Fahrzeug gelöscht",
				["description"] = "**Von wem** \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
	
	end 
	


end, false, {help = "Fahrzeug im Radius löschen", validate = false, arguments = {
	{name = 'radius', help ="Radius", type = 'any'}
}})

SKYLINE.RegisterCommand({'cardel', 'dv'}, 'event', function(xPlayer, args, showError)
	xPlayer.triggerEvent('skyline:deleteVehicle', args.radius)
	xPlayer.triggerEvent("skyline_notify:Alert" , "ADMIN-SYSTEM" , "Fahrzeug(e) gelöscht." , 3000 , "success")
	

	

	if args.radius ~= nil then 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Fahrzeug(e) gelöscht",
				["description"] = "**Radius: **" .. args.radius .. "\n \n **Von wem** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

	else 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Eigenes Fahrzeug gelöscht",
				["description"] = "**Von wem** \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
	
	end 
	


end, false, {help = "Fahrzeug im Radius löschen", validate = false, arguments = {
	{name = 'radius', help ="Radius", type = 'any'}
}})

SKYLINE.RegisterCommand({'cardel', 'dv'}, 'frak', function(xPlayer, args, showError)
	xPlayer.triggerEvent('skyline:deleteVehicle', args.radius)
	xPlayer.triggerEvent("skyline_notify:Alert" , "ADMIN-SYSTEM" , "Fahrzeug(e) gelöscht." , 3000 , "success")
	

	

	if args.radius ~= nil then 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Fahrzeug(e) gelöscht",
				["description"] = "**Radius: **" .. args.radius .. "\n \n **Von wem** \n \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

	else 
		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Eigenes Fahrzeug gelöscht",
				["description"] = "**Von wem** \n **ID:** " .. xPlayer.source .. "\n **Lizenz: **" .. xPlayer.identifier .. "\n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}

		PerformHttpRequest("https://discord.com/api/webhooks/984466175855571015/iuLkuxyMQ3UmCybTgQbIbSAm2fKu1ySyCX4BQmrpv8s4ZjtnryecsirMcFeagylL2Hny", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
	
	end 
	


end, false, {help = "Fahrzeug im Radius löschen", validate = false, arguments = {
	{name = 'radius', help ="Radius", type = 'any'}
}})
-- DV -- 

-- SETACCOUNTMONEY -- 
SKYLINE.RegisterCommand('setaccountmoney', 'pl', function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		args.playerId.setAccountMoney(args.account, args.amount)

		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Geld gesetzt",
				["description"] = "**Was wurde gesetzt** \n \n **Account:** " .. args.account .. "\n **Menge:** " .. args.amount .. "$ \n \n **Von wem:** \n \n **ID:** " .. args.playerId.source .. " \n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n \n **Wer hat den Account gesetzt** \n \n **ID: **" .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. " \n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}
	
		PerformHttpRequest("https://discord.com/api/webhooks/984471254482427995/GiwyYGrJJLfZkNlPv22snODhQT0hO-of8BurMHIAmIcZUnqSlY2QxUxipyKMP3GDJXa0", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

		if args.playerId.source == xPlayer.source then 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Der Betrag von dem Account <b style=color:yellow;>" .. args.account .. "</b> wurde auf <b style=color:yellow;>" .. args.amount .. "</b> gesetzt" , 5000 , "long")
		else 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Account Betrag vom Spieler gesetzt." , 5000 , "success")

			TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Der Betrag von dem Account <b style=color:yellow;>" .. args.account .. "</b> wurde auf <b style=color:yellow;>" .. args.amount .. "</b> gesetzt" , 5000 , "long")
		end 
	else
		showError("Fehler! Üperprüfe die Argumente!")
	end
end, true, {help = "Setze das Geld eines Spielers!", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'account', help = "bank, money oder black_money", type = 'string'},
	{name = 'amount', help = "Menge", type = 'number'}
}})

SKYLINE.RegisterCommand('setaccountmoney', 'superadmin', function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		args.playerId.setAccountMoney(args.account, args.amount)

		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Geld gesetzt",
				["description"] = "**Was wurde gesetzt** \n \n **Account:** " .. args.account .. "\n **Menge:** " .. args.amount .. "$ \n \n **Von wem:** \n \n **ID:** " .. args.playerId.source .. " \n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n \n **Wer hat den Account gesetzt** \n \n **ID: **" .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. " \n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}
	
		PerformHttpRequest("https://discord.com/api/webhooks/984471254482427995/GiwyYGrJJLfZkNlPv22snODhQT0hO-of8BurMHIAmIcZUnqSlY2QxUxipyKMP3GDJXa0", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

		if args.playerId.source == xPlayer.source then 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Der Betrag von dem Account <b style=color:yellow;>" .. args.account .. "</b> wurde auf <b style=color:yellow;>" .. args.amount .. "</b> gesetzt" , 5000 , "long")
		else 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Account Betrag vom Spieler gesetzt." , 5000 , "success")

			TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Der Betrag von dem Account <b style=color:yellow;>" .. args.account .. "</b> wurde auf <b style=color:yellow;>" .. args.amount .. "</b> gesetzt" , 5000 , "long")
		end 
	else
		showError("Fehler! Üperprüfe die Argumente!")
	end
end, true, {help = "Setze das Geld eines Spielers!", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'account', help = "bank, money oder black_money", type = 'string'},
	{name = 'amount', help = "Menge", type = 'number'}
}})
-- SETACCOUNTMONEY -- 

-- GIVEACCOUNTMONEY --

SKYLINE.RegisterCommand('giveaccountmoney', 'pl', function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		args.playerId.addAccountMoney(args.account, args.amount)

		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Geld gegeben",
				["description"] = "**Was wurde gegeben** \n \n **Account:** " .. args.account .. "\n **Menge:** " .. args.amount .. "$ \n \n **Von wem:** \n \n **ID:** " .. args.playerId.source .. " \n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n \n **Wer hat den Account Geld gegeben** \n \n **ID: **" .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. " \n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}
	
		PerformHttpRequest("https://discord.com/api/webhooks/984471254482427995/GiwyYGrJJLfZkNlPv22snODhQT0hO-of8BurMHIAmIcZUnqSlY2QxUxipyKMP3GDJXa0", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

		if args.playerId.source == xPlayer.source then 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Der Betrag von dem Account <b style=color:yellow;>" .. args.account .. "</b> wurde um <b style=color:yellow;>" .. args.amount .. "</b> erhöht" , 5000 , "long")
		else 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Account Betrag vom Spieler gegeben." , 5000 , "success")

			TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Der Betrag von dem Account <b style=color:yellow;>" .. args.account .. "</b> wurde um <b style=color:yellow;>" .. args.amount .. "</b> erhöht." , 5000 , "long")
		end 
	else
		showError("Fehler! Üperprüfe die Argumente!")
	end
end, true, {help = "Gebe Geld an einen Spieler!", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'account', help = "bank, money oder black_money", type = 'string'},
	{name = 'amount', help = "Menge", type = 'number'}
}})

SKYLINE.RegisterCommand('giveaccountmoney', 'superadmin', function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		args.playerId.addAccountMoney(args.account, args.amount)

		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Geld gegeben",
				["description"] = "**Was wurde gegeben** \n \n **Account:** " .. args.account .. "\n **Menge:** " .. args.amount .. "$ \n \n **Von wem:** \n \n **ID:** " .. args.playerId.source .. " \n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n \n **Wer hat den Account Geld gegeben** \n \n **ID: **" .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. " \n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}
	
		PerformHttpRequest("https://discord.com/api/webhooks/984471254482427995/GiwyYGrJJLfZkNlPv22snODhQT0hO-of8BurMHIAmIcZUnqSlY2QxUxipyKMP3GDJXa0", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })

		if args.playerId.source == xPlayer.source then 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Der Betrag von dem Account <b style=color:yellow;>" .. args.account .. "</b> wurde um <b style=color:yellow;>" .. args.amount .. "</b> erhöht" , 5000 , "long")
		else 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Account Betrag vom Spieler gegeben." , 5000 , "success")

			TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Der Betrag von dem Account <b style=color:yellow;>" .. args.account .. "</b> wurde um <b style=color:yellow;>" .. args.amount .. "</b> erhöht." , 5000 , "long")
		end 
	else
		showError("Fehler! Üperprüfe die Argumente!")
	end
end, true, {help = "Gebe Geld an einen Spieler!", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'account', help = "bank, money oder black_money", type = 'string'},
	{name = 'amount', help = "Menge", type = 'number'}
}})
-- GIVEACCOUNTMONEY --


-- GIVEITEM -- 

SKYLINE.RegisterCommand('giveitem', 'pl', function(xPlayer, args, showError)
	args.playerId.addInventoryItem(args.item, args.count)

	
	if args.playerId.source == xPlayer.source then 
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Du hast dir <b style=color:yellow;> " .. args.count .. "x " .. args.item .. "</b> gegeben." , 5000 , "long")
	else 
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Item(s) den Spieler gegeben." , 5000 , "success")
		TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Du hast <b style=color:yellow;> " .. args.count .. "x " .. args.item .. "</b> <b style=color:red;>Administrativ<b/> bekommen." , 5000 , "long")

	end 

	
	local msg = {
		{
			["color"] = "1752220",
			["title"] = "Item gegebn",
			["description"] = "**Was wurde gegeben** \n \n **Item:** " .. args.item .. "\n **Menge:** " .. args.count .. " \n \n **Von wem:** \n \n **ID:** " .. args.playerId.source .. " \n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n \n **Wer hat den Account Geld gegeben** \n \n **ID: **" .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. " \n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
			["footer"] = {
				["text"] = "Copyright © Skyline 2022",
				["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
			},
		}
	}

	PerformHttpRequest("https://discord.com/api/webhooks/984478154393530468/JWc_e3MEfZpK6ALlxrvQuf4NZLEJySYgji7a5n0o5kppw0KmbfiaKPFXOJkSuycOV7tI", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })


end, true, {help = "Gebe ein Spieler Items", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'item', help = "Welches Item?", type = 'item'},
	{name = 'count', help = "Menge", type = 'number'}
}})

SKYLINE.RegisterCommand('giveitem', 'superadmin', function(xPlayer, args, showError)
	args.playerId.addInventoryItem(args.item, args.count)

	
	if args.playerId.source == xPlayer.source then 
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Du hast dir <b style=color:yellow;> " .. args.count .. "x " .. args.item .. "</b> gegeben." , 5000 , "long")
	else 
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Item(s) den Spieler gegeben." , 5000 , "success")
		TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Du hast <b style=color:yellow;> " .. args.count .. "x " .. args.item .. "</b> <b style=color:red;>Administrativ<b/> bekommen." , 5000 , "long")

	end 

	
	local msg = {
		{
			["color"] = "1752220",
			["title"] = "Item gegebn",
			["description"] = "**Was wurde gegeben** \n \n **Item:** " .. args.item .. "\n **Menge:** " .. args.count .. " \n \n **Von wem:** \n \n **ID:** " .. args.playerId.source .. " \n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n \n **Wer hat den Account Geld gegeben** \n \n **ID: **" .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. " \n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
			["footer"] = {
				["text"] = "Copyright © Skyline 2022",
				["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
			},
		}
	}

	PerformHttpRequest("https://discord.com/api/webhooks/984478154393530468/JWc_e3MEfZpK6ALlxrvQuf4NZLEJySYgji7a5n0o5kppw0KmbfiaKPFXOJkSuycOV7tI", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })


end, true, {help = "Gebe ein Spieler Items", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'item', help = "Welches Item?", type = 'item'},
	{name = 'count', help = "Menge", type = 'number'}
}})

SKYLINE.RegisterCommand('giveitem', 'admin', function(xPlayer, args, showError)
	args.playerId.addInventoryItem(args.item, args.count)

	
	if args.playerId.source == xPlayer.source then 
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Du hast dir <b style=color:yellow;> " .. args.count .. "x " .. args.item .. "</b> gegeben." , 5000 , "long")
	else 
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Item(s) den Spieler gegeben." , 5000 , "success")
		TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Du hast <b style=color:yellow;> " .. args.count .. "x " .. args.item .. "</b> <b style=color:red;>Administrativ<b/> bekommen." , 5000 , "long")

	end 

	
	local msg = {
		{
			["color"] = "1752220",
			["title"] = "Item gegebn",
			["description"] = "**Was wurde gegeben** \n \n **Item:** " .. args.item .. "\n **Menge:** " .. args.count .. " \n \n **Von wem:** \n \n **ID:** " .. args.playerId.source .. " \n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n \n **Wer hat den Account Geld gegeben** \n \n **ID: **" .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. " \n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
			["footer"] = {
				["text"] = "Copyright © Skyline 2022",
				["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
			},
		}
	}

	PerformHttpRequest("https://discord.com/api/webhooks/984478154393530468/JWc_e3MEfZpK6ALlxrvQuf4NZLEJySYgji7a5n0o5kppw0KmbfiaKPFXOJkSuycOV7tI", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })


end, true, {help = "Gebe ein Spieler Items", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'item', help = "Welches Item?", type = 'item'},
	{name = 'count', help = "Menge", type = 'number'}
}})

SKYLINE.RegisterCommand('giveitem', 'mod', function(xPlayer, args, showError)
	args.playerId.addInventoryItem(args.item, args.count)

	
	if args.playerId.source == xPlayer.source then 
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Du hast dir <b style=color:yellow;> " .. args.count .. "x " .. args.item .. "</b> gegeben." , 5000 , "long")
	else 
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Item(s) den Spieler gegeben." , 5000 , "success")
		TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Du hast <b style=color:yellow;> " .. args.count .. "x " .. args.item .. "</b> <b style=color:red;>Administrativ<b/> bekommen." , 5000 , "long")

	end 

	
	local msg = {
		{
			["color"] = "1752220",
			["title"] = "Item gegebn",
			["description"] = "**Was wurde gegeben** \n \n **Item:** " .. args.item .. "\n **Menge:** " .. args.count .. " \n \n **Von wem:** \n \n **ID:** " .. args.playerId.source .. " \n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n \n **Wer hat den Account Geld gegeben** \n \n **ID: **" .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. " \n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
			["footer"] = {
				["text"] = "Copyright © Skyline 2022",
				["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
			},
		}
	}

	PerformHttpRequest("https://discord.com/api/webhooks/984478154393530468/JWc_e3MEfZpK6ALlxrvQuf4NZLEJySYgji7a5n0o5kppw0KmbfiaKPFXOJkSuycOV7tI", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })


end, true, {help = "Gebe ein Spieler Items", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'item', help = "Welches Item?", type = 'item'},
	{name = 'count', help = "Menge", type = 'number'}
}})

SKYLINE.RegisterCommand('giveitem', 'event', function(xPlayer, args, showError)
	args.playerId.addInventoryItem(args.item, args.count)

	
	if args.playerId.source == xPlayer.source then 
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Du hast dir <b style=color:yellow;> " .. args.count .. "x " .. args.item .. "</b> gegeben." , 5000 , "long")
	else 
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Item(s) den Spieler gegeben." , 5000 , "success")
		TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Du hast <b style=color:yellow;> " .. args.count .. "x " .. args.item .. "</b> <b style=color:red;>Administrativ<b/> bekommen." , 5000 , "long")

	end 

	
	local msg = {
		{
			["color"] = "1752220",
			["title"] = "Item gegebn",
			["description"] = "**Was wurde gegeben** \n \n **Item:** " .. args.item .. "\n **Menge:** " .. args.count .. " \n \n **Von wem:** \n \n **ID:** " .. args.playerId.source .. " \n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n \n **Wer hat den Account Geld gegeben** \n \n **ID: **" .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. " \n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
			["footer"] = {
				["text"] = "Copyright © Skyline 2022",
				["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
			},
		}
	}

	PerformHttpRequest("https://discord.com/api/webhooks/984478154393530468/JWc_e3MEfZpK6ALlxrvQuf4NZLEJySYgji7a5n0o5kppw0KmbfiaKPFXOJkSuycOV7tI", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })


end, true, {help = "Gebe ein Spieler Items", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'item', help = "Welches Item?", type = 'item'},
	{name = 'count', help = "Menge", type = 'number'}
}})

SKYLINE.RegisterCommand('giveitem', 'frak', function(xPlayer, args, showError)
	args.playerId.addInventoryItem(args.item, args.count)

	
	if args.playerId.source == xPlayer.source then 
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Du hast dir <b style=color:yellow;> " .. args.count .. "x " .. args.item .. "</b> gegeben." , 5000 , "long")
	else 
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Item(s) den Spieler gegeben." , 5000 , "success")
		TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Du hast <b style=color:yellow;> " .. args.count .. "x " .. args.item .. "</b> <b style=color:red;>Administrativ<b/> bekommen." , 5000 , "long")

	end 

	
	local msg = {
		{
			["color"] = "1752220",
			["title"] = "Item gegebn",
			["description"] = "**Was wurde gegeben** \n \n **Item:** " .. args.item .. "\n **Menge:** " .. args.count .. " \n \n **Von wem:** \n \n **ID:** " .. args.playerId.source .. " \n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n \n **Wer hat den Account Geld gegeben** \n \n **ID: **" .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. " \n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
			["footer"] = {
				["text"] = "Copyright © Skyline 2022",
				["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
			},
		}
	}

	PerformHttpRequest("https://discord.com/api/webhooks/984478154393530468/JWc_e3MEfZpK6ALlxrvQuf4NZLEJySYgji7a5n0o5kppw0KmbfiaKPFXOJkSuycOV7tI", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })


end, true, {help = "Gebe ein Spieler Items", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'item', help = "Welches Item?", type = 'item'},
	{name = 'count', help = "Menge", type = 'number'}
}})
-- GIVEITEM -- 

-- GIVEWEAPON --

SKYLINE.RegisterCommand('giveweapon', 'pl', function(xPlayer, args, showError)
	if args.playerId.hasWeapon(args.weapon) then
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Der Spieler hat diese Waffe bereits." , 5000 , "error")
	else
		xPlayer.addWeapon(args.weapon, args.ammo)

		if args.playerId.source == xPlayer.source then 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Du hast dir die <b style=color:yellow;>" .. args.weapon .. "</b> gegeben." , 5000 , "long")
		else 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Waffe dem Spieler gegeben." , 5000 , "success")
			TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Du hast <b style=color:yellow;> " .. args.weapon .. "</b> <b style=color:red;>Administrativ<b/> bekommen." , 5000 , "long")
		end 

		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Waffe gegebn",
				["description"] = "**Was wurde gegeben** \n \n **Item:** " .. args.weapon .. "\n **Munition:** " .. args.ammo .. " \n \n **Von wem:** \n \n **ID:** " .. args.playerId.source .. " \n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n \n **Wer hat den Account Geld gegeben** \n \n **ID: **" .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. " \n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}
	
		PerformHttpRequest("https://discord.com/api/webhooks/984478154393530468/JWc_e3MEfZpK6ALlxrvQuf4NZLEJySYgji7a5n0o5kppw0KmbfiaKPFXOJkSuycOV7tI", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
	end
end, true, {help = "Waffe geben", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'weapon', help = "Welche Waffe?", type = 'weapon'},
	{name = 'ammo', help = "Munition", type = 'number'}
}})

SKYLINE.RegisterCommand('giveweapon', 'superadmin', function(xPlayer, args, showError)
	if args.playerId.hasWeapon(args.weapon) then
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Der Spieler hat diese Waffe bereits." , 5000 , "error")
	else
		xPlayer.addWeapon(args.weapon, args.ammo)

		if args.playerId.source == xPlayer.source then 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Du hast dir die <b style=color:yellow;>" .. args.weapon .. "</b> gegeben." , 5000 , "long")
		else 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Waffe dem Spieler gegeben." , 5000 , "success")
			TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Du hast <b style=color:yellow;> " .. args.weapon .. "</b> <b style=color:red;>Administrativ<b/> bekommen." , 5000 , "long")
		end 

		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Waffe gegebn",
				["description"] = "**Was wurde gegeben** \n \n **Item:** " .. args.weapon .. "\n **Munition:** " .. args.ammo .. " \n \n **Von wem:** \n \n **ID:** " .. args.playerId.source .. " \n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n \n **Wer hat den Account Geld gegeben** \n \n **ID: **" .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. " \n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}
	
		PerformHttpRequest("https://discord.com/api/webhooks/984478154393530468/JWc_e3MEfZpK6ALlxrvQuf4NZLEJySYgji7a5n0o5kppw0KmbfiaKPFXOJkSuycOV7tI", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
	end
end, true, {help = "Waffe geben", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'weapon', help = "Welche Waffe?", type = 'weapon'},
	{name = 'ammo', help = "Munition", type = 'number'}
}})

SKYLINE.RegisterCommand('giveweapon', 'admin', function(xPlayer, args, showError)
	if args.playerId.hasWeapon(args.weapon) then
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Der Spieler hat diese Waffe bereits." , 5000 , "error")
	else
		xPlayer.addWeapon(args.weapon, args.ammo)

		if args.playerId.source == xPlayer.source then 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Du hast dir die <b style=color:yellow;>" .. args.weapon .. "</b> gegeben." , 5000 , "long")
		else 
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "ADMIN-SYSTEM" , "Waffe dem Spieler gegeben." , 5000 , "success")
			TriggerClientEvent("skyline_notify:Alert", args.playerId.source, "ADMIN-SYSTEM" , "Du hast <b style=color:yellow;> " .. args.weapon .. "</b> <b style=color:red;>Administrativ<b/> bekommen." , 5000 , "long")
		end 

		local msg = {
			{
				["color"] = "1752220",
				["title"] = "Waffe gegebn",
				["description"] = "**Was wurde gegeben** \n \n **Item:** " .. args.weapon .. "\n **Munition:** " .. args.ammo .. " \n \n **Von wem:** \n \n **ID:** " .. args.playerId.source .. " \n **Lizenz:** " .. args.playerId.identifier .. "\n **Discord:** <@" .. getDCId(args.playerId.source) .. "> \n \n **Wer hat den Account Geld gegeben** \n \n **ID: **" .. xPlayer.source .. "\n **Lizenz:** " .. xPlayer.identifier .. " \n **Discord:** <@" .. getDCId(xPlayer.source) .. ">",
				["footer"] = {
					["text"] = "Copyright © Skyline 2022",
					["icon_url"] = "https://cdn.discordapp.com/attachments/980465949180297248/984421576986472458/Skyline.gif",
				},
			}
		}
	
		PerformHttpRequest("https://discord.com/api/webhooks/984478154393530468/JWc_e3MEfZpK6ALlxrvQuf4NZLEJySYgji7a5n0o5kppw0KmbfiaKPFXOJkSuycOV7tI", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - LOGS", embeds = msg}), { ['Content-Type'] = 'application/json' })
	end
end, true, {help = "Waffe geben", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'weapon', help = "Welche Waffe?", type = 'weapon'},
	{name = 'ammo', help = "Munition", type = 'number'}
}})
-- GIVEWEAPON --

-- SEGROUP --
SKYLINE.RegisterCommand('setgroup', 'pl', function(xPlayer, args, showError)
	args.playerId.setGroup(args.group)
end, true, {help = "Rechte geben", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'player'},
	{name = 'group', help = "Gruppe", type = 'string'},
}})
-- SEGROUP --


