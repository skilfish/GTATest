Citizen.CreateThread(function()
	SetMapName('San Andreas')
	SetGameType('Roleplay')
end)

RegisterNetEvent('skyline:onPlayerJoined')
AddEventHandler('skyline:onPlayerJoined', function()
	if not SKYLINE.Players[source] then
		onPlayerJoined(source)
	end
end)




function onPlayerJoined(playerId)
	local identifier

	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
			break
		end
	end

	if identifier then
			--DropPlayer(playerId, ('there was an error loading your character!\nError code: identifier-active-ingame\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same Rockstar account.\n\nYour Rockstar identifier: %s'):format(identifier))
		
			MySQL.Async.fetchScalar('SELECT 1 FROM users WHERE identifier = @identifier', {
				['@identifier'] = identifier
			}, function(result)
				if result then
					loadESXPlayer(identifier, playerId)
				else
					local accounts = {}

					for account,money in pairs(Config.StartingAccountMoney) do
						accounts[account] = money
					end

					MySQL.Async.execute('INSERT INTO users (accounts, identifier) VALUES (@accounts, @identifier)', {
						['@accounts'] = json.encode(accounts),
						['@identifier'] = identifier
					}, function(rowsChanged)
						loadESXPlayer(identifier, playerId)
					end)
				end
			end)
		
	else
		--DropPlayer(playerId, 'there was an error loading your character!\nError code: identifier-missing-ingame\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
	end
end

AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
	deferrals.defer()
	local playerId, identifier = source
	Citizen.Wait(100)

	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
			break
		end
	end

	if identifier then
		if SKYLINE.GetPlayerFromIdentifier(identifier) then
			deferrals.done(('There was an error loading your character!\nError code: identifier-active\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same Rockstar account.\n\nYour Rockstar identifier: %s'):format(identifier))
		else
			deferrals.done()
		end
	else
		deferrals.done('There was an error loading your character!\nError code: identifier-missing\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
	end
end)


function loadESXPlayer(identifier, playerId)
	local tasks = {}

	local userData = {
		accounts = {},
		inventory = {},
		job = {},
		loadout = {},
		playerName = GetPlayerName(playerId),
		weight = 0
	}

	table.insert(tasks, function(cb)
		MySQL.Async.fetchAll('SELECT accounts, job, job_grade, `group`, loadout, position, inventory FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(result)
			local job, grade, jobObject, gradeObject = result[1].job, tostring(result[1].job_grade)
			local foundAccounts, foundItems = {}, {}

			-- Accounts
			if result[1].accounts and result[1].accounts ~= '' then
				local accounts = json.decode(result[1].accounts)

				for account,money in pairs(accounts) do
					foundAccounts[account] = money
				end
			end

			for account,label in pairs(Config.Accounts) do
				table.insert(userData.accounts, {
					name = account,
					money = foundAccounts[account] or Config.StartingAccountMoney[account] or 0,
					label = label
				})
			end

			-- Job
			if SKYLINE.DoesJobExist(job, grade) then
				jobObject, gradeObject = SKYLINE.Jobs[job], SKYLINE.Jobs[job].grades[grade]
			else
				print(('[SKYLINE_core] [^3WARNING^7] Ignoring invalid job for %s [job: %s, grade: %s]'):format(identifier, job, grade))
				job, grade = 'unemployed', '0'
				jobObject, gradeObject = SKYLINE.Jobs[job], SKYLINE.Jobs[job].grades[grade]
			end

			userData.job.id = jobObject.id
			userData.job.name = jobObject.name
			userData.job.label = jobObject.label

			userData.job.grade = tonumber(grade)
			userData.job.grade_name = gradeObject.name
			userData.job.grade_label = gradeObject.label
			userData.job.grade_salary = gradeObject.salary

			userData.job.skin_male = {}
			userData.job.skin_female = {}

			if gradeObject.skin_male then userData.job.skin_male = json.decode(gradeObject.skin_male) end
			if gradeObject.skin_female then userData.job.skin_female = json.decode(gradeObject.skin_female) end

			-- Inventory
			if result[1].inventory and result[1].inventory ~= '' then
				local inventory = json.decode(result[1].inventory)

				for name,count in pairs(inventory) do
					local item = SKYLINE.Items[name]

					if item then
						foundItems[name] = count
					else
						print(('[SKYLINE_core] [^3WARNING^7] Ignoring invalid item "%s" for "%s"'):format(name, identifier))
					end
				end
			end

			for name,item in pairs(SKYLINE.Items) do
				local count = foundItems[name] or 0
				if count > 0 then userData.weight = userData.weight + (item.weight * count) end

				table.insert(userData.inventory, {
					name = name,
					count = count,
					label = item.label,
					weight = item.weight,
					usable = SKYLINE.UsableItemsCallbacks[name] ~= nil,
					rare = item.rare,
					canRemove = item.canRemove
				})
			end

			table.sort(userData.inventory, function(a, b)
				return a.label < b.label
			end)

			-- Group
			if result[1].group then
				userData.group = result[1].group
			else
				userData.group = 'user'
			end

			-- Loadout
			if result[1].loadout and result[1].loadout ~= '' then
				local loadout = json.decode(result[1].loadout)

				for name,weapon in pairs(loadout) do
					local label = SKYLINE.GetWeaponLabel(name)

					if label then
						if not weapon.components then weapon.components = {} end
						if not weapon.tintIndex then weapon.tintIndex = 0 end

						table.insert(userData.loadout, {
							name = name,
							ammo = weapon.ammo,
							label = label,
							components = weapon.components,
							tintIndex = weapon.tintIndex
						})
					end
				end
			end

			-- Position
			if result[1].position and result[1].position ~= '' then
				userData.coords = json.decode(result[1].position)
			else
				print('[SKYLINE_core] [^3WARNING^7] Column "position" in "users" table is missing required default value. Using backup coords, fix your database.')
				userData.coords = {x = -269.4, y = -955.3, z = 31.2, heading = 205.8}
			end

			cb()
		end)
	end)

	Async.parallel(tasks, function(results)
		local xPlayer = CreateExtendedPlayer(playerId, identifier, userData.group, userData.accounts, userData.inventory, userData.weight, userData.job, userData.loadout, userData.playerName, userData.coords)
		SKYLINE.Players[playerId] = xPlayer
		TriggerEvent('skyline:playerLoaded', playerId, xPlayer)

		xPlayer.triggerEvent('skyline:playerLoaded', {
			accounts = xPlayer.getAccounts(),
			coords = xPlayer.getCoords(),
			identifier = xPlayer.getIdentifier(),
			inventory = xPlayer.getInventory(),
			job = xPlayer.getJob(),
			loadout = xPlayer.getLoadout(),
			maxWeight = xPlayer.getMaxWeight(),
			money = xPlayer.getMoney()
		})

		xPlayer.triggerEvent('skyline:createMissingPickups', SKYLINE.Pickups)
		xPlayer.triggerEvent('skyline:registerSuggestions', SKYLINE.RegisteredCommands)
		print(('[SKYLINE_core] [^2INFO^7]Spieler "%s^7" hat sich zum Sever verbunden mit der ID --> %s'):format(xPlayer.getName(), playerId))
	end)
end

AddEventHandler('chatMessage', function(playerId, author, message)
	if message:sub(1, 1) == '/' and playerId > 0 then
		CancelEvent()
		local commandName = message:sub(1):gmatch("%w+")()
		TriggerClientEvent('chat:addMessage', playerId, {args = {'^1SYSTEM', "Diesen Befehl gibt es nicht!"}})
	end
end)

AddEventHandler('playerDropped', function(reason)
	local playerId = source
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)

	if xPlayer then
		TriggerEvent('skyline:playerDropped', playerId, reason)

		SKYLINE.SavePlayer(xPlayer, function()
			SKYLINE.Players[playerId] = nil
		end)
	end
end)

