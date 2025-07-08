ESX = nil

TriggerEvent('skylineistback:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('skyline_medikit:hasItem', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
local item = xPlayer.getInventoryItem(Config.UsableItem).count
    if item >= 1 then
        cb(true)
        xPlayer.removeInventoryItem(Config.UsableItem, 1)
    else
        cb(false)
    end
end)