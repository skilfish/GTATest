-- Disable all NPC's
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

		SetVehicleDensityMultiplierThisFrame(0.0) 
		SetPedDensityMultiplierThisFrame(0.0) 
		SetRandomVehicleDensityMultiplierThisFrame(0.0) 
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) 
		SetGarbageTrucks(false) 
		SetRandomBoats(false)
		SetCreateRandomCops(false) 
		SetCreateRandomCopsNotOnScenarios(false)
		SetCreateRandomCopsOnScenarios(false)
		

		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);

		for i = 1, 12 do
			EnableDispatchService(i, false)
		end
		
		SetPlayerWantedLevel(PlayerId(), 0, false)
		SetPlayerWantedLevelNow(PlayerId(), false)
		SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
    end 
end)


-- No Weapons from cars 
AddEventHandler("playerSpawned", function()
    DisablePlayerVehicleRewards(PlayerPedId())
end)


-- Disable pump crash 
local pompModellen = {
	[`prop_gas_pump_1b`] = true,
	[`prop_gas_pump_1c`] = true,
    [`prop_gas_pump_old2`] = true,
	[`prop_gas_pump_1d`] = true,
	[`prop_gas_pump_1a`] = true,
	[`prop_vintage_pump`] = true,
	[`prop_gas_pump_old3`] = true
}

function FindNearestFuelPump()
	local coords = GetEntityCoords(PlayerPedId())
    local pompObject = 0
	local pompAfstand = 1000
	local objects = GetGamePool("CObject")
	local staat, resultaat = xpcall(function()
		local tel = 0
		for i=1, #objects do
			if tel % 30 == 0 then
				Wait(0)
			end
			tel = tel + 1
			if pompModellen[GetEntityModel(objects[i])] then
				SetEntityCollision(objects[i], false, false)
				local afstandcontroleren = #(coords - GetEntityCoords(objects[i]))
			
				if afstandcontroleren < pompAfstand then
					pompAfstand = afstandcontroleren
					pompObject = objects[i]
				end
			end
		end
	end, debug.traceback)
	if not staat then
		print(("Error" .. resultaat))
	end
	return pompObject, pompAfstand
end

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		local pompObject, pompAfstand = FindNearestFuelPump()
		if pompAfstand < 3.0 then
			isNearPump = pompObject
		else
			isNearPump = false
			Wait(math.ceil(pompAfstand * 3))
		end
	end
end)


-- Save armor 
local firstSpawn = false 

local last_armor = -1 
Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1000 * 60)

		local current_armor = GetPedArmour(PlayerPedId()) 

		if last_armor ~= current_armor then 
			last_armor = current_armor
			
			TriggerServerEvent("skyline_core:saveArmor", current_armor)
		end 
	end 
end)

local last_health = -1 
Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1000 * 60)

		local current_health = GetEntityHealth(PlayerPedId())

		if last_health ~= current_health then 
			last_health = current_health
			
			TriggerServerEvent("skyline_core:saveHealth", current_health)
		end 
	end 
end)


AddEventHandler("playerSpawned", function(spawn)
    Citizen.Wait(1000)

	if not firstSpawn then 
		firstSpawn = true 
		
		SKYLINE.TriggerServerCallback("skyline_core:getArmor", function(armor) 
			SetPedArmour(PlayerPedId(), armor)
		end)
	
		
		SKYLINE.TriggerServerCallback("skyline_core:getHealth", function(health) 
			SetEntityHealth(PlayerPedId(), health)
		end)
	end 


 end)


function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

-- https://forum.cfx.re/t/complete-weapon-labels-list-1-49/1167039
Citizen.CreateThread(function()
    AddTextEntry("WT_PIST_CBT", "Glock 17")
    AddTextEntry("WT_PIST", "FN 502")
    AddTextEntry("WT_SMG", "MP5")
    AddTextEntry("WT_RIFLE_CBN", "M4A1")
	AddTextEntry("WT_SMG_MCR", "MP7")
	AddTextEntry("WT_RIFLE_ASL" , "AK-47")
	AddTextEntry("WT_PIST_50" , "Desert Eagle")
	AddTextEntry("WT_RIFLE_ADV" , "AR-15")
end)

local firstSpawn1 = false 
-- lastpos 
RegisterNetEvent("playerSpawned")
AddEventHandler("playerSpawned", function(a)
    Citizen.Wait(2000)

    if not firstSpawn1 then 
        firstSpawn1 = true 

        SKYLINE.TriggerServerCallback("skyline_lastpos:needInit", function(d) end)
    
        SKYLINE.TriggerServerCallback("jucktnicht_einreise:hasEinreise", function(hasEinreise) 
            if not hasEinreise then 
              -- SKYLINE.Game.Teleport(PlayerPedId(), {x = -1140.36 , y = -2806.41 , z = 27.71 , heading = 250.2}, function() end)
            else 
               hasEinreise = true
    
               SKYLINE.TriggerServerCallback("skyline_lastpos:getLastPos", function(coords_e) 
                   local coords = json.decode(coords_e)
    
                   SKYLINE.Game.Teleport(PlayerPedId(), {x = coords.x , y = coords.y , z = coords.z , heading = 100.0}, function() end)
    
               end)
            end 
        end)
    end 

    
end)



Citizen.CreateThread(function()
    while true do 

        Citizen.Wait(60000)
        TriggerServerEvent("skyline_lastpos:save", GetEntityCoords(PlayerPedId()))
    end 
end)

