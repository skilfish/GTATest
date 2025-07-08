SKYLINE = {}
SKYLINE.Players = {}
SKYLINE.UsableItemsCallbacks = {}
SKYLINE.Items = {}
SKYLINE.ServerCallbacks = {}
SKYLINE.TimeoutCount = -1
SKYLINE.CancelledTimeouts = {}
SKYLINE.Pickups = {}
SKYLINE.PickupId = 0
SKYLINE.Jobs = {}
SKYLINE.RegisteredCommands = {}

AddEventHandler('skylineistback:getSharedObject', function(cb)
	cb(SKYLINE)
end)

function getSharedObject()
	return SKYLINE
end

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
		for k,v in ipairs(result) do
			SKYLINE.Items[v.name] = {
				label = v.label,
				weight = v.weight,
				rare = v.rare,
				canRemove = v.can_remove
			}
		end
	end)

	MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(jobs)
		for k,v in ipairs(jobs) do
			SKYLINE.Jobs[v.name] = v
			SKYLINE.Jobs[v.name].grades = {}
		end

		MySQL.Async.fetchAll('SELECT * FROM job_grades', {}, function(jobGrades)
			for k,v in ipairs(jobGrades) do
				if SKYLINE.Jobs[v.job_name] then
					SKYLINE.Jobs[v.job_name].grades[tostring(v.grade)] = v
				else
					print(('[SKYLINE_core] [^3WARNING^7] Ignoring job grades for "%s" due to missing job'):format(v.job_name))
				end
			end

			for k2,v2 in pairs(SKYLINE.Jobs) do
				if SKYLINE.Table.SizeOf(v2.grades) == 0 then
					SKYLINE.Jobs[v2.name] = nil
					print(('[SKYLINE_core] [^3WARNING^7] Ignoring job "%s" due to no job grades found'):format(v2.name))
				end
			end
		end)
	end)

	print('[SKYLINE_core] [^2INFO^7] SKYLINE-Core | SKYLINE fork von Juckthaltnicht')
end)

RegisterServerEvent('skyline:clientLog')
AddEventHandler('skyline:clientLog', function(msg)
	if Config.EnableDebug then
		print(('[SKYLINE_core] [^2TRACE^7] %s^7'):format(msg))
	end
end)

RegisterServerEvent('skyline:triggerServerCallback')
AddEventHandler('skyline:triggerServerCallback', function(name, requestId, ...)
	local playerId = source

	SKYLINE.TriggerServerCallback(name, requestId, playerId, function(...)
		TriggerClientEvent('skyline:serverCallback', playerId, requestId, ...)
	end, ...)
end)


            -- Jobs Creator integration (jobs_creator)
            RegisterNetEvent('esx:refreshJobs')
            AddEventHandler('esx:refreshJobs', function()
                MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(jobs)
                    for k,v in ipairs(jobs) do
                        SKYLINE.Jobs[v.name] = v
                        SKYLINE.Jobs[v.name].grades = {}
                    end

                    MySQL.Async.fetchAll('SELECT * FROM job_grades', {}, function(jobGrades)
                        for k,v in ipairs(jobGrades) do
                            if SKYLINE.Jobs[v.job_name] then
                                SKYLINE.Jobs[v.job_name].grades[tostring(v.grade)] = v
                            else
                                print(('[es_extended] [^3WARNING^7] Ignoring job grades for "%s" due to missing job'):format(v.job_name))
                            end
                        end

                        for k2,v2 in pairs(SKYLINE.Jobs) do
                            if SKYLINE.Table.SizeOf(v2.grades) == 0 then
                                SKYLINE.Jobs[v2.name] = nil
                                print(('[es_extended] [^3WARNING^7] Ignoring job "%s" due to no job grades found'):format(v2.name))
                            end
                        end
                    end)
                end)
            end)
        


        

            -- Jobs Creator integration (jobs_creator)
            SKYLINE.ServerCallbacks = SKYLINE.ServerCallbacks
    
        