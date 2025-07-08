ESX = nil

TriggerEvent('skylineistback:getSharedObject', function(obj) ESX = obj end)

local wb = "https://discord.com/api/webhooks/992362635351834694/okdl5EbsuAsOdwGTBV86ya7vGWijHNbLINw0HVe3jNdm_q51tMWDX7oXqgPrLGAvIif9"

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

function secondsToClock(seconds)
  local seconds = tonumber(seconds)

  if seconds <= 0 then
    return "00:00:00";
  else
    hours = string.format("%02.f", math.floor(seconds/3600));
    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
    return hours..":"..mins..":"..secs
  end
end

RegisterServerEvent('deinemutterwirdgeschwaschen:washMoney')
AddEventHandler('deinemutterwirdgeschwaschen:washMoney', function(amount, zone)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tax
	local timer
	local enableTimer = false
	for k, spot in pairs (Config.Zones) do
		if zone == k then
			tax = spot.TaxRate
			enableTimer = spot.enableTimer
			timer = spot.timer
		end
	end
	amount = ESX.Math.Round(tonumber(amount))
	washedCash = amount * tax
	washedTotal = ESX.Math.Round(tonumber(washedCash))

	
	if enableTimer == true then
		--local timer = Config.timer
		local timeClock = ESX.Math.Round(timer / 1000)
	
		if amount > 0 and xPlayer.getAccount('black_money').money >= amount then
			xPlayer.removeAccountMoney('black_money', amount)
			TriggerClientEvent('skyline_notify:Alert', xPlayer.source, "GELDWÄSCHE" , "Dein Geld ist gewaschen in: " ..  secondsToClock(timeClock) .. " Minuten"  , 3500 , "success")

			Citizen.Wait(timer)
			
			TriggerClientEvent('skyline_notify:Alert', xPlayer.source, "GELDWÄSCHE" , "Du hast: <b style=color:red>" .. ESX.Math.GroupDigits(amount) .. "$</b> Schwarzgeld zu <b style=color:green;>" .. ESX.Math.GroupDigits(washedTotal) .. "$</b> normales Geld gewaschen."  , 3500 , "success")
			xPlayer.addMoney(washedTotal)
		else
			TriggerClientEvent('skyline_notify:Alert', xPlayer.source, "GELDWÄSCHE" , "Ungültige Menge!" , 2000  , "error")
		end
	else 
	
		if amount > 0 and xPlayer.getAccount('black_money').money >= amount then
			xPlayer.removeAccountMoney('black_money', amount)

			TriggerClientEvent('skyline_notify:Alert', xPlayer.source, "GELDWÄSCHE" , "Du hast: <b style=color:red>" .. ESX.Math.GroupDigits(amount) .. "$</b> Schwarzgeld zu <b style=color:green;>" .. ESX.Math.GroupDigits(washedTotal) .. "$</b> normales Geld gewaschen."  , 3500 , "success")
			xPlayer.addMoney(washedTotal)

			local msg = {
				{
					["color"] = "2123412",
					["title"] = "Geld wurde gewaschen",
					["description"] = "**Wie viel Schwarzegld wurde gewaschen:** " .. amount .. "$\n**Wie viel grünes kam raus: **" .. washedTotal .. "$ \n \n **Gewaschen von: **" .. xPlayer.getName() .. "\nLizenz: " .. xPlayer.getIdentifier() .. " \nDiscord: <@" .. getDCId(xPlayer.source) .. ">",
					["footer"] = {
						["text"] = "Copyright © Jucktnicht 2022",
						["icon_url"] = "",
					},
				}
			}
		
			PerformHttpRequest(wb, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE | Logs", embeds = msg}), { ['Content-Type'] = 'application/json' })
		else
			TriggerClientEvent('skyline_notify:Alert', xPlayer.source, "GELDWÄSCHE" , "Ungültige Menge!" , 2000 , "error")
		end
	end
	
end)