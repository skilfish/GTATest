SKYLINE = nil

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

function GetProperty(name)
	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name == name then
			return Config.Properties[i]
		end
	end
end

function SetPropertyOwned(name, price, rented, owner)
	MySQL.Async.execute('INSERT INTO owned_properties (name, price, rented, owner) VALUES (@name, @price, @rented, @owner)', {
		['@name']   = name,
		['@price']  = price,
		['@rented'] = (rented and 1 or 0),
		['@owner']  = owner
	}, function(rowsChanged)
		local xPlayer = SKYLINE.GetPlayerFromIdentifier(owner)

		if xPlayer then
			TriggerClientEvent('propertyundsoduhs:setPropertyOwned', xPlayer.source, name, true)

			if rented then
				TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "Immobilie gemietet für: " .. SKYLINE.Math.GroupDigits(price) .. "$" , 3000 , "success")
			else
				TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "Immobilie gekauft für: " .. SKYLINE.Math.GroupDigits(price) .. "$" , 3000 , "success")
			end
		end
	end)
end

function RemoveOwnedProperty(name, owner)
	MySQL.Async.execute('DELETE FROM owned_properties WHERE name = @name AND owner = @owner', {
		['@name']  = name,
		['@owner'] = owner
	}, function(rowsChanged)
		local xPlayer = SKYLINE.GetPlayerFromIdentifier(owner)

		if xPlayer then
			TriggerClientEvent('propertyundsoduhs:setPropertyOwned', xPlayer.source, name, false)
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "Deine Immobilie: " .. name .. " gehört nun nicht mehr dir!" , 3000 , "error")
		end
	end)
end

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM properties', {}, function(properties)

		for i=1, #properties, 1 do
			local entering  = nil
			local exit      = nil
			local inside    = nil
			local outside   = nil
			local isSingle  = nil
			local isRoom    = nil
			local isGateway = nil
			local roomMenu  = nil

			if properties[i].entering ~= nil then
				entering = json.decode(properties[i].entering)
			end

			if properties[i].exit ~= nil then
				exit = json.decode(properties[i].exit)
			end

			if properties[i].inside ~= nil then
				inside = json.decode(properties[i].inside)
			end

			if properties[i].outside ~= nil then
				outside = json.decode(properties[i].outside)
			end

			if properties[i].is_single == 0 then
				isSingle = false
			else
				isSingle = true
			end

			if properties[i].is_room == 0 then
				isRoom = false
			else
				isRoom = true
			end

			if properties[i].is_gateway == 0 then
				isGateway = false
			else
				isGateway = true
			end

			if properties[i].room_menu ~= nil then
				roomMenu = json.decode(properties[i].room_menu)
			end

			table.insert(Config.Properties, {
				name      = properties[i].name,
				label     = properties[i].label,
				entering  = entering,
				exit      = exit,
				inside    = inside,
				outside   = outside,
				ipls      = json.decode(properties[i].ipls),
				gateway   = properties[i].gateway,
				isSingle  = isSingle,
				isRoom    = isRoom,
				isGateway = isGateway,
				roomMenu  = roomMenu,
				price     = properties[i].price
			})
		end

		TriggerClientEvent('propertyundsoduhs:sendProperties', -1, Config.Properties)
	end)
end)

SKYLINE.RegisterServerCallback('propertyundsoduhs:getProperties', function(source, cb)
	cb(Config.Properties)
end)

AddEventHandler('SKYLINE_ownedproperty:getOwnedProperties', function(cb)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties', {}, function(result)
		local properties = {}

		for i=1, #result, 1 do
			table.insert(properties, {
				id     = result[i].id,
				name   = result[i].name,
				label  = GetProperty(result[i].name).label,
				price  = result[i].price,
				rented = (result[i].rented == 1 and true or false),
				owner  = result[i].owner
			})
		end

		cb(properties)
	end)
end)

AddEventHandler('propertyundsoduhs:setPropertyOwned', function(name, price, rented, owner)
	SetPropertyOwned(name, price, rented, owner)
end)

AddEventHandler('propertyundsoduhs:removeOwnedProperty', function(name, owner)
	RemoveOwnedProperty(name, owner)
end)

