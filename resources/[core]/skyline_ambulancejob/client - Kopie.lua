SKYLINE = nil

isDead = false 
firstSpawn = true 

local hasJob = false 

Citizen.CreateThread(function()
	while SKYLINE == nil do
		TriggerEvent("skylineistback:getSharedObject", function(obj) SKYLINE = obj end)
		Citizen.Wait(0)
	end

    exports.spawnmanager:setAutoSpawn(false)


	Citizen.Wait(1000)

	SKYLINE.TriggerServerCallback("lsmdistgay:checkJob", function(name) 
		if name == "ambulance" then 
			hasJob = true 
		end 
	end)
end)


RegisterNetEvent("skyline:playerLoaded")
AddEventHandler("skyline:playerLoaded", function(xPlayer)
	if xPlayer.job.name == "ambulance" then 
		hasJob = true  
	end 
end)

RegisterNetEvent("skyline:setJob")
AddEventHandler("skyline:setJob", function(job)
	if job.name == "ambulance" then 
		hasJob = true 
	else 
		hasJob = false 
	end 
end)

-- DeathHandler -- 


-- Anti-Combat-Log
AddEventHandler("skyline:onPlayerSpawn", function()
	isDead = false

	if firstSpawn then
		firstSpawn = false

			SKYLINE.TriggerServerCallback("lsmdistgay:getDeathStatus", function(shouldDie)
				if shouldDie then
					Citizen.Wait(2000)
					SetEntityHealth(PlayerPedId(), 0)
				end
			end)
		
	end
end)
-- Anti-Combat-Log

-- Death-Function --
function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)

	TriggerServerEvent("skyline:onPlayerSpawn")
	TriggerEvent("skyline:onPlayerSpawn")
	TriggerEvent("playerSpawned") -- compatibility with old scripts, will be removed soon
end

function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextScale(0.0, 0.7)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end


function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function RemoveItemsAfterRPDeath()
	TriggerServerEvent("lsmdistgay:setDeathStatus", false)


	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end
 

		SKYLINE.TriggerServerCallback("lsmdistgay:removeItemsAfterRPDeath", function()
			local formattedCoords = {
				x =  327.3297,
				y = -603.1728,
				z =43.2840
			}

			SKYLINE.SetPlayerData("loadout", {})
			RespawnPed(PlayerPedId(), formattedCoords, 334.0070)

			StopScreenEffect("DeathFailOut")
			DoScreenFadeIn(800)
		end)
	end)
end

function StartDeathTimer()


	local bleedoutTimer = 900

	Citizen.CreateThread(function()
		while bleedoutTimer > 0 and isDead do
			Citizen.Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		local text, timeHeld

		-- bleedout timer
		while bleedoutTimer > 0 and isDead do
			Citizen.Wait(0)
			local a,b = secondsToClock(bleedoutTimer)

			if bleedoutTimer <= 59 then 
				text = "~r~Du blutest aus in ~y~ " .. b .. " Sekunden"

			else 
				text = "~r~Du blutest aus in ~y~" .. a .. " Minuten ~r~und ~y~" .. b .. " Sekunden"
			end 
			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		if bleedoutTimer < 1 and isDead then
			RemoveItemsAfterRPDeath()
		end
	end)
end

RegisterNetEvent("lsmdistgay:heal")
AddEventHandler('lsmdistgay:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end
end)

RegisterNetEvent("lsmdistgay:adminrevive")
AddEventHandler("lsmdistgay:adminrevive", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	TriggerServerEvent("lsmdistgay:setDeathStatus", false)

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(50)
	end

	local formattedCoords = {
		x = SKYLINE.Math.Round(coords.x, 1),
		y = SKYLINE.Math.Round(coords.y, 1),
		z = SKYLINE.Math.Round(coords.z, 1)
	}

	RespawnPed(playerPed, formattedCoords, 0.0)

	StopScreenEffect("DeathFailOut")
	DoScreenFadeIn(800)
	isDead = false 

	TriggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "Du wurdest <b style=color:red>administrativ</b> wiederbelebt." , 4000 , "success")
end)

function death()
    isDead = true
	SKYLINE.UI.Menu.CloseAll()

	TriggerServerEvent("lsmdistgay:setDeathStatus", true)

    StartDeathTimer()
	--StartDistressSignal()

	StartScreenEffect("DeathFailOut", 0, true)
end 

AddEventHandler("skyline:onPlayerDeath", function(data)
	death()
end)


-- DeathHandler -- 


-- F6-Menu -- 
RegisterNetEvent("lsmdistgay:revive")
AddEventHandler("lsmdistgay:revive", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	TriggerServerEvent("lsmdistgay:setDeathStatus", false)

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(50)
	end

	local formattedCoords = {
		x = SKYLINE.Math.Round(coords.x, 1),
		y = SKYLINE.Math.Round(coords.y, 1),
		z = SKYLINE.Math.Round(coords.z, 1)
	}

	RespawnPed(playerPed, formattedCoords, 0.0)

	StopScreenEffect("DeathFailOut")
	DoScreenFadeIn(800)
end)


