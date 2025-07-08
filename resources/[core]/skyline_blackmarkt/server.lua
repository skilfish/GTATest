local wb = "https://discord.com/api/webhooks/990280751570354206/e_sNpL4SNr0W9OiafQ7Lp5b4yzPbjo7G5JpHuHP0JrKFATNukDJeCyFKaqxB-2uBVVMB"
ESX = nil
TriggerEvent('skylineistback:getSharedObject', function(obj) ESX = obj end)

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

ESX.RegisterServerCallback('dukleinernuttensohn:buyWeapon', function(source, cb, weaponName, price)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.ArgentSale then
		if xPlayer.getAccount('black_money').money >= price then
			xPlayer.removeAccountMoney('black_money', price)
			xPlayer.addWeapon(weaponName, 42)

			local msg = {
				{
					["color"] = "2123412",
					["title"] = "Waffe gekauft",
					["description"] = "**Welche Waffe gekauft wurde:** " .. weaponName .. "\n**Preis: **" .. price .. "$ \n \n **Gekauft von: **" .. xPlayer.getName() .. "\nLizenz: " .. xPlayer.getIdentifier() .. " \nDiscord: <@" .. getDCId(xPlayer.source) .. ">",
					["footer"] = {
						["text"] = "Copyright © Jucktnicht 2022",
						["icon_url"] = "",
					},
				}
			}
		
			PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })

			cb(true)
		else
			TriggerClientEvent('skyline:showAdvancedNotification', _source, "Seller", "", "Du hast nicht genug Schwarzgeld!" , "CHAR_MP_MERRYWEATHER", 1)
			cb(false)
		end
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)
			xPlayer.addWeapon(weaponName, 42)

			cb(true)
		else
			TriggerClientEvent('skyline:showAdvancedNotification', _source, "Seller", "", "Du hast nicht genug Geld!" , "CHAR_MP_MERRYWEATHER", 1)
			cb(false)
		end
	end
end)