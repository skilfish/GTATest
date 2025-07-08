local isPaused, isDead, pickups = false, false, {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsPlayerActive(PlayerId()) then
			TriggerServerEvent('skyline:onPlayerJoined')
			break
		end
	end
end)

RegisterNetEvent('skyline:playerLoaded')
AddEventHandler('skyline:playerLoaded', function(playerData)
	SKYLINE.PlayerLoaded = true
	SKYLINE.PlayerData = playerData

	-- check if player is coming from loading screen
	if GetEntityModel(PlayerPedId()) == GetHashKey('PLAYER_ZERO') then
		local defaultModel = GetHashKey('a_m_y_stbla_02')
		RequestModel(defaultModel)

		while not HasModelLoaded(defaultModel) do
			Citizen.Wait(10)
		end

		SetPlayerModel(PlayerId(), defaultModel)
		SetPedDefaultComponentVariation(PlayerPedId())
		SetPedRandomComponentVariation(PlayerPedId(), true)
		SetModelAsNoLongerNeeded(defaultModel)
	end

	-- freeze the player
	FreezeEntityPosition(PlayerPedId(), true)

	-- enable PVP
	SetCanAttackFriendly(PlayerPedId(), true, false)
	NetworkSetFriendlyFireOption(true)

	-- disable wanted level
	ClearPlayerWantedLevel(PlayerId())
	SetMaxWantedLevel(0)

	if Config.EnableHud then
		for k,v in ipairs(playerData.accounts) do
			local accountTpl = '<div><img src="img/accounts/' .. v.name .. '.png"/>&nbsp;{{money}}</div>'
			SKYLINE.UI.HUD.RegisterElement('account_' .. v.name, k, 0, accountTpl, {money = SKYLINE.Math.GroupDigits(v.money)})
		end

		local jobTpl = '<div>{{job_label}} - {{grade_label}}</div>'

		if playerData.job.grade_label == '' or playerData.job.grade_label == playerData.job.label then
			jobTpl = '<div>{{job_label}}</div>'
		end

		SKYLINE.UI.HUD.RegisterElement('job', #playerData.accounts, 0, jobTpl, {
			job_label = playerData.job.label,
			grade_label = playerData.job.grade_label
		})
	end


		TriggerServerEvent('skyline:onPlayerSpawn')
		TriggerEvent('skyline:onPlayerSpawn')
		TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
		TriggerEvent('skyline:restoreLoadout')

		Citizen.Wait(4000)
		ShutdownLoadingScreen()
		ShutdownLoadingScreenNui()
		FreezeEntityPosition(PlayerPedId(), false)
		DoScreenFadeIn(10000)
		StartServerSyncLoops()
	

	TriggerEvent('skyline:loadingScreenOff')
end)

RegisterNetEvent('skyline:setMaxWeight')
AddEventHandler('skyline:setMaxWeight', function(newMaxWeight) SKYLINE.PlayerData.maxWeight = newMaxWeight end)

AddEventHandler('skyline:onPlayerSpawn', function() isDead = false end)
AddEventHandler('skyline:onPlayerDeath', function() isDead = true end)

AddEventHandler('skinändernduhs:modelLoaded', function()
	while not SKYLINE.PlayerLoaded do
		Citizen.Wait(100)
	end

	TriggerEvent('skyline:restoreLoadout')
end)

AddEventHandler('skyline:restoreLoadout', function()
	local playerPed = PlayerPedId()
	local ammoTypes = {}
	RemoveAllPedWeapons(playerPed, true)

	for k,v in ipairs(SKYLINE.PlayerData.loadout) do
		local weaponName = v.name
		local weaponHash = GetHashKey(weaponName)

		GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
		SetPedWeaponTintIndex(playerPed, weaponHash, v.tintIndex)

		local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

		for k2,v2 in ipairs(v.components) do
			local componentHash = SKYLINE.GetWeaponComponent(weaponName, v2).hash
			GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
		end

		if not ammoTypes[ammoType] then
			AddAmmoToPed(playerPed, weaponHash, v.ammo)
			ammoTypes[ammoType] = true
		end
	end
end)

