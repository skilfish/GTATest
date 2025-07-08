SKYLINE = nil

local cuffs = {}

TriggerEvent("skylineistback:getSharedObject", function(obj) SKYLINE = obj end)
TriggerEvent('jobsundso:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})

SKYLINE.RegisterServerCallback("skyline_policejob:getJobData", function(playerId , cb)
    local xPlayer = SKYLINE.GetPlayerFromId(playerId)

    cb(xPlayer.getJob().name , xPlayer.getJob().grade , xPlayer.getJob().grade_name)
end)

RegisterNetEvent("skyline_policejob:cuff")
AddEventHandler("skyline_policejob:cuff", function(target , type)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer.job.name == "police" then
		TriggerClientEvent("skyline_policejob:cuff", target , type)
        cuffs[target] = true
	end
end)

RegisterNetEvent("skyline_policejob:uncuff")
AddEventHandler("skyline_policejob:uncuff", function(target)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer.job.name == "police" then
		TriggerClientEvent("skyline_policejob:uncuff", target)
        cuffs[target] = false
	end
end)

SKYLINE.RegisterServerCallback('skyline_policejob:getOtherPlayerData', function(source, cb, target, notify)
	local xPlayer = SKYLINE.GetPlayerFromId(target)

	if xPlayer then
		local data = {
			name = xPlayer.getName(),
			job = xPlayer.job.label,
			grade = xPlayer.job.grade_label,
			inventory = xPlayer.getInventory(),
			accounts = xPlayer.getAccounts(),
			weapons = xPlayer.getLoadout()
		}

			data.dob = xPlayer.get('dateofbirth')
			data.height = xPlayer.get('height')
			if xPlayer.get('sex') == 'm' then data.sex = 'male' else data.sex = 'female' end
		

		

		TriggerEvent('bruderlizenzenundso:getLicenses', target, function(licenses)
			data.licenses = licenses
			cb(data)
		end)
		
	end
end)

RegisterNetEvent('skyline_policejob:drag')
AddEventHandler('skyline_policejob:drag', function(target)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('skyline_policejob:drag', target, source)
	else
	
	end
end)

RegisterNetEvent('skyline_policejob:putInVehicle')
AddEventHandler('skyline_policejob:putInVehicle', function(target)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('skyline_policejob:putInVehicle', target)
	else

	end
end)

RegisterNetEvent('skyline_policejob:OutVehicle')
AddEventHandler('skyline_policejob:OutVehicle', function(target)
	local xPlayer = SKYLINE.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		TriggerClientEvent('skyline_policejob:OutVehicle', target)
	else
	
	end
end)

RegisterNetEvent('skyline_policejob:confiscatePlayerItem')
AddEventHandler('skyline_policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = SKYLINE.GetPlayerFromId(_source)
	local targetXPlayer = SKYLINE.GetPlayerFromId(target)

	if sourceXPlayer.job.name == 'police' then
	    if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		if targetItem.count > 0 and targetItem.count <= amount then
			if sourceXPlayer.canCarryItem(itemName, sourceItem.count) then
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem (itemName, amount)
				--sourceXPlayer.showNotification(_U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				--targetXPlayer.showNotification(_U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
		else
			--sourceXPlayer.showNotification(_U('quantity_invalid'))
		end
	else
		--sourceXPlayer.showNotification(_U('quantity_invalid'))
	end
	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney(itemName, amount)
		--sourceXPlayer.showNotification(_U('you_confiscated_account', amount, itemName, targetXPlayer.name))
		--targetXPlayer.showNotification(_U('got_confiscated_account', amount, itemName, sourceXPlayer.name))
	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon(itemName, amount)
		--sourceXPlayer.showNotification(_U('you_confiscated_weapon', SKYLINE.GetWeaponLabel(itemName), targetXPlayer.name, amount))
		--targetXPlayer.showNotification(_U('got_confiscated_weapon', SKYLINE.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
       else
           
       end
	end
end)

SKYLINE.RegisterServerCallback("skyline_policejob:isCuffed", function(playerId , cb , id)
    if cuffs[id] ~= nil then 
        cb(cuffs[id])
    else 
        cb(false)
    end 
end)

RegisterNetEvent("skyline_policejob:message")
AddEventHandler("skyline_policejob:message", function(target , license)
	TriggerClientEvent("skyline_notify:Alert", target, "LSPD" , "Dir wurde die Lizenz: " .. license .. " entzogen " , 2500 , "error")
end)


RegisterNetEvent("skyline_policejob:message1")
AddEventHandler("skyline_policejob:message1", function(target)
	TriggerClientEvent("skyline_notify:Alert", target, "LSPD" , "Dir wurde die Lizenz: " .. "Waffenschein" .. " gegeben " , 2500 , "success")
end)

SKYLINE.RegisterServerCallback('skyline_policejob:getVehicleInfos', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		local retrivedInfo = {plate = plate}

		if result[1] then
			local xPlayer = SKYLINE.GetPlayerFromIdentifier(result[1].owner)

			-- is the owner online?
			if xPlayer then
				retrivedInfo.owner = xPlayer.getName()
				cb(retrivedInfo)
			else 
				MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
					['@identifier'] = result[1].owner
				}, function(result2)
					if result2[1] then
						retrivedInfo.owner = ('%s %s'):format(result2[1].firstname, result2[1].lastname)
						cb(retrivedInfo)
					else
						cb(retrivedInfo)
					end
				end)
			end
		else
			cb(retrivedInfo)
		end
	end)
end)



SKYLINE.RegisterServerCallback('skyline_policejob:getArmoryWeapons', function(source, cb)
	TriggerEvent('datastoreistvollkuhl:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

SKYLINE.RegisterServerCallback('skyline_policejob:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = SKYLINE.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('datastoreistvollkuhl:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons') or {}

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

SKYLINE.RegisterServerCallback('skyline_policejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('datastoreistvollkuhl:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons') or {}
		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

SKYLINE.RegisterServerCallback('skyline_policejob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = SKYLINE.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('SKYLINE_policejob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	else
		-- Weapon
		if type == 1 then
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price)
				xPlayer.addWeapon(weaponName, 100)

				cb(true)
			else
				cb(false)
			end

		-- Weapon Component
		elseif type == 2 then
			local price = selectedWeapon.components[componentNum]
			local weaponNum, weapon = SKYLINE.GetWeapon(weaponName)
			local component = weapon.components[componentNum]

			if component then
				if xPlayer.getMoney() >= price then
					xPlayer.removeMoney(price)
					xPlayer.addWeaponComponent(weaponName, component.name)

					cb(true)
				else
					cb(false)
				end
			else
				print(('SKYLINE_policejob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
				cb(false)
			end
		end
	end
end)

RegisterNetEvent('skyline_policejob:getStockItem')
AddEventHandler('skyline_policejob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = SKYLINE.GetPlayerFromId(_source)
	TriggerEvent('addoninvundso:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)
		if count > 0 and inventoryItem.count >= count then
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				--xPlayer.showNotification(_U('have_withdrawn', count, inventoryItem.label))
			else
				xPlayer.showNotification("~r~Menge Ungültig!")
			end
		else
			xPlayer.showNotification("~r~Menge Ungültig!")
		end
	end)
end)

SKYLINE.RegisterServerCallback('skyline_policejob:getStockItems', function(source, cb)
	TriggerEvent('addoninvundso:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

SKYLINE.RegisterServerCallback('skyline_policejob:getPlayerInventory', function(source, cb)
	local xPlayer = SKYLINE.GetPlayerFromId(source)
	local items = xPlayer.inventory
	cb({items = items})
end)

RegisterNetEvent('skyline_policejob:putStockItems')
AddEventHandler('skyline_policejob:putStockItems', function(itemName, count)
	local xPlayer = SKYLINE.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('addoninvundso:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			--xPlayer.showNotification(_U('have_deposited', count, inventoryItem.label))
		else
			xPlayer.showNotification("~r~Menge Ungültig!")
		end
	end)
end)

RegisterNetEvent('skyline_policejob:giveItem')
AddEventHandler('skyline_policejob:giveItem', function(itemName, amount)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'police' then
		print(('[SKYLINE_policejob] [^2INFO^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	if xPlayer.canCarryItem(itemName, amount) then
		xPlayer.addInventoryItem(itemName, amount)
	else
		TriggerClientEvent('skyline_notify:Alert', source , "LSPD" , "So viel kannst du nicht tragen!" , 2000 , "error")
	end
end)