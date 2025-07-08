SKYLINE = nil

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)


-- Schöhnheitsklinik
SKYLINE.RegisterServerCallback('skyline_plasticsurgery:checkMoney', function(source, cb)
	local wPlayer = SKYLINE.GetPlayerFromId(source)

	cb(wPlayer.getMoney() >= 150000)
end)

RegisterNetEvent("skyline_plasticsurgery:bezahlendukelb")
AddEventHandler("skyline_plasticsurgery:bezahlendukelb", function()
	local _source = source
	local wPlayer = SKYLINE.GetPlayerFromId(_source)

	wPlayer.removeMoney(150000)
	TriggerClientEvent("skyline_notify:Alert", source , "Schönheitsklinik" , "Du hast Gezahlt <span style=color:green;>150.000$" , 4000 , "success")
end)
-- Schöhnheitsklinik


-- Friseur
RegisterServerEvent('skyline_barbershop:pay')
AddEventHandler('skyline_barbershop:pay', function()

	local wPlayer = SKYLINE.GetPlayerFromId(source)

	wPlayer.removeMoney(ConfigBS.Price)
	wPlayer.triggerEvent("skyline_notify:Alert", "Friseur", "Du hast <span style=color:green;>50$</span> gezahlt." , 4000 , "success")

end)

SKYLINE.RegisterServerCallback('skyline_barbershop:checkMoney', function(source, cb)

	local wPlayer = SKYLINE.GetPlayerFromId(source)

	if wPlayer.getMoney() >= ConfigBS.Price then
		cb(true)
	else
		cb(false)
	end

end)
-- Friseur

-- Kleidungsladen 
RegisterServerEvent('skyline_clotheshop:pay')
AddEventHandler('skyline_clotheshop:pay', function()
	local wPlayer = SKYLINE.GetPlayerFromId(source)

	wPlayer.removeMoney(Config.Price)
	wPlayer.triggerEvent("skyline_notify:Alert", "Kleidungsladen" , "Du hast <span style=color:green;>85$</span> gezahlt." , 4000 , "success")
end)


RegisterServerEvent('skyline_clotheshop:saveOutfit')
AddEventHandler('skyline_clotheshop:saveOutfit', function(label, skin)
	local wPlayer = SKYLINE.GetPlayerFromId(source)

	TriggerEvent('datastoreistvollkuhl:getDataStore', 'property', wPlayer.identifier, function(store)
		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skin
		})

		store.set('dressing', dressing)
	end)
end)

RegisterServerEvent('skyline_clotheshop:deleteOutfit')
AddEventHandler('skyline_clotheshop:deleteOutfit', function(label)
	local wPlayer = SKYLINE.GetPlayerFromId(source)

	TriggerEvent('datastoreistvollkuhl:getDataStore', 'property', wPlayer.identifier, function(store)
		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		label = label
		
		table.remove(dressing, label)

		store.set('dressing', dressing)
	end)
end)

SKYLINE.RegisterServerCallback('skyline_clotheshop:checkMoney', function(source, cb)
	local wPlayer = SKYLINE.GetPlayerFromId(source)

	if wPlayer.getMoney() >= Config.Price then
		cb(true)
	else
		cb(false)
	end
end)

SKYLINE.RegisterServerCallback('skyline_clotheshop:checkPropertyDataStore', function(source, cb)
	local wPlayer    = SKYLINE.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('datastoreistvollkuhl:getDataStore', 'property', wPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)
end)

SKYLINE.RegisterServerCallback('skyline_clotheshop:getPlayerDressing', function(source, cb)
  local wPlayer  = SKYLINE.GetPlayerFromId(source)

  TriggerEvent('datastoreistvollkuhl:getDataStore', 'property', wPlayer.identifier, function(store)
    local count    = store.count('dressing')
    local labels   = {}

    for i=1, count, 1 do
      local entry = store.get('dressing', i)
      table.insert(labels, entry.label)
    end

    cb(labels)
  end)
end)

SKYLINE.RegisterServerCallback('skyline_clotheshop:getPlayerOutfit', function(source, cb, num)
  local wPlayer  = SKYLINE.GetPlayerFromId(source)

  TriggerEvent('datastoreistvollkuhl:getDataStore', 'property', wPlayer.identifier, function(store)
    local outfit = store.get('dressing', num)
    cb(outfit.skin)
  end)
end)
-- Kleidungsladen 