RegisterNetEvent('skyline:setAccountMoney')
AddEventHandler('skyline:setAccountMoney', function(account)
	for k,v in ipairs(SKYLINE.PlayerData.accounts) do
		if v.name == account.name then
			SKYLINE.PlayerData.accounts[k] = account
			break
		end
	end

	if Config.EnableHud then
		SKYLINE.UI.HUD.UpdateElement('account_' .. account.name, {
			money = SKYLINE.Math.GroupDigits(account.money)
		})
	end
end)

RegisterNetEvent('skyline:addInventoryItem')
AddEventHandler('skyline:addInventoryItem', function(item, count, showNotification)
	for k,v in ipairs(SKYLINE.PlayerData.inventory) do
		if v.name == item then
			SKYLINE.UI.ShowInventoryItemNotification(true, v.label, count - v.count)
			SKYLINE.PlayerData.inventory[k].count = count
			break
		end
	end

	if showNotification then
		SKYLINE.UI.ShowInventoryItemNotification(true, item, count)
	end

	if SKYLINE.UI.Menu.IsOpen('default', 'SKYLINE_core', 'inventory') then
		SKYLINE.ShowInventory()
	end
end)

RegisterNetEvent('skyline:removeInventoryItem')
AddEventHandler('skyline:removeInventoryItem', function(item, count, showNotification)
	for k,v in ipairs(SKYLINE.PlayerData.inventory) do
		if v.name == item then
			SKYLINE.UI.ShowInventoryItemNotification(false, v.label, v.count - count)
			SKYLINE.PlayerData.inventory[k].count = count
			break
		end
	end

	if showNotification then
		SKYLINE.UI.ShowInventoryItemNotification(false, item, count)
	end

	if SKYLINE.UI.Menu.IsOpen('default', 'SKYLINE_core', 'inventory') then
		SKYLINE.ShowInventory()
	end
end)

RegisterNetEvent('skyline:setJob')
AddEventHandler('skyline:setJob', function(job)
	SKYLINE.PlayerData.job = job
end)

RegisterNetEvent('skyline:addWeapon')
AddEventHandler('skyline:addWeapon', function(weaponName, ammo)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
end)

