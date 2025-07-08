SKYLINE = nil

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

RegisterServerEvent('rechnungundso:sendBill')
AddEventHandler('rechnungundso:sendBill', function(playerId, sharedAccountName, label, amount, split)
	if split == nil then
			split = false
	end

	local _source = source
	local xPlayer = SKYLINE.GetPlayerFromId(_source)
	local xTarget = SKYLINE.GetPlayerFromId(playerId)
	amount        = SKYLINE.Math.Round(amount)

	TriggerEvent('accountoderso:getSharedAccount', sharedAccountName, function(account)

		if amount < 0 then
			--print(('rechnungundso: %s attempted to send a negative bill!'):format(xPlayer.identifier))
		elseif account == nil then

			if xTarget ~= nil then
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount, split, paid) VALUES (@identifier, @sender, @target_type, @target, @label, @amount, @split, @paid)',
				{
					['@identifier']  = xTarget.identifier,
					['@sender']      = xPlayer.identifier,
					['@target_type'] = 'player',
					['@target']      = xPlayer.identifier,
					['@label']       = label,
					['@amount']      = amount,
					['@split']		 = split,
					['@paid']		 = false
				}, function(rowsChanged)
					TriggerClientEvent("skyline_notify:Alert", xTarget.source, "RECHNUNG" , "<b style=color:red;>Du hast eine Rechnung erhalten." , 4000 , "success")
				end)
			end

		else

			if xTarget ~= nil then
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount, split, paid) VALUES (@identifier, @sender, @target_type, @target, @label, @amount, @split, @paid)',
				{
					['@identifier']  = xTarget.identifier,
					['@sender']      = xPlayer.identifier,
					['@target_type'] = 'society',
					['@target']      = sharedAccountName,
					['@label']       = label,
					['@amount']      = amount,
					['@split']		 = split,
					['@paid']		 = false
				}, function(rowsChanged)
					TriggerClientEvent("skyline_notify:Alert", xTarget.source, 1 , "RECHNUNG" , "<b style=color:red;>Du hast eine Rechnung erhalten." , 4000 , "success")
				end)
			end

		end
	end)

end)

SKYLINE.RegisterServerCallback('rechnungundso:getBills', function(source, cb)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier AND paid = false', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		local bills = {}
		for i=1, #result, 1 do
			table.insert(bills, {
				id         = result[i].id,
				identifier = result[i].identifier,
				sender     = result[i].sender,
				targetType = result[i].target_type,
				target     = result[i].target,
				label      = result[i].label,
				amount     = result[i].amount
			})
		end

		cb(bills)
	end)
end)

SKYLINE.RegisterServerCallback('rechnungundso:getTargetBills', function(source, cb, target)
	local xPlayer = SKYLINE.GetPlayerFromId(target)

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		local bills = {}
		for i=1, #result, 1 do
			table.insert(bills, {
				id         = result[i].id,
				identifier = result[i].identifier,
				sender     = result[i].sender,
				targetType = result[i].target_type,
				target     = result[i].target,
				label      = result[i].label,
				amount     = result[i].amount
			})
		end

		cb(bills)
	end)
end)