RegisterServerEvent('propertyundsoduhs:rentProperty')
AddEventHandler('propertyundsoduhs:rentProperty', function(propertyName)
	local xPlayer  = SKYLINE.GetPlayerFromId(source)
	local property = GetProperty(propertyName)
	local rent     = SKYLINE.Math.Round(property.price / 200)

	SetPropertyOwned(propertyName, rent, true, xPlayer.identifier)
end)

RegisterServerEvent('propertyundsoduhs:buyProperty')
AddEventHandler('propertyundsoduhs:buyProperty', function(propertyName)
	local xPlayer  = SKYLINE.GetPlayerFromId(source)
	local property = GetProperty(propertyName)

	if property.price <= xPlayer.getMoney() then
		xPlayer.removeMoney(property.price)
		SetPropertyOwned(propertyName, property.price, false, xPlayer.identifier)
	else
		TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "Du hast nicht genug Geld!" , 3000 , "error")
	end
end)

RegisterServerEvent('propertyundsoduhs:removeOwnedProperty')
AddEventHandler('propertyundsoduhs:removeOwnedProperty', function(propertyName)
	local xPlayer = SKYLINE.GetPlayerFromId(source)
	RemoveOwnedProperty(propertyName, xPlayer.identifier)
end)

AddEventHandler('propertyundsoduhs:removeOwnedPropertyIdentifier', function(propertyName, identifier)
	RemoveOwnedProperty(propertyName, identifier)
end)

RegisterServerEvent('propertyundsoduhs:saveLastProperty')
AddEventHandler('propertyundsoduhs:saveLastProperty', function(property)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = @last_property WHERE identifier = @identifier', {
		['@last_property'] = property,
		['@identifier']    = xPlayer.identifier
	})
end)

RegisterServerEvent('propertyundsoduhs:deleteLastProperty')
AddEventHandler('propertyundsoduhs:deleteLastProperty', function()
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = NULL WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('propertyundsoduhs:getItem')
AddEventHandler('propertyundsoduhs:getItem', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = SKYLINE.GetPlayerFromId(_source)
	local xPlayerOwner = SKYLINE.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local sourceItem = xPlayer.getInventoryItem(item)

		TriggerEvent('addoninvundso:getInventory', 'property', xPlayerOwner.identifier, function(inventory)
			local inventoryItem = inventory.getItem(item)

			-- is there enough in the property?
			if count > 0 and inventoryItem.count >= count then
			
				-- can the player carry the said amount of x item?
				if not xPlayer.canCarryItem(item, sourceItem.count) then
					TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "Du hast nicht genug Platz in deiner Tasche!" , 3000 , "error")
				else
					inventory.removeItem(item, count)
					xPlayer.addInventoryItem(item, count)
				end
			else
				TriggerClientEvent("skyline_notify:Alert", xPlayer.source, 	inventoryItem.label .. " hast du nicht so viel, in deinem Lager!" , 3000 , "error")
			end
		end)

	elseif type == 'item_account' then

		TriggerEvent('accountoderso:getAccount', 'property_' .. item, xPlayerOwner.identifier, function(account)
			local roomAccountMoney = account.money

			if roomAccountMoney >= count then
				account.removeMoney(count)
				xPlayer.addAccountMoney(item, count)
			else
				TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "Ungültige Menge!" , 3000 , "error")
			end
		end)

	elseif type == 'item_weapon' then

		TriggerEvent('datastoreistvollkuhl:getDataStore', 'property', xPlayerOwner.identifier, function(store)
			local storeWeapons = store.get('weapons') or {}
			local weaponName   = nil
			local ammo         = nil

			for i=1, #storeWeapons, 1 do
				if storeWeapons[i].name == item then
					weaponName = storeWeapons[i].name
					ammo       = storeWeapons[i].ammo

					table.remove(storeWeapons, i)
					break
				end
			end

			store.set('weapons', storeWeapons)
			xPlayer.addWeapon(weaponName, ammo)
		end)

	end
end)