local isBusy =  false 

function revivePlayer(closestPlayer)
	SKYLINE.UI.Menu.CloseAll()
	isBusy = true

			local closestPlayerPed = GetPlayerPed(closestPlayer)

			if IsPedDeadOrDying(closestPlayerPed, 1) then
				local playerPed = PlayerPedId()
				local lib, anim = "mini@cpr@char_a@cpr_str", "cpr_pumpchest"
				TriggerEvent("skyline_notify:Alert", "EMS" , "Reanimations gestartet..." , 2000 , "success")

				for i=1, 15 do
					Citizen.Wait(900)

					SKYLINE.Streaming.RequestAnimDict(lib, function()
						TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
					end)
				end

				TriggerServerEvent("lsmdistgay:revive", GetPlayerServerId(closestPlayer))

			else
				TriggerEvent("skyline_notify:Alert", "EMS" , "Person ist nicht bewusstlos.." , 3000 , "error")
			end
		
			isBusy = false
	
end

function OpenMobileAmbulanceActionsMenu()
	SKYLINE.UI.Menu.CloseAll()

	SKYLINE.UI.Menu.Open("default", GetCurrentResourceName(), "mobile_ambulance_actions", {
		title    = "LSMD - Menu",
		align    = "top-left",
		elements = {
			{label = "EMS - Aktionen", value = "citizen_interaction"}
	}}, function(data, menu)
		if data.current.value == "citizen_interaction" then
			SKYLINE.UI.Menu.Open("default", GetCurrentResourceName(), "citizen_interaction", {
				title    = "EMS",
				align    = "top-left",
				elements = {
					{label = "Wiederbeleben", value = "revive"},
					{label = "Verletzung Behandeln", value = "big"}
			}}, function(data, menu)

					if data.current.value == "revive" then
						local closestPlayer, closestDistance = SKYLINE.Game.GetClosestPlayer()

						if closestPlayer == -1 or closestDistance > 1.5 then
							TriggerEvent("skyline_notify:Alert", "EMS" , "Kein Patient in der Nähe!" , 3000 , "error")
							isBusy = false 
						else 
							revivePlayer(closestPlayer)
						end
		
					elseif data.current.value == "big" then


						local closestPlayer, closestDistance = SKYLINE.Game.GetClosestPlayer()

						if closestPlayer == -1 or closestDistance > 1.5 then
							TriggerEvent("skyline_notify:Alert", "EMS" , "Kein Patient in der Nähe!" , 3000 , "error")
						else 
							local closestPlayerPed = GetPlayerPed(closestPlayer)
							local health = GetEntityHealth(closestPlayerPed)

							
							if health > 0 then
								local playerPed = PlayerPedId()

								isBusy = true
								TriggerEvent("skyline_notify:Alert", "EMS" , "Behandlung gestartet..." , 3000 , "success")
								TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
								Citizen.Wait(10000)
								ClearPedTasks(playerPed)

								TriggerServerEvent("lsmdistgay:heal", GetPlayerServerId(closestPlayer), "big")
								TriggerEvent("skyline_notify:Alert", "EMS" , "Behandlung erfolgreich." , 3000 , "success")
								isBusy = false
							else
								TriggerEvent("skyline_notify:Alert", "EMS" , "Da wird eine Behandlung wohl nicht mehr helfen.." , 3000 , "error")
							end
						end

						

							

					end
				
			end, function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)

		if hasJob and not isDead and not isBusy then 
			if IsControlJustPressed(0, 167) then 
				OpenMobileAmbulanceActionsMenu()
			end 
		end 
	end 
end)
-- F6-Menu -- 


-- DeathHandler -- 
local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
local Bullet = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093 }
local Animal = { -100946242, 148160082 }
local FallDamage = { -842959696 }
local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
local Gas = { -1600701090 }
local Burn = { 615608432, 883325847, -544306709 }
local Drown = { -10959621, 1936677264 }
local Car = { 133987706, -1553120962 }

function checkArray (array, val)
	for name, value in ipairs(array) do
		if value == val then
			return true
		end
	end

	return false
end

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	  while true do

		if hasJob then 
			if not IsPedInAnyVehicle(GetPlayerPed(-1)) then

				local player, distance = SKYLINE.Game.GetClosestPlayer()
	
				if distance ~= -1 and distance < 10.0 then
	
					if distance ~= -1 and distance <= 2.0 then	
						if IsPedDeadOrDying(GetPlayerPed(player)) then
							Start(GetPlayerPed(player))
						end
					end
	
				else
					 
				end
	
			end
		end 


	
		Citizen.Wait(3000)

	end
end)