SKYLINE.RegisterServerCallback('rechnungundso:payBill', function(source, cb, id)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE id = @id', {
		['@id'] = id
	}, function(result)

		local sender     = result[1].sender
		local targetType = result[1].target_type
		local target     = result[1].target
		local amount     = result[1].amount

		local xTarget = SKYLINE.GetPlayerFromIdentifier(sender)

		if targetType == 'player' then

			if xTarget ~= nil then

				if xPlayer.getMoney() >= amount then

					MySQL.Async.execute('UPDATE billing SET paid = true WHERE id = @id', {
						['@id'] = id
					}, function()
						xPlayer.removeMoney(amount)
						xTarget.addAccountMoney('bank', amount)
						TriggerClientEvent("skyline_notify:Alert", xTarget.source, 1 , "RECHNUNG" , "<b style=color:green;>Du hast eine Zahlung erhalten, in der Höhe von " .. SKYLINE.Math.GroupDigits(amount) .. "$ erhalten." )
						TriggerClientEvent("skyline_notify:Alert", xPlayer.source, 1 , "RECHNUNG" , "<b style=color:green;>Rechnung erfolgreich gezahlt")
						cb()
					end)

				elseif xPlayer.getBank() >= amount then
					MySQL.Async.execute('UPDATE billing SET paid = true WHERE id = @id', {
						['@id'] = id
					}, function(rowsChanged)
						MySQL.Async.fetchAll('SELECT * FROM billing WHERE id = @id', {
							['@id'] = id
						}, function(result)
							if result[1].split == true then
								print('Society paid invoice with split')
								local percent = 0.05
								xPlayer.removeMoney('bank', amount)
								xTarget.addAccountMoney('bank', amount*(1-percent))
								local worker = SKYLINE.GetPlayerFromIdentifier(result[1].sender)
								worker.addAccountMoney('bank', amount*percent)
							else
								xPlayer.removeAccountMoney('bank', amount)
								xTarget.addAccountMoney('bank', amount)
							end
						end)

						TriggerClientEvent("skyline_notify:Alert", xTarget.source, 1 , "RECHNUNG" , "<b style=color:green;>Du hast eine Zahlung erhalten, in der Höhe von " .. SKYLINE.Math.GroupDigits(amount) .. "$ erhalten." )
						TriggerClientEvent("skyline_notify:Alert", xPlayer.source, 1 , "RECHNUNG" , "<b style=color:green;>Rechnung erfolgreich gezahlt")
					
						cb()
					end)

				else
					TriggerClientEvent("skyline_notify:Alert", xTarget.source, 1 , "RECHNUNG" , "<b style=color:red;>Rechnung konnte nicht ausgestellt werden, Konto ist zu leer")
					TriggerClientEvent("skyline_notify:Alert", xPlayer.source, 1 , "RECHNUNG" , "<b style=color:red;>Du hast nicht genug Geld!")
			

					cb()
				end

			else
				TriggerClientEvent("skyline_notify:Alert", xPlayer.source, 1 , "RECHNUNG" , "<b style=color:red;>Bewohner ist nicht Wach!")
				cb()
			end

		else
			TriggerEvent('accountoderso:getSharedAccount', target, function(account)

				if xPlayer.getMoney() >= amount then
					MySQL.Async.execute('UPDATE billing SET paid = true WHERE id = @id', {
						['@id'] = id
					}, function(rowsChanged)
						MySQL.Async.fetchAll('SELECT * FROM billing WHERE id = @id', {
							['@id'] = id
						}, function(result)
							if result[1].split == true then
								xPlayer.removeMoney(amount)
								account.addMoney(amount*(1-Config.Percent))
								local worker = SKYLINE.GetPlayerFromIdentifier(result[1].sender)
								worker.addAccountMoney('bank', amount*Config.Percent)
							else
								xPlayer.removeMoney(amount)
								account.addAccountMoney('bank', amount)
							end
						end)
						TriggerClientEvent("skyline_notify:Alert", xPlayer.source, 1 , "RECHNUNG" , "<b style=color:green;>Rechnung erfolgreich gezahlt")
						if xTarget ~= nil then
							TriggerClientEvent("skyline_notify:Alert", xTarget.source, 1 , "RECHNUNG" , "<b style=color:green;>Du hast eine Zahlung erhalten, in der Höhe von " .. SKYLINE.Math.GroupDigits(amount) .. "$ erhalten." )
						end

						cb()
					end)

				elseif xPlayer.getBank() >= amount then
					MySQL.Async.execute('UPDATE billing SET paid = true WHERE id = @id', {
						['@id'] = id
					}, function(rowsChanged)
						MySQL.Async.fetchAll('SELECT * FROM billing WHERE id = @id', {
							['@id'] = id
						}, function(result)
							if result[1].split == true then
								xPlayer.removeMoney(amount)
								account.addMoney(amount*(1-Config.Percent))
								local worker = SKYLINE.GetPlayerFromIdentifier(result[1].sender)
								worker.addAccountMoney('bank', amount*Config.Percent)
							else
								xPlayer.removeMoney(amount)
								account.addAccountMoney('bank', amount)
							end
						end)

						TriggerClientEvent("skyline_notify:Alert", xPlayer.source, 1 , "RECHNUNG" , "<b style=color:green;>Rechnung erfolgreich gezahlt" )
						if xTarget ~= nil then
							TriggerClientEvent("skyline_notify:Alert", xTarget.source, 1 , "RECHNUNG" , "<b style=color:green;>Du hast eine Zahlung erhalten, in der Höhe von " .. SKYLINE.Math.GroupDigits(amount) .. "$ erhalten." )
						end

						cb()
					end)

				else
					TriggerClientEvent("skyline_notify:Alert", xPlayer.source, 1 , "RECHNUNG" , "<b style=color:red;>Du hast nicht genug Geld!")
					if xTarget ~= nil then
						TriggerClientEvent("skyline_notify:Alert", xTarget.source, 1 , "RECHNUNG" , "<b style=color:red;>Rechnung konnte nicht ausgestellt werden, Konto ist zu leer")
					end

					cb()
				end
			end)

		end

	end)
end)



function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end