RegisterServerEvent("spielerskin:save")
AddEventHandler("spielerskin:save", function(skin)
	local wPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.execute("UPDATE users SET `skin` = @skin WHERE identifier = @identifier",
	{
		["@skin"]       = json.encode(skin),
		["@identifier"] = wPlayer.identifier
	})
end)


SKYLINE.RegisterServerCallback("spielerskin:getPlayerSkin", function(source, cb)
	local wPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.fetchAll("SELECT skin FROM users WHERE identifier = @identifier", {
		["@identifier"] = wPlayer.identifier
	}, function(users)
		local user = users[1]
		local skin = nil

		local jobSkin = {
			skin_male   = wPlayer.job.skin_male,
			skin_female = wPlayer.job.skin_female
		}

		if user.skin ~= nil then
			skin = json.decode(user.skin)
		end

		cb(skin, jobSkin)
	end)
end)

-- Commands
RegisterCommand("skin", function(source, args, rawCommand)
    if (source > 0) then
		local wPlayer = SKYLINE.GetPlayerFromId(source)

		if wPlayer.getGroup() == "superadmin" or wPlayer.getGroup() == "admin" or wPlayer.getGroup() == "pl" then 
			TriggerClientEvent("spielerskin:openSaveableMenu", source)
		end 
    else
        print("Der Befehl kann nur als Spieler ausgeführt werden.")
    end
end, false)
