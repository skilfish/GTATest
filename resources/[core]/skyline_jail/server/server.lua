ESX                = nil

TriggerEvent('skylineistback:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("jailihrfotzen:jailPlayer")
AddEventHandler("jailihrfotzen:jailPlayer", function(targetSrc, jailTime, jailReason)
	local src = source
	local targetSrc = tonumber(targetSrc)
	local xPlayer = ESX.GetPlayerFromId(targetSrc)

	JailPlayer(targetSrc, jailTime)


	TriggerClientEvent('chat:addMessage', -1, { args = { "GEFÄGNISS", xPlayer.getName() .. " ist jetzt im Gefägniss Grund: " .. jailReason }, color = { 249, 166, 0 } })
	

	TriggerClientEvent("skyline_notify:Alert", src, "LSPD" , "Du hast <b>" .. xPlayer.getName()  .. "</b> inhaftiert!" , 3000 , "success")
end)

RegisterServerEvent("jailihrfotzen:unJailPlayer")
AddEventHandler("jailihrfotzen:unJailPlayer", function(targetIdentifier)
	local src = source
	local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)

	if xPlayer ~= nil then
		UnJail(xPlayer.source)
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
	end

	TriggerClientEvent("skyline_notify:Alert", src, "LSPD" , "Du hast <b>" .. xPlayer.getName()  .. "</b> befreit!" , 3000 , "success")
end)

RegisterServerEvent("jailihrfotzen:updateJailTime")
AddEventHandler("jailihrfotzen:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("jailihrfotzen:prisonWorkReward")
AddEventHandler("jailihrfotzen:prisonWorkReward", function()
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)

	xPlayer.addMoney(math.random(13, 21))

	TriggerClientEvent("skyline:showNotification", src, "Thanks, here you have som cash for food!")
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("jailihrfotzen:jailPlayer", jailPlayer, jailTime)

	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("jailihrfotzen:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

ESX.RegisterServerCallback("jailihrfotzen:removeItems", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)


	if xPlayer.getAccount("black_money").money > 0 then
		xPlayer.setAccountMoney("black_money", 0)
	end


	for i=1, #xPlayer.inventory, 1 do
		if xPlayer.inventory[i].count > 0 then
			xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
		end
	end

	local playerLoadout = {}

	for i=1, #xPlayer.loadout, 1 do
		xPlayer.removeWeapon(xPlayer.loadout[i].name)
	end


	cb()
end)

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

ESX.RegisterServerCallback("jailihrfotzen:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name = result[i].firstname .. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)

ESX.RegisterServerCallback("jailihrfotzen:retrieveJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].jail)

		if JailTime > 0 then

			cb(true, JailTime)
		else
			cb(false, 0)
		end

	end)
end)