RegisterNetEvent('skyline:updateCoords')
AddEventHandler('skyline:updateCoords', function(coords)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.updateCoords(coords)
	end
end)

RegisterNetEvent('skyline:updateWeaponAmmo')
AddEventHandler('skyline:updateWeaponAmmo', function(weaponName, ammoCount)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.updateWeaponAmmo(weaponName, ammoCount)
	end
end)

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

RegisterNetEvent('skyline:giveInventoryItem')
AddEventHandler('skyline:giveInventoryItem', function(target, type, itemName, itemCount)
	local playerId = source
	local sourceXPlayer = SKYLINE.GetPlayerFromId(source)
	local targetXPlayer = SKYLINE.GetPlayerFromId(target)

	if type == 'item_standard' then
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then
			if targetXPlayer.canCarryItem(itemName, itemCount) then
				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem   (itemName, itemCount)

				local msg = {
					{
						["color"] = "2123412",
						["title"] = "Item übergabe",
						["description"] = "**Welches Item wurde übergeben:** " .. sourceXPlayer.getInventoryItem(itemName).label .. "\n **Menge:** " .. itemCount .. " \n **Wer hat das Item bekommen: ** \n Lizenz: " .. targetXPlayer.getIdentifier() .. " \n Steam: " .. GetPlayerIdentifier(targetXPlayer.source) .. "\n Discord: " .. "<@" .. getDCId(targetXPlayer.source) .. ">" .. " \n **ID:** " .. targetXPlayer.source .. " \n **Von wen er das Item bekommen hat:**   \n Lizenz: " .. sourceXPlayer.getIdentifier() .. " \n Steam: " .. GetPlayerIdentifier(sourceXPlayer.source) .. "\n Discord: " .. "<@" .. getDCId(sourceXPlayer.source) .. ">" .. " \n **ID:** " .. sourceXPlayer.source .. "",
						["footer"] = {
							["text"] = "Copyright © Jucktnicht 2022",
							["icon_url"] = "",
						},
					}
				}
			
				PerformHttpRequest("https://discord.com/api/webhooks/975645140452528138/RiwoIHhGUpARaerXwPUZtp0yLIj3k35X2TQxNWI8rqrwLl_-trzSFcofQjeDMihb8f_-", function(err, text, headers) end, 'POST', json.encode({username = "Late-V | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })
			--	sourceXPlayer.showNotification(_U('gave_item', itemCount, sourceItem.label, targetXPlayer.name))
			--	targetXPlayer.showNotification(_U('received_item', itemCount, sourceItem.label, sourceXPlayer.name))
			else
				--sourceXPlayer.showNotification(_U('ex_inv_lim', targetXPlayer.name))
			end
		else
			--sourceXPlayer.showNotification(_U('imp_invalid_quantity'))
		end
	elseif type == 'item_account' then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney   (itemName, itemCount)

		--	sourceXPlayer.showNotification(_U('gave_account_money', SKYLINE.Math.GroupDigits(itemCount), Config.Accounts[itemName], targetXPlayer.name))
		--	targetXPlayer.showNotification(_U('received_account_money', SKYLINE.Math.GroupDigits(itemCount), Config.Accounts[itemName], sourceXPlayer.name))
		else
		--	sourceXPlayer.showNotification(_U('imp_invalid_amount'))
		end
	elseif type == 'item_weapon' then
		if sourceXPlayer.hasWeapon(itemName) then
					local weaponLabel = SKYLINE.GetWeaponLabel(itemName)

					if not targetXPlayer.hasWeapon(itemName) then
						local _, weapon = sourceXPlayer.getWeapon(itemName)
						local _, weaponObject = SKYLINE.GetWeapon(itemName)
						itemCount = weapon.ammo
		
						sourceXPlayer.removeWeapon(itemName)
						targetXPlayer.addWeapon(itemName, itemCount)
		
						local msg = {
							{
								["color"] = "2123412",
								["title"] = "Waffen übergabe",
								["description"] = "**Welche Waffe wurde übergeben:** " .. itemName .. " \n **Wer hat die Waffe bekommen: ** \n Lizenz: " .. targetXPlayer.getIdentifier() .. " \n Steam: " .. GetPlayerIdentifier(targetXPlayer.source) .. "\n Discord: " .. "<@" .. getDCId(targetXPlayer.source) .. ">" .. " \n **ID:** " .. targetXPlayer.source .. " \n **Von wen er die Waffe bekommen hat:**   \n Lizenz: " .. sourceXPlayer.getIdentifier() .. " \n Steam: " .. GetPlayerIdentifier(sourceXPlayer.source) .. "\n Discord: " .. "<@" .. getDCId(sourceXPlayer.source) .. ">" .. " \n **ID:** " .. sourceXPlayer.source .. "",
								["footer"] = {
									["text"] = "Copyright © Jucktnicht 2022",
									["icon_url"] = "",
								},
							}
						}
					
						PerformHttpRequest("https://discord.com/api/webhooks/975645459379003442/Qv8oCh_4iJ9D1X79rakZNZpaUH17ZWusr1XwV95ElXCtyLjwoEupTGKc_IHgzaKhwWvf", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })
		
						if weaponObject.ammo and itemCount > 0 then
							local ammoLabel = weaponObject.ammo.label
							--sourceXPlayer.showNotification(_U('gave_weapon_withammo', weaponLabel, itemCount, ammoLabel, targetXPlayer.name))
							--targetXPlayer.showNotification(_U('received_weapon_withammo', weaponLabel, itemCount, ammoLabel, sourceXPlayer.name))
						else
							--sourceXPlayer.showNotification(_U('gave_weapon', weaponLabel, targetXPlayer.name))
							--targetXPlayer.showNotification(_U('received_weapon', weaponLabel, sourceXPlayer.name))
						end
					else
						--sourceXPlayer.showNotification(_U('gave_weapon_hasalready', targetXPlayer.name, weaponLabel))
					---	targetXPlayer.showNotification(_U('received_weapon_hasalready', sourceXPlayer.name, weaponLabel))
					end
				 
		
		end 
	elseif type == 'item_ammo' then
		if sourceXPlayer.hasWeapon(itemName) then
			local weaponNum, weapon = sourceXPlayer.getWeapon(itemName)

			if targetXPlayer.hasWeapon(itemName) then
				local _, weaponObject = SKYLINE.GetWeapon(itemName)

				if weaponObject.ammo then
					local ammoLabel = weaponObject.ammo.label

					if weapon.ammo >= itemCount then
						sourceXPlayer.removeWeaponAmmo(itemName, itemCount)
						targetXPlayer.addWeaponAmmo(itemName, itemCount)

					--	sourceXPlayer.showNotification(_U('gave_weapon_ammo', itemCount, ammoLabel, weapon.label, targetXPlayer.name))
					--	targetXPlayer.showNotification(_U('received_weapon_ammo', itemCount, ammoLabel, weapon.label, sourceXPlayer.name))
					end
				end
			else
			--	sourceXPlayer.showNotification(_U('gave_weapon_noweapon', targetXPlayer.name))
			--	targetXPlayer.showNotification(_U('received_weapon_noweapon', sourceXPlayer.name, weapon.label))
			end
		end
	end
end)

RegisterNetEvent('skyline:removeInventoryItem')
AddEventHandler('skyline:removeInventoryItem', function(type, itemName, itemCount)
	local playerId = source
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if type == 'item_standard' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.triggerEvent("SKYLINE_notify", 1 , "Tasche" , "Ungültige Menge")
		else
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				xPlayer.triggerEvent("SKYLINE_notify", 1 , "Tasche" , "Ungültige Menge")
			else
			  xPlayer.removeInventoryItem(itemName, itemCount)
			  xPlayer.triggerEvent("SKYLINE_notify", 1 , "Tasche" , "Du hast " .. itemCount .. "x mal " .. xItem.label .. " weggeworfen.")

			  
			  local msg = {
				{
					["color"] = "2123412",
					["title"] = "Item weggeworfen",
					["description"] = "**Welches Item:** " .. xItem.label .. " \n **Menge: **" .. itemCount .. "\n **Lizenz:** " .. xPlayer.getIdentifier() .. " \n **Steam:** " .. GetPlayerIdentifier(xPlayer.source) .. "\n **Discord:** " .. "<@" .. getDCId(xPlayer.source) .. ">" .. " \n **ID:** " .. xPlayer.source .. "\n **IC Name:** " .. xPlayer.getName(),
					["footer"] = {
						["text"] = "Copyright © 2022 Juckthaltnicht",
						["icon_url"] = "",
					},
				}
			}
		
			PerformHttpRequest("https://discord.com/api/webhooks/975645140452528138/RiwoIHhGUpARaerXwPUZtp0yLIj3k35X2TQxNWI8rqrwLl_-trzSFcofQjeDMihb8f_-", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })
			
			end
		end
	elseif type == 'item_account' then
		if itemCount == nil or itemCount < 1 then
			--xPlayer.showNotification(_U('imp_invalid_amount'))
		else
			local account = xPlayer.getAccount(itemName)

			if (itemCount > account.money or account.money < 1) then
				xPlayer.showNotification(_U('imp_invalid_amount'))
			else
				xPlayer.removeAccountMoney(itemName, itemCount)
			
				
				local pickupLabel = "Jucktnicht"
				--SKYLINE.CreatePickup('item_account', itemName, itemCount, pickupLabel, playerId)
			--	xPlayer.showNotification(_U('threw_account', SKYLINE.Math.GroupDigits(itemCount), string.lower(account.label)))
			end
		end
	elseif type == 'item_weapon' then
		itemName = string.upper(itemName)

		if xPlayer.hasWeapon(itemName) then
			local _, weapon = xPlayer.getWeapon(itemName)
			local _, weaponObject = SKYLINE.GetWeapon(itemName)
			local components, pickupLabel = SKYLINE.Table.Clone(weapon.components)
			xPlayer.removeWeapon(itemName)

			local msg = {
				{
					["color"] = "2123412",
					["title"] = "Waffe weggeworfen.",
					["description"] = "**Welche Waffe:** " .. itemName .. " \n **Menge: **" .. 1 .. "\n **Lizenz:** " .. xPlayer.getIdentifier() .. " \n **Steam:** " .. GetPlayerIdentifier(xPlayer.source) .. "\n **Discord:** " .. "<@" .. getDCId(xPlayer.source) .. ">" .. " \n **ID:** " .. xPlayer.source .. "\n **IC Name:** " .. xPlayer.getName(),
					["footer"] = {
						["text"] = "Copyright © 2022 Juckthaltnicht",
						["icon_url"] = "",
					},
				}
			}
		
			PerformHttpRequest("https://discord.com/api/webhooks/975645459379003442/Qv8oCh_4iJ9D1X79rakZNZpaUH17ZWusr1XwV95ElXCtyLjwoEupTGKc_IHgzaKhwWvf", function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })

			if weaponObject.ammo and weapon.ammo > 0 then
				local ammoLabel = weaponObject.ammo.label
				pickupLabel = ('~y~%s~s~ [~g~%s~s~ %s]'):format(weapon.label, weapon.ammo, ammoLabel)
				--xPlayer.showNotification(_U('threw_weapon_ammo', weapon.label, weapon.ammo, ammoLabel))
			else
				pickupLabel = ('~y~%s~s~'):format(weapon.label)
			--	xPlayer.showNotification(_U('threw_weapon', weapon.label))
			end

			SKYLINE.CreatePickup('item_weapon', itemName, weapon.ammo, pickupLabel, playerId, components, weapon.tintIndex)
		end
	end
end)

