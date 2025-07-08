ESX = nil

TriggerEvent('skylineistback:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback('sky_shops:canAfford', function(source, cb, value, warenkorb)
	local s = source
	local x = ESX.GetPlayerFromId(s)

	if x.getMoney() >= value then
		for key, value in pairs(warenkorb) do
			x.addInventoryItem(value.name, 1)
		end

		x.removeMoney(value)

		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('sky_shops:buye', function(source, cb, value, warenkorb)
	local s = source
	local x = ESX.GetPlayerFromId(s)

	if x.getAccount('bank').money >= value then
		for key, value in pairs(warenkorb) do
			x.addInventoryItem(value.name, 1)
		end


		x.removeAccountMoney('bank', value)

		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('sky_shops:loadItems', function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM shops', {}, function(shops)
		cb(shops)
	end)
end)