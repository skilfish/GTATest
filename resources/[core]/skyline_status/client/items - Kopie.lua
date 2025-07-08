local IsDead = false
local IsAnimated = false


AddEventHandler('essenundtrinken:resetStatus', function()
	TriggerEvent('statusundso:set', 'hunger', 500000)
	TriggerEvent('statusundso:set', 'thirst', 500000)

end)

AddEventHandler('playerSpawned', function()

	if IsDead then
		TriggerEvent('essenundtrinken:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('statusundso:loaded', function(status)

	TriggerEvent('statusundso:registerStatus', 'hunger', 1000000, '#CFAD0F',
		function(status)
			return true
		end,
		function(status)
			status.remove(200)
		end
	)

	TriggerEvent('statusundso:registerStatus', 'thirst', 1000000, '#0C98F1',
		function(status)
			return true
		end,
		function(status)
			status.remove(250)
		end
	)

	Citizen.CreateThread(function()

		while true do

			Wait(1000)

			local playerPed  = GetPlayerPed(-1)
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('statusundso:getStatus', 'hunger', function(status)
				
				if status.val == 0 then

					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end

				end

			end)

			TriggerEvent('statusundso:getStatus', 'thirst', function(status)
				
				if status.val == 0 then

					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end

				end

			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed,  health)
			end

		end

	end)

	Citizen.CreateThread(function()

		while true do

			Wait(0)

			local playerPed = GetPlayerPed(-1)
			
			if IsEntityDead(playerPed) and not IsDead then
				IsDead = true
			end

		end

	end)

end)

AddEventHandler('essenundtrinken:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('essenundtrinken:onEat')
AddEventHandler('essenundtrinken:onEat', function(prop_name)
    if not IsAnimated then
		local prop_name = prop_name or 'prop_cs_burger_01'
    	IsAnimated = true
	    local playerPed = GetPlayerPed(-1)
	    Citizen.CreateThread(function()
	        local x,y,z = table.unpack(GetEntityCoords(playerPed))
	        prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
	        AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
	        RequestAnimDict('mp_player_inteat@burger')
	        while not HasAnimDictLoaded('mp_player_inteat@burger') do
	            Wait(0)
	        end
	        TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
	        Wait(3000)
	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
	        DeleteObject(prop)
	    end)
	end
end)

RegisterNetEvent('essenundtrinken:onDrink')
AddEventHandler('essenundtrinken:onDrink', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)			
	        AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Wait(0)
			end
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
			Wait(3000)
	        IsAnimated = false
	        ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)