function Start(ped)
	checking = true
	
	while checking do
		
		Citizen.Wait(0)

		if hasJob then 
			local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(ped))

			local x,y,z = table.unpack(GetEntityCoords(ped))
	
			if distance < 2.0 then
				DrawText3D(x,y,z, 'Drücke [~g~E~s~] zum untersuchen', 0.4)
				
				if IsControlPressed(0, 38) then
					OpenDeathMenu(ped)
				end
			end
	
			if distance > 7.5 or not IsPedDeadOrDying(ped) then
				checking = false
			end
		end 
		

  end

end

function Notification(x,y,z)
	local timestamp = GetGameTimer()

	while (timestamp + 4500) > GetGameTimer() do
		Citizen.Wait(0)
		DrawText3D(x, y, z, 'Hier', 0.4)
		checking = false
	end
end

function OpenDeathMenu(player)

	loadAnimDict('amb@medic@standing@kneel@base')
	loadAnimDict('anim@gangops@facility@servers@bodysearch@')

	local elements   = {}

	table.insert(elements, {label = 'Todesgrund', value = 'deathcause'})
	table.insert(elements, {label = 'Stelle der Verletzung', value = 'damage'})


	SKYLINE.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'dead_citizen',
		{
			title    = 'Was willst du tun',
			align    = 'top-left',
			elements = elements,
		},
	function(data, menu)
		local ac = data.current.value

		if ac == 'damage' then

			local bone
			local success = GetPedLastDamageBone(player,bone)

			local success,bone = GetPedLastDamageBone(player)
			if success then
				--print(bone)
				local x,y,z = table.unpack(GetPedBoneCoords(player, bone))
				  Notification(x,y,z)
			  
			else
				Notify('Where the damage occured could not get identified')
			end
		end

		if ac == 'deathcause' then
			--gets deathcause
			local d = GetPedCauseOfDeath(player)		
			local playerPed = GetPlayerPed(-1)

			--starts animation

			TaskPlayAnim(GetPlayerPed(-1), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
			TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )

			Citizen.Wait(5000)

			--exits animation			

			ClearPedTasksImmediately(playerPed)

			if checkArray(Melee, d) then
				Notify("Durch einen starken Schlag.")
			elseif checkArray(Bullet, d) then
				Notify("Durch Kugeln.")
			elseif checkArray(Knife, d) then
				Notify("Durch einen Stich.")
			elseif checkArray(Animal, d) then
				Notify("Druch ein Biss.")
			elseif checkArray(FallDamage, d) then
				Notify("Durch einen hohen Fall")
			elseif checkArray(Explosion, d) then
				Notify("Durch eine Explosions")
			elseif checkArray(Gas, d) then
				Notify("Durch gitiges Gas.")
			elseif checkArray(Burn, d) then
				Notify("Durch einen Brand.")
			elseif checkArray(Drown, d) then
				Notify("Ertrunken.")
			elseif checkArray(Car, d) then
				Notify("Auto-Unfall")
			else
				Notify("Unbekannt")
			end
		end


	end,
	function(data, menu)
	  menu.close()
	end
  )
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		
		Citizen.Wait(1)
	end
end

function Notify(message)
	SKYLINE.ShowNotification(message)
end

function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
 
	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)
 
	AddTextComponentString(text)
	DrawText(_x, _y)
 
end

-- Outfits -- 
local isInCloak = false 
local posC = vector3(298.8693, -598.6066, 43.2832)

function OpenCloakroomMenu()
	SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = "LSMD - Umkleide",
		align    = 'top-left',
		elements = {
			{label = "Zivilkleidung", value = 'citizen_wear'},
			{label = "Dienstkleidung", value = 'ambulance_wear'},
	}}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			SKYLINE.TriggerServerCallback('spielerskin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinändernduhs:loadSkin', skin)
			end)
		elseif data.current.value == 'ambulance_wear' then
			SKYLINE.TriggerServerCallback('spielerskin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinändernduhs:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinändernduhs:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		end

		menu.close()
	end, function(data, menu)
		menu.close()
		isInCloak = false 
	end)
end


Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)

		if hasJob then 

			local pCoords = GetEntityCoords(PlayerPedId())

			if GetDistanceBetweenCoords(pCoords , posC , true) < 20.0 then 
				DrawMarker(1, posC.x, posC.y, posC.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.1, 1.1, 0.2, 255, 0, 0, 255, false, false, 2, false, nil, nil, false)
			end 
	
	
			if GetDistanceBetweenCoords(pCoords , posC , true) > 0.8 and isInCloak then 
				SKYLINE.UI.Menu.CloseAll()
				isInCloak = false 
			end 
	
			if GetDistanceBetweenCoords(pCoords , posC , true) < 0.8 and not isInCloak then 
				SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Kleiderschrank zu öffnen")
	
				if IsControlPressed(0 , 38) then 
					isInCloak = true 
					OpenCloakroomMenu()
				end 
			end 
		end 

	end 
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)

		if isDead then 
			DisableAllControlActions(0)
			EnableControlAction(0, 245, true)
		end 
	end 
end)	
