SKYLINE.StartPayCheck = function()
	function payCheck()
		local xPlayers = SKYLINE.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = SKYLINE.GetPlayerFromId(xPlayers[i])
			local job     = xPlayer.job.grade_name
			local salary  = xPlayer.job.grade_salary

			if salary > 0 then
				if job == 'unemployed' then -- unemployed
					xPlayer.addAccountMoney('bank', salary)
					TriggerClientEvent('skyline:showAdvancedNotification', xPlayer.source, "Bank", "Sozialhilfe erhalten", "Menge: ~g~" .. salary .. "$", 'CHAR_BANK_MAZE', 9)
				elseif Config.EnableSocietyPayouts then -- possibly a society
					TriggerEvent('esx_society:getSociety', xPlayer.job.name, function (society)
						if society ~= nil then -- verified society
							TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function (account)
								if account.money >= salary then -- does the society money to pay its employees?
									xPlayer.addAccountMoney('bank', salary)
									account.removeMoney(salary)

									TriggerClientEvent('skyline:showAdvancedNotification', xPlayer.source, "Bank", "Gehalt erhalten","Menge: ~g~" .. salary .. "$", 'CHAR_BANK_MAZE', 9)
								else
									TriggerClientEvent('skyline:showAdvancedNotification', xPlayer.source, "Bank", '', "~r~Deine Firma ist pleite!", 'CHAR_BANK_MAZE', 1)
								end
							end)
						else -- not a society
							xPlayer.addAccountMoney('bank', salary)
							TriggerClientEvent('skyline:showAdvancedNotification', xPlayer.source, "Bank", "Gehalt erhalten","Menge: ~g~" .. salary .. "$", 'CHAR_BANK_MAZE', 9)
						end
					end)
				else -- generic job
					xPlayer.addAccountMoney('bank', salary)
					TriggerClientEvent('skyline:showAdvancedNotification', xPlayer.source, "Bank", "Gehalt erhalten","Menge: ~g~" .. salary .. "$", 'CHAR_BANK_MAZE', 9)
				end
			end

		end

		SetTimeout(Config.PaycheckInterval, payCheck)
	end

	SetTimeout(Config.PaycheckInterval, payCheck)
end