RegisterNetEvent('skyline:useItem')
AddEventHandler('skyline:useItem', function(itemName)
	local xPlayer = SKYLINE.GetPlayerFromId(source)
	local count = xPlayer.getInventoryItem(itemName).count

	if count > 0 then
		SKYLINE.UseItem(source, itemName)
	else
		--xPlayer.showNotification(_U('act_imp'))
	end
end)

RegisterNetEvent('skyline:onPickup')
AddEventHandler('skyline:onPickup', function(pickupId)
	local pickup, xPlayer, success = SKYLINE.Pickups[pickupId], SKYLINE.GetPlayerFromId(source)

	if pickup then
		if pickup.type == 'item_standard' then
			if xPlayer.canCarryItem(pickup.name, pickup.count) then
				xPlayer.addInventoryItem(pickup.name, pickup.count)
				success = true
			else
				--xPlayer.showNotification(_U('threw_cannot_pickup'))
			end
		elseif pickup.type == 'item_account' then
			success = true
			xPlayer.addAccountMoney(pickup.name, pickup.count)
		elseif pickup.type == 'item_weapon' then
			if xPlayer.hasWeapon(pickup.name) then
				--xPlayer.showNotification(_U('threw_weapon_already'))
			else
				success = true
				xPlayer.addWeapon(pickup.name, pickup.count)
				xPlayer.setWeaponTint(pickup.name, pickup.tintIndex)

				for k,v in ipairs(pickup.components) do
					xPlayer.addWeaponComponent(pickup.name, v)
				end
			end
		end

		if success then
			SKYLINE.Pickups[pickupId] = nil
			TriggerClientEvent('skyline:removePickup', -1, pickupId)
		end
	end
end)

SKYLINE.RegisterServerCallback('skyline:getPlayerData', function(source, cb)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		loadout      = xPlayer.getLoadout(),
		money        = xPlayer.getMoney()
	})
end)

SKYLINE.RegisterServerCallback('skyline:getOtherPlayerData', function(source, cb, target)
	local xPlayer = SKYLINE.GetPlayerFromId(target)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		loadout      = xPlayer.getLoadout(),
		money        = xPlayer.getMoney()
	})
end)

SKYLINE.RegisterServerCallback('skyline:getPlayerNames', function(source, cb, players)
	players[source] = nil

	for playerId,v in pairs(players) do
		local xPlayer = SKYLINE.GetPlayerFromId(playerId)

		if xPlayer then
			players[playerId] = xPlayer.getName()
		else
			players[playerId] = nil
		end
	end

	cb(players)
end)

SKYLINE.StartDBSync()
SKYLINE.StartPayCheck()
