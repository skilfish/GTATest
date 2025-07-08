SKYLINE = nil
local Status, isPaused = {}, false

Citizen.CreateThread(function()
	while SKYLINE == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
		Citizen.Wait(0)
	end
end)

function GetStatusData(minimal)
	local status = {}

	for i=1, #Status, 1 do
		if minimal then
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				percent = (Status[i].val / Config.StatusMax) * 100
			})
		else
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				color   = Status[i].color,
				visible = Status[i].visible(Status[i]),
				max     = Status[i].max,
				percent = (Status[i].val / Config.StatusMax) * 100
			})
		end
	end

	return status
end

AddEventHandler('statusundso:registerStatus', function(name, default, color, visible, tickCallback)
	local status = CreateStatus(name, default, color, visible, tickCallback)
	table.insert(Status, status)
end)

AddEventHandler('statusundso:unregisterStatus', function(name)
	for k,v in ipairs(Status) do
		if v.name == name then
			table.remove(Status, k)
			break
		end
	end
end)

RegisterNetEvent('statusundso:load')
AddEventHandler('statusundso:load', function(status)
	for i=1, #Status, 1 do
		for j=1, #status, 1 do
			if Status[i].name == status[j].name then
				Status[i].set(status[j].val)
			end
		end
	end

	Citizen.CreateThread(function()
		while true do
            Citizen.Wait(0)

            if not exports["skyline_ffa"]:isInFFA() then 
                for i=1, #Status, 1 do
                    Status[i].onTick()
                end
    
                SendNUIMessage({
                    update = true,
                    status = GetStatusData()
                })
    
                
                TriggerEvent('statusundso:onTick', GetStatusData(true))
                Citizen.Wait(Config.TickTime)
            end 

			

		end
	end)
end)

RegisterNetEvent('statusundso:set')
AddEventHandler('statusundso:set', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].set(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('statusundso:update', GetStatusData(true))
end)

RegisterNetEvent('statusundso:add')
AddEventHandler('statusundso:add', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].add(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('statusundso:update', GetStatusData(true))
end)

RegisterNetEvent('statusundso:remove')
AddEventHandler('statusundso:remove', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].remove(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('statusundso:update', GetStatusData(true))
end)

AddEventHandler('statusundso:getStatus', function(name, cb)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			cb(Status[i])
			return
		end
	end
end)

AddEventHandler('statusundso:setDisplay', function(val)
	SendNUIMessage({
		setDisplay = true,
		display    = val
	})
end)

-- Pause menu disable hud display
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not isPaused then
			isPaused = true
			TriggerEvent('statusundso:setDisplay', 0.0)
		elseif not IsPauseMenuActive() and isPaused then
			isPaused = false 
			TriggerEvent('statusundso:setDisplay', 0.5)
		end
	end
end)

-- Loaded event
Citizen.CreateThread(function()
	TriggerEvent('statusundso:loaded')
end)

-- Update server
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.UpdateInterval)

		TriggerServerEvent('statusundso:update', GetStatusData(true))
	end
end)
