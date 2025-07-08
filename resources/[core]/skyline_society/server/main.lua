SKYLINE = nil
local Jobs = {}
local RegisteredSocieties = {}

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

function GetSociety(name)
	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			return RegisteredSocieties[i]
		end
	end
end

MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})

	for i=1, #result, 1 do
		Jobs[result[i].name] = result[i]
		Jobs[result[i].name].grades = {}
	end

	local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})

	for i=1, #result2, 1 do
		Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
	end
end)

AddEventHandler('jobsundso:registerSociety', function(name, label, account, datastore, inventory, data)
	local found = false

	local society = {
		name = name,
		label = label,
		account = account,
		datastore = datastore,
		inventory = inventory,
		data = data
	}

	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			found, RegisteredSocieties[i] = true, society
			break
		end
	end

	if not found then
		table.insert(RegisteredSocieties, society)
	end
end)

AddEventHandler('jobsundso:getSocieties', function(cb)
	cb(RegisteredSocieties)
end)

AddEventHandler('jobsundso:getSociety', function(name, cb)
	cb(GetSociety(name))
end)

RegisterServerEvent('jobsundso:withdrawMoney')
AddEventHandler('jobsundso:withdrawMoney', function(societyName, amount)
	local xPlayer = SKYLINE.GetPlayerFromId(source)
	local society = GetSociety(societyName)
	amount = SKYLINE.Math.Round(tonumber(amount))

	if xPlayer.job.name == society.name then
		TriggerEvent('accountoderso:getSharedAccount', society.account, function(account)
			if amount > 0 and account.money >= amount then
				account.removeMoney(amount)
				xPlayer.addMoney(amount)
				xPlayer.triggerEvent("skyline_notify", 1 , "Bank" , "Du hast <b style=color:green;>" .. amount .. "<b> abgehoben.")
			else
				xPlayer.triggerEvent("skyline_notify", 1 , "Bank" , "<b style=color:red;>Ungültige Menge!")
			end
		end)
	else
		print(('jobsundso: %s attempted to call withdrawMoney!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('jobsundso:depositMoney')
AddEventHandler('jobsundso:depositMoney', function(societyName, amount)
	local xPlayer = SKYLINE.GetPlayerFromId(source)
	local society = GetSociety(societyName)
	amount = SKYLINE.Math.Round(tonumber(amount))

	if xPlayer.job.name == society.name then
		if amount > 0 and xPlayer.getMoney() >= amount then
			TriggerEvent('accountoderso:getSharedAccount', society.account, function(account)
				xPlayer.removeMoney(amount)
				xPlayer.triggerEvent("skyline_notify", 1 , "Bank" , "Du hast <b style=color:green;>" .. amount .. "<b> aufgeladen.")
				account.addMoney(amount)
			end)
		else
			xPlayer.triggerEvent("skyline_notify", 1 , "Bank" , "<b style=color:red;>Ungültige Menge!")
		end
	else
		print(('jobsundso: %s attempted to call depositMoney!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('jobsundso:washMoney')
AddEventHandler('jobsundso:washMoney', function(society, amount)
	local xPlayer = SKYLINE.GetPlayerFromId(source)
	local account = xPlayer.getAccount('black_money')
	amount = SKYLINE.Math.Round(tonumber(amount))

	if xPlayer.job.name == society then
		if amount and amount > 0 and account.money >= amount then
			xPlayer.removeAccountMoney('black_money', amount)

			MySQL.Async.execute('INSERT INTO society_moneywash (identifier, society, amount) VALUES (@identifier, @society, @amount)', {
				['@identifier'] = xPlayer.identifier,
				['@society'] = society,
				['@amount'] = amount
			}, function(rowsChanged)
			--	xPlayer.showNotification(_U('you_have', SKYLINE.Math.GroupDigits(amount)))
			end)
		else
			xPlayer.triggerEvent("skyline_notify", 1 , "Bank" , "<b style=color:red;>Ungültige Menge!")
		end
	else
		print(('jobsundso: %s attempted to call washMoney!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('jobsundso:putVehicleInGarage')
AddEventHandler('jobsundso:putVehicleInGarage', function(societyName, vehicle)
	local society = GetSociety(societyName)

	TriggerEvent('SKYLINE_datastore:getSharedDataStore', society.datastore, function(store)
		local garage = store.get('garage') or {}
		table.insert(garage, vehicle)
		store.set('garage', garage)
	end)
end)

RegisterServerEvent('jobsundso:removeVehicleFromGarage')
AddEventHandler('jobsundso:removeVehicleFromGarage', function(societyName, vehicle)
	local society = GetSociety(societyName)

	TriggerEvent('SKYLINE_datastore:getSharedDataStore', society.datastore, function(store)
		local garage = store.get('garage') or {}

		for i=1, #garage, 1 do
			if garage[i].plate == vehicle.plate then
				table.remove(garage, i)
				break
			end
		end

		store.set('garage', garage)
	end)
end)

SKYLINE.RegisterServerCallback('jobsundso:getSocietyMoney', function(source, cb, societyName)
	local society = GetSociety(societyName)

	if society then
		TriggerEvent('accountoderso:getSharedAccount', society.account, function(account)
			cb(account.money)
		end)
	else
		cb(0)
	end
end)

SKYLINE.RegisterServerCallback('jobsundso:getEmployees', function(source, cb, society)

		MySQL.Async.fetchAll('SELECT firstname, lastname, identifier, job, job_grade FROM users WHERE job = @job ORDER BY job_grade DESC', {
			['@job'] = society
		}, function (results)
			local employees = {}

			for i=1, #results, 1 do
				table.insert(employees, {
					name       = results[i].firstname .. ' ' .. results[i].lastname,
					identifier = results[i].identifier,
					job = {
						name        = results[i].job,
						label       = Jobs[results[i].job].label,
						grade       = results[i].job_grade,
						grade_name  = Jobs[results[i].job].grades[tostring(results[i].job_grade)].name,
						grade_label = Jobs[results[i].job].grades[tostring(results[i].job_grade)].label
					}
				})
			end

			cb(employees)
		end)

end)



SKYLINE.RegisterServerCallback('jobsundso:fetchPlayer', function(source, cb, id)
	print(id)
	local xPlayer = SKYLINE.GetPlayerFromId(id)
	cb(xPlayer.getIdentifier() , xPlayer.getName())
end)

SKYLINE.RegisterServerCallback('jobsundso:getJob', function(source, cb, society)
	local job = json.decode(json.encode(Jobs[society]))
	local grades = {}

	for k,v in pairs(job.grades) do
		table.insert(grades, v)
	end

	table.sort(grades, function(a, b)
		return a.grade < b.grade
	end)

	job.grades = grades

	cb(job)
end)

SKYLINE.RegisterServerCallback('jobsundso:setJob', function(source, cb, identifier, job, grade, type)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer.job.grade_name == 'boss' or xPlayer.job.grade_name == "co_boss" then 

		local xTarget = SKYLINE.GetPlayerFromIdentifier(identifier)

		if xTarget then
			xTarget.setJob(job, grade)
			
			if type == 'hire' then
			TriggerClientEvent("skyline_notify" , xTarget.source ,  "Du wurdest eingestellt von: <b style=color:green;>" .. job , 3000 , "success")
			elseif type == 'promote' then
				xTarget.triggerEvent("skyline_notify" , "Du wurdest befördert." , 3000 , "success")
			elseif type == 'fire' then
				xTarget.triggerEvent("skyline_notify" , "Du wurdest gefeuert von: <b style=color:red;>" .. job , 3000 , "error")
			end


			MySQL.Sync.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
				['@job']        = job,
				['@job_grade']  = grade,
				['@identifier'] = identifier
			}, function(rowsChanged)
				cb()
			end)

		
			Citizen.Wait(100)

			cb()
		else
			MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
				['@job']        = job,
				['@job_grade']  = grade,
				['@identifier'] = identifier
			}, function(rowsChanged)
				cb()
			end)
		end

	end 



end)

SKYLINE.RegisterServerCallback('jobsundso:setJobSalary', function(source, cb, job, grade, salary)
	local xPlayer = SKYLINE.GetPlayerFromId(source)

	if xPlayer.job.name == job and xPlayer.job.grade_name == 'boss' then
			MySQL.Async.execute('UPDATE job_grades SET salary = @salary WHERE job_name = @job_name AND grade = @grade', {
				['@salary']   = salary,
				['@job_name'] = job,
				['@grade']    = grade
			}, function(rowsChanged)
				Jobs[job].grades[tostring(grade)].salary = salary
				local xPlayers = SKYLINE.GetPlayers()

				for i=1, #xPlayers, 1 do
					local xTarget = SKYLINE.GetPlayerFromId(xPlayers[i])

					if xTarget.job.name == job and xTarget.job.grade == grade then
						xTarget.setJob(job, grade)
					end
				end

				cb()
			end)
	
	else
		print(('jobsundso: %s attempted to setJobSalary'):format(xPlayer.identifier))
		cb()
	end
end)

SKYLINE.RegisterServerCallback('jobsundso:getOnlinePlayers', function(source, cb)
	local xPlayers = SKYLINE.GetPlayers()
	local players = {}

	for i=1, #xPlayers, 1 do
		local xPlayer = SKYLINE.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source = xPlayer.source,
			identifier = xPlayer.identifier,
			name = xPlayer.name,
			job = xPlayer.job
		})
	end

	cb(players)
end)

SKYLINE.RegisterServerCallback('jobsundso:getVehiclesInGarage', function(source, cb, societyName)
	local society = GetSociety(societyName)

	TriggerEvent('SKYLINE_datastore:getSharedDataStore', society.datastore, function(store)
		local garage = store.get('garage') or {}
		cb(garage)
	end)
end)

SKYLINE.RegisterServerCallback('jobsundso:isBoss', function(source, cb, job)
	cb(isPlayerBoss(source, job))
end)

function isPlayerBoss(playerId, job)
	local xPlayer = SKYLINE.GetPlayerFromId(playerId)

	if xPlayer.job.name == job and xPlayer.job.grade_name == 'boss' then
		return true
	elseif xPlayer.job.name == job and xPlayer.job.grade_name == 'co_boss' then
		return true
	else
		print(('jobsundso: %s attempted open a society boss menu!'):format(xPlayer.identifier))
		return false
	end
end

function WashMoneyCRON(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM society_moneywash', {}, function(result)
		for i=1, #result, 1 do
			local society = GetSociety(result[i].society)
			local xPlayer = SKYLINE.GetPlayerFromIdentifier(result[i].identifier)

			-- add society money
			TriggerEvent('accountoderso:getSharedAccount', society.account, function(account)
				account.addMoney(result[i].amount)
			end)

			-- send notification if player is online
			if xPlayer then
				--xPlayer.showNotification(_U('you_have_laundered', SKYLINE.Math.GroupDigits(result[i].amount)))
			end

			MySQL.Async.execute('DELETE FROM society_moneywash WHERE id = @id', {
				['@id'] = result[i].id
			})
		end
	end)
end

TriggerEvent('cron:runAt', 3, 0, WashMoneyCRON)
