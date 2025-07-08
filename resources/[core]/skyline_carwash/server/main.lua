SKYLINE = nil

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

SKYLINE.RegisterServerCallback('autowäscheduhs:canAfford', function(source, cb)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if Config.EnablePrice then
		if xPlayer.getMoney() >= Config.Price then
			xPlayer.removeMoney(Config.Price)
			cb(true)
		else
			cb(false)
		end
	else
		cb(true)
	end
end)