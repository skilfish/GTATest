LATEV = nil
TriggerEvent('skylineistback:getSharedObject', function(obj) LATEV = obj end)

LATEV.RegisterServerCallback('latev_tattoos:GetPlayerTattoos', function(source, cb)
	local xPlayer = LATEV.GetPlayerFromId(source)

	if xPlayer then
		MySQL.Async.fetchAll('SELECT tattoos FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			if result[1].tattoos then
				cb(json.decode(result[1].tattoos))
			else
				cb()
			end
		end)
	else
		cb()
	end
end)

LATEV.RegisterServerCallback('latev_tattoos:PurchaseTattoo', function(source, cb, tattooList, price, tattoo, tattooName)
	local xPlayer = LATEV.GetPlayerFromId(source)
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		table.insert(tattooList, tattoo)

		MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
			['@tattoos'] = json.encode(tattooList),
			['@identifier'] = xPlayer.identifier
		})

		xPlayer.triggerEvent("skyline_notify:Alert", "Tatoo Laden" , "Du hast dir das Tatoo " .. tattooName .. " gekauft für " .. price .. "$" , 5000 , "succes")
		cb(true)
	else
		xPlayer.triggerEvent("skyline_notify:Alert", "Tatoo Laden" , "Du hast nicht genug Geld für das Tattoo!" , 5000 , "error" )
		cb(false)
	end
end)

RegisterServerEvent('latev_tattoos:RemoveTattoo')
AddEventHandler('latev_tattoos:RemoveTattoo', function (tattooList)
	local xPlayer = LATEV.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
		['@tattoos'] = json.encode(tattooList),
		['@identifier'] = xPlayer.identifier
	})
end)