RegisterNetEvent('skyline:addWeaponComponent')
AddEventHandler('skyline:addWeaponComponent', function(weaponName, weaponComponent)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = SKYLINE.GetWeaponComponent(weaponName, weaponComponent).hash

	GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('skyline:setWeaponAmmo')
AddEventHandler('skyline:setWeaponAmmo', function(weaponName, weaponAmmo)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	SetPedAmmo(playerPed, weaponHash, weaponAmmo)
end)

RegisterNetEvent('skyline:setWeaponTint')
AddEventHandler('skyline:setWeaponTint', function(weaponName, weaponTintIndex)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	SetPedWeaponTintIndex(playerPed, weaponHash, weaponTintIndex)
end)

RegisterNetEvent('skyline:removeWeapon')
AddEventHandler('skyline:removeWeapon', function(weaponName)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	RemoveWeaponFromPed(playerPed, weaponHash)
	SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
end)

RegisterNetEvent('skyline:removeWeaponComponent')
AddEventHandler('skyline:removeWeaponComponent', function(weaponName, weaponComponent)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = SKYLINE.GetWeaponComponent(weaponName, weaponComponent).hash

	RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('skyline:teleport')
AddEventHandler('skyline:teleport', function(coords)
	local playerPed = PlayerPedId()

	-- ensure decmial number
	coords.x = coords.x + 0.0
	coords.y = coords.y + 0.0
	coords.z = coords.z + 0.0

	SKYLINE.Game.Teleport(playerPed, coords)
end)

RegisterNetEvent('skyline:setJob')
AddEventHandler('skyline:setJob', function(job)
	if Config.EnableHud then
		SKYLINE.UI.HUD.UpdateElement('job', {
			job_label = job.label,
			grade_label = job.grade_label
		})
	end
end)

RegisterNetEvent('skyline:spawnVehicle')
AddEventHandler('skyline:spawnVehicle', function(vehicleName)
	local model = (type(vehicleName) == 'number' and vehicleName or GetHashKey(vehicleName))

	if IsModelInCdimage(model) then
		local playerPed = PlayerPedId()
		local playerCoords, playerHeading = GetEntityCoords(playerPed), GetEntityHeading(playerPed)

		SKYLINE.Game.SpawnVehicle(model, playerCoords, playerHeading, function(vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		end)
	else
		TriggerEvent('chat:addMessage', {args = {'^1SYSTEM', 'Invalid vehicle model.'}})
	end
end)

RegisterNetEvent('skyline:createPickup')
AddEventHandler('skyline:createPickup', function(pickupId, label, coords, type, name, components, tintIndex)
	local function setObjectProperties(object)
		SetEntityAsMissionEntity(object, true, false)
		PlaceObjectOnGroundProperly(object)
		FreezeEntityPosition(object, true)
		SetEntityCollision(object, false, true)

		pickups[pickupId] = {
			obj = object,
			label = label,
			inRange = false,
			coords = vector3(coords.x, coords.y, coords.z)
		}
	end

	--if type == 'item_weapon' then
		--local weaponHash = GetHashKey(name)
		--SKYLINE.Streaming.RequestWeaponAsset(weaponHash)
		--local pickupObject = CreateWeaponObject(weaponHash, 50, coords.x, coords.y, coords.z, true, 1.0, 0)
		--SetWeaponObjectTintIndex(pickupObject, tintIndex)

		--for k,v in ipairs(components) do
		--	local component = SKYLINE.GetWeaponComponent(name, v)
		--	GiveWeaponComponentToWeaponObject(pickupObject, component.hash)
		--end

		--setObjectProperties(pickupObject)
	--else
		--SKYLINE.Game.SpawnLocalObject('prop_money_bag_01', coords, setObjectProperties)
	--end
end)

RegisterNetEvent('skyline:createMissingPickups')
AddEventHandler('skyline:createMissingPickups', function(missingPickups)
	for pickupId,pickup in pairs(missingPickups) do
		TriggerEvent('skyline:createPickup', pickupId, pickup.label, pickup.coords, pickup.type, pickup.name, pickup.components, pickup.tintIndex)
	end
end)

RegisterNetEvent('skyline:registerSuggestions')
AddEventHandler('skyline:registerSuggestions', function(registeredCommands)
	for name,command in pairs(registeredCommands) do
		if command.suggestion then
			TriggerEvent('chat:addSuggestion', ('/%s'):format(name), command.suggestion.help, command.suggestion.arguments)
		end
	end
end)

RegisterNetEvent('skyline:removePickup')
AddEventHandler('skyline:removePickup', function(pickupId)
	if pickups[pickupId] and pickups[pickupId].obj then
		SKYLINE.Game.DeleteObject(pickups[pickupId].obj)
		pickups[pickupId] = nil
	end
end)

RegisterNetEvent('skyline:deleteVehicle')
AddEventHandler('skyline:deleteVehicle', function(radius)
	local playerPed = PlayerPedId()

	if radius and tonumber(radius) then
		radius = tonumber(radius) + 0.01
		local vehicles = SKYLINE.Game.GetVehiclesInArea(GetEntityCoords(playerPed), radius)

		for k,entity in ipairs(vehicles) do
			local attempt = 0

			while not NetworkHasControlOfEntity(entity) and attempt < 100 and DoesEntityExist(entity) do
				Citizen.Wait(100)
				NetworkRequestControlOfEntity(entity)
				attempt = attempt + 1
			end

			if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
				SKYLINE.Game.DeleteVehicle(entity)
			end
		end
	else
		local vehicle, attempt = SKYLINE.Game.GetVehicleInDirection(), 0

		if IsPedInAnyVehicle(playerPed, true) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		end

		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(vehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			SKYLINE.Game.DeleteVehicle(vehicle)
		end
	end
end)

-- Pause menu disables HUD display
if Config.EnableHud then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(300)

			if IsPauseMenuActive() and not isPaused then
				isPaused = true
				SKYLINE.UI.HUD.SetDisplay(0.0)
			elseif not IsPauseMenuActive() and isPaused then
				isPaused = false
				SKYLINE.UI.HUD.SetDisplay(1.0)
			end
		end
	end)

	AddEventHandler('skyline:loadingScreenOff', function()
		SKYLINE.UI.HUD.SetDisplay(1.0)
	end)
end

function StartServerSyncLoops()
	-- keep track of ammo
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)

			if isDead then
				Citizen.Wait(500)
			else
				local playerPed = PlayerPedId()

				if IsPedShooting(playerPed) then
					local _,weaponHash = GetCurrentPedWeapon(playerPed, true)
					local weapon = SKYLINE.GetWeaponFromHash(weaponHash)

					if weapon then
						local ammoCount = GetAmmoInPedWeapon(playerPed, weaponHash)
						TriggerServerEvent('skyline:updateWeaponAmmo', weapon.name, ammoCount)
					end
				end
			end
		end
	end)

	-- sync current player coords with server
	Citizen.CreateThread(function()
		local previousCoords = vector3(SKYLINE.PlayerData.coords.x, SKYLINE.PlayerData.coords.y, SKYLINE.PlayerData.coords.z)

		while true do
			Citizen.Wait(1000)
			local playerPed = PlayerPedId()

			if DoesEntityExist(playerPed) then
				local playerCoords = GetEntityCoords(playerPed)
				local distance = #(playerCoords - previousCoords)

				if distance > 1 then
					previousCoords = playerCoords
					local playerHeading = SKYLINE.Math.Round(GetEntityHeading(playerPed), 1)
					local formattedCoords = {x = SKYLINE.Math.Round(playerCoords.x, 1), y = SKYLINE.Math.Round(playerCoords.y, 1), z = SKYLINE.Math.Round(playerCoords.z, 1), heading = playerHeading}
					TriggerServerEvent('skyline:updateCoords', formattedCoords)
				end
			end
		end
	end)
end

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, 289) then
			if IsInputDisabled(0) and not isDead and not SKYLINE.UI.Menu.IsOpen('default', 'SKYLINE_core', 'inventory') then
				SKYLINE.ShowInventory()
			end
		end
	end
end)--]]

-- Pickups
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local playerCoords, letSleep = GetEntityCoords(playerPed), true
		local closestPlayer, closestDistance = SKYLINE.Game.GetClosestPlayer(playerCoords)

		for pickupId,pickup in pairs(pickups) do
			local distance = #(playerCoords - pickup.coords)

			if distance < 5 then
				local label = pickup.label
				letSleep = false

				if distance < 1 then
					if IsControlJustReleased(0, 38) then
						if IsPedOnFoot(playerPed) and (closestDistance == -1 or closestDistance > 3) and not pickup.inRange then
							pickup.inRange = true

							local dict, anim = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor'
							SKYLINE.Streaming.RequestAnimDict(dict)
							TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
							Citizen.Wait(1000)

							TriggerServerEvent('skyline:onPickup', pickupId)
							PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
						end
					end

					label = ('%s~n~%s'):format(label, "")
				end

				SKYLINE.Game.Utils.DrawText3D({
					x = pickup.coords.x,
					y = pickup.coords.y,
					z = pickup.coords.z + 0.25
				}, label, 1.2, 1)
			elseif pickup.inRange then
				pickup.inRange = false
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)