RegisterServerEvent('propertyundsoduhs:putItem')
AddEventHandler('propertyundsoduhs:putItem', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = SKYLINE.GetPlayerFromId(_source)
	local xPlayerOwner = SKYLINE.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('addoninvundso:getInventory', 'property', xPlayerOwner.identifier, function(inventory)
				xPlayer.removeInventoryItem(item, count)
				inventory.addItem(item, count)
			end)
		else
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "Ungültige Menge!" , 3000 , "error")
		end

	elseif type == 'item_account' then

		local playerAccountMoney = xPlayer.getAccount(item).money

		if playerAccountMoney >= count and count > 0 then
			xPlayer.removeAccountMoney(item, count)

			TriggerEvent('accountoderso:getAccount', 'property_' .. item, xPlayerOwner.identifier, function(account)
				account.addMoney(count)
			end)
		else
			TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "Ungültige Menge!" , 3000 , "error")
		end

	elseif type == 'item_weapon' then

		TriggerEvent('datastoreistvollkuhl:getDataStore', 'property', xPlayerOwner.identifier, function(store)
			local storeWeapons = store.get('weapons') or {}

			table.insert(storeWeapons, {
				name = item,
				ammo = count
			})

			store.set('weapons', storeWeapons)
			xPlayer.removeWeapon(item)
		end)

	end
end)

SKYLINE.RegisterServerCallback('propertyundsoduhs:getOwnedProperties', function(source, cb)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function(ownedProperties)
		local properties = {}

		for i=1, #ownedProperties, 1 do
			table.insert(properties, ownedProperties[i].name)
		end

		cb(properties)
	end)
end)

SKYLINE.RegisterServerCallback('propertyundsoduhs:getLastProperty', function(source, cb)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT last_property FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		cb(users[1].last_property)
	end)
end)

SKYLINE.RegisterServerCallback('propertyundsoduhs:getPropertyInventory', function(source, cb, owner)
	local xPlayer    = SKYLINE.GetPlayerFromIdentifier(owner)
	local blackMoney = 0
	local items      = {}
	local weapons    = {}

	TriggerEvent('accountoderso:getAccount', 'property_black_money', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)

	TriggerEvent('addoninvundso:getInventory', 'property', xPlayer.identifier, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('datastoreistvollkuhl:getDataStore', 'property', xPlayer.identifier, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = weapons
	})
end)

SKYLINE.RegisterServerCallback('propertyundsoduhs:getPlayerInventory', function(source, cb)
	local xPlayer    = SKYLINE.GetPlayerFromId(source)
	local blackMoney = xPlayer.getAccount('black_money').money
	local items      = xPlayer.inventory

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = xPlayer.getLoadout()
	})
end)

SKYLINE.RegisterServerCallback('propertyundsoduhs:getPlayerDressing', function(source, cb)
	local xPlayer  = SKYLINE.GetPlayerFromId(source)

	TriggerEvent('datastoreistvollkuhl:getDataStore', 'property', xPlayer.identifier, function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)

SKYLINE.RegisterServerCallback('propertyundsoduhs:getPlayerOutfit', function(source, cb, num)
	local xPlayer  = SKYLINE.GetPlayerFromId(source)

	TriggerEvent('datastoreistvollkuhl:getDataStore', 'property', xPlayer.identifier, function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)

RegisterServerEvent('propertyundsoduhs:removeOutfit')
AddEventHandler('propertyundsoduhs:removeOutfit', function(label)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	TriggerEvent('datastoreistvollkuhl:getDataStore', 'property', xPlayer.identifier, function(store)
		local dressing = store.get('dressing') or {}

		table.remove(dressing, label)
		store.set('dressing', dressing)
	end)
end)

function PayRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE rented = 1', {}, function (result)
		for i=1, #result, 1 do
			local xPlayer = SKYLINE.GetPlayerFromIdentifier(result[i].owner)

			-- message player if connected
			if xPlayer then
				xPlayer.removeAccountMoney('bank', result[i].price)
				TriggerClientEvent("skyline_notify:Alert", xPlayer.source, "Miete für Immobilie gezahlt: " .. SKYLINE.Math.GroupDigits(result[i].price) .. "$", 3000 , "error")
			else -- pay rent either way
				MySQL.Sync.execute('UPDATE users SET bank = bank - @bank WHERE identifier = @identifier', {
					['@bank']       = result[i].price,
					['@identifier'] = result[i].owner
				})
			end

			TriggerEvent('accountoderso:getSharedAccount', 'society_realestateagent', function(account)
				account.addMoney(result[i].price)
			end)
		end
	end)
end

TriggerEvent('cron:runAt', 24, 0, PayRent)
