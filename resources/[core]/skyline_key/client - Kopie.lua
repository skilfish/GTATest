
-- error when both menus are enabled
if (Config.useContextMenu and Config.useNativeUI) then
	print("^1[ERROR] You can use only one menu or no menu at all. You cannot use both menus."
		.. "\nMake sure to set at least one to false in the config and to edit the fxmanifest accordingly!")
end

local keymakers = {}

local lockNotif = nil
local createNewKeyNotif = nil

local LockStatus = {
	Unlocked = 1,
	Locked = 2
}

local CB = exports["skyline_callbacks"]

local menuPoolNativeUI
local keymakerMenuNativeUI
local keyInvMenuNativeUI
if (Config.useNativeUI) then
	if (NativeUI == nil) then
		print("^1[ERROR] NativeUI was not properly initialized! Make sure to install NativeUI and start it before this resource!")
	end

	menuPoolNativeUI = NativeUI.CreatePool()
	keymakerMenuNativeUI = NativeUI.CreateMenu(Config.Strings.keymakerTitle, Config.Strings.keymakerSub)
	keyInvMenuNativeUI = NativeUI.CreateMenu(Config.Strings.keyInvTitle, Config.Strings.keyInvSub)
end

local isAtKeymaker = false
local menuOpen = false

-- create client side peds
Citizen.CreateThread(function()
	for i, keymaker in ipairs(Config.Keymakers) do
		RequestModel(keymaker.model) 
		while not HasModelLoaded(keymaker.model) do
			Citizen.Wait(0)
		end
		local ped = CreatePed(0, keymaker.model, keymaker.pos.x, keymaker.pos.y, keymaker.pos.z, keymaker.pos.w, false, true)
        
		SetBlockingOfNonTemporaryEvents(ped, true)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)

		table.insert(keymakers, ped)

		-- add blip
        local blip = AddBlipForCoord(keymaker.pos.x, keymaker.pos.y, keymaker.pos.z)

        SetBlipSprite(blip, 134)
        SetBlipColour(blip, 32)
        
        SetBlipScale(blip, 0.9)
        SetBlipDisplay(blip, 2)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Config.Strings.keymaker)
        EndTextCommandSetBlipName(blip)
	end
end)

-- main loop
Citizen.CreateThread(function()
	while (true) do
		Citizen.Wait(0)

		if (Config.useNativeUI) then
			if (menuOpen) then
				menuPoolNativeUI:ProcessMenus()
			end

			if (isAtKeymaker) then
				if (not menuOpen) then
					ShowHelpText(Config.Strings.helpText)
				end

				if (IsControlJustPressed(0, 51)) then
					if (menuPoolNativeUI:IsAnyMenuOpen()) then
						menuPoolNativeUI:CloseAllMenus()
						menuOpen = false
					else
						GenerateKeymakerMenuNativeUI()
						keymakerMenuNativeUI:Visible(true)
						menuOpen = true
					end
				end
			end

			if (Config.keyMenuKey and IsControlJustPressed(0, Config.keyMenuKey)) then
				if (menuPoolNativeUI:IsAnyMenuOpen()) then
					menuPoolNativeUI:CloseAllMenus()
					menuOpen = false
				else
					GenerateKeyInventoryNativeUI()
					keyInvMenuNativeUI:Visible(true)
					menuOpen = true
				end
			end
		end

		-- lock vehicle with key
		if (Config.lockKey and IsControlJustPressed(0, Config.lockKey)) then
			local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 10.0)
			if (DoesEntityExist(vehicle) and IsVehicleOrKeyOwner(vehicle)) then
				ToggleLock(vehicle, GetVehicleDoorLockStatus(vehicle) ~= LockStatus.Locked)
			end
		end
	end
end)



-- ContextMenu
if (Config.useContextMenu) then
	local menuPool = MenuPool()
	menuPool.OnOpenMenu = function(screenPosition, hitSomething, worldPosition, hitEntity, normalDirection)
		local playerPos = GetEntityCoords(PlayerPedId())
		if (Vdist(worldPosition.x, worldPosition.y, worldPosition.z, playerPos.x, playerPos.y, playerPos.z) < Config.maxDistance) then
			CreateMenu(screenPosition, hitEntity)
		end
	end

	function CreateMenu(screenPosition, hitEntity)
		menuPool:Reset()

		if (hitEntity) then
			if (hitEntity == PlayerPedId()) then
				local vehicleData = GetPlayerVehicleData()
				local ownedKeys = GetPlayerKeys()
				
				menuPool:Reset()
				
				local playerMenu = menuPool:AddMenu()
				playerMenu.alpha = 150

				-- owned vehicles
				local ownVehMenu, ownVehMenuItem = menuPool:AddSubmenu(playerMenu, Config.Strings.CM.masterKeysTitle)
				if (#vehicleData > Config.subCategoryThreshhold) then
					local classes = {}
					for i, vehicle in ipairs(vehicleData) do
						local plate = vehicle[1]
						local model = GetLabelText(GetDisplayNameFromVehicleModel(vehicle[2]))
						if (model == "NULL") then
							model = GetDisplayNameFromVehicleModel(vehicle[2])
						end

						local class = GetVehicleClassFromName(vehicle[2])
						class = Config.VehicleClasses[class + 1]
						if (classes[class] == nil) then
							classes[class] = {}
						end
						table.insert(classes[class], model .. " " .. plate)
					end

					for class, names in pairs(classes) do
						local classMenu = menuPool:AddSubmenu(ownVehMenu, class)
						for i, name in ipairs(names) do
							local item = classMenu:AddItem(name)
						end
					end
				else
					for i, vehicle in ipairs(vehicleData) do
						local plate = vehicle[1]
						local model = GetLabelText(GetDisplayNameFromVehicleModel(vehicle[2]))
						if (model == "NULL") then
							model = GetDisplayNameFromVehicleModel(vehicle[2])
						end
						
						local item = ownVehMenu:AddItem(model .. " " .. plate)
					end
				end
				
				-- owned keys
				local ownKeyMenu, ownKeyMenuItem = menuPool:AddSubmenu(playerMenu, Config.Strings.CM.keysTitle)
				if (#ownedKeys > Config.subCategoryThreshhold) then
					local classes = {}
					for i, key in ipairs(ownedKeys) do
						local model = GetLabelText(GetDisplayNameFromVehicleModel(key.model))
						if (model == "NULL") then
							model = GetDisplayNameFromVehicleModel(key.model)
						end

						local class = GetVehicleClassFromName(key.model)
						class = Config.VehicleClasses[class + 1]
						if (classes[class] == nil) then
							classes[class] = {}
						end
						table.insert(classes[class], { model .. " " .. key.plate, "x" .. key.count })
					end

					for class, keys in pairs(classes) do
						local classMenu = menuPool:AddSubmenu(ownKeyMenu, class)
						for i, key in ipairs(keys) do
							local item = classMenu:AddItem(key[1])
							item.rightText = Text(key[2])
						end
					end
				else
					for i, key in ipairs(ownedKeys) do
						local model = GetLabelText(GetDisplayNameFromVehicleModel(key.model))
						if (model == "NULL") then
							model = GetDisplayNameFromVehicleModel(key.model)
						end

						local item = ownKeyMenu:AddItem(model .. " " .. key.plate)
						item.rightText = Text("x" .. key.count)
					end
				end

				playerMenu:SetPosition(screenPosition)
				playerMenu:Visible(true)
			elseif (IsEntityAKeymaker(hitEntity)) then
				local vehicleData = GetPlayerVehicleData()
				local ownedKeys = GetPlayerKeys()
				
				menuPool:Reset()
				
				local keymakerMenu = menuPool:AddMenu()
				keymakerMenu.alpha = 150
				
				local createKeyMenu, createKeyMenuItem = menuPool:AddSubmenu(keymakerMenu, Config.Strings.CM.createKeyTitle)
				if (#vehicleData > Config.subCategoryThreshhold) then
					local classes = {}
					for i, vehicle in ipairs(vehicleData) do
						local plate = vehicle[1]
						local model = GetLabelText(GetDisplayNameFromVehicleModel(vehicle[2]))
						if (model == "NULL") then
							model = GetDisplayNameFromVehicleModel(vehicle[2])
						end
						local keyCount = GetKeyCount(plate, ownedKeys)

						local class = GetVehicleClassFromName(vehicle[2])
						class = Config.VehicleClasses[class + 1]
						if (classes[class] == nil) then
							classes[class] = {}
						end
						table.insert(classes[class], { model .. " " .. plate, "x" .. keyCount, plate, vehicle[2] })
					end

					for class, keys in pairs(classes) do
						local classMenu = menuPool:AddSubmenu(createKeyMenu, class)
						for i, key in ipairs(keys) do
							local keyItem = classMenu:AddItem(key[1])
							keyItem.rightText = Text(key[2])
							keyItem.OnClick = function()
								if (not TableContains(Config.modelBlacklist, key[4])) then
									local result = CB:Trigger("VKC:createNewKey", key[3], 1)
									if (type(result) == "boolean" and result == true) then
										Notification(string.format(Config.Strings.createSuccess, key[1]) , 1)

										local oldCount = keyItem.rightText.title:gsub("x", "")
										keyItem.rightText.title = "x" .. tostring(tonumber(oldCount) + 1)
									elseif (type(result) == "string" and result == "noMoney") then
										Notification(string.format(Config.Strings.createNoMoney, key[1]) , 0)
									else
										Notification(string.format(Config.Strings.createFailed, key[1]) , 0)
									end
								else
									Notification(string.format(Config.Strings.createFailed, key[1]) , 0)
								end
							end
						end
					end
				else
					for i, vehicle in ipairs(vehicleData) do
						local plate = vehicle[1]
						local model = GetLabelText(GetDisplayNameFromVehicleModel(vehicle[2]))
						if (model == "NULL") then
							model = GetDisplayNameFromVehicleModel(vehicle[2])
						end
						local keyCount = GetKeyCount(plate, ownedKeys)

						local keyItem = createKeyMenu:AddItem(model .. " " .. plate)
						keyItem.rightText = Text("x" .. tostring(keyCount))
						keyItem.OnClick = function()
							if (not TableContains(Config.modelBlacklist, vehicle[2])) then
								local result = CB:Trigger("VKC:createNewKey", plate, 1)
								if (type(result) == "boolean" and result == true) then
									Notification(string.format(Config.Strings.createSuccess, model .. " " .. plate) , 1)

									local oldCount = keyItem.rightText.title:gsub("x", "")
									keyItem.rightText.title = "x" .. tostring(tonumber(oldCount) + 1)
								elseif (type(result) == "string" and result == "noMoney") then
									Notification(string.format(Config.Strings.createNoMoney, model .. " " .. plate) , 0)
								else
									Notification(string.format(Config.Strings.createFailed, model .. " " .. plate) , 0)
								end
							else
								Notification(string.format(Config.Strings.createFailed, model .. " " .. plate) , 0)
							end
						end
					end
				end
				
				local invalidateKeyMenu, invalidateKeyMenuItem = menuPool:AddSubmenu(keymakerMenu, Config.Strings.CM.invalKeyTitle)
				if (#vehicleData > Config.subCategoryThreshhold) then
					local classes = {}
					for i, vehicle in ipairs(vehicleData) do
						local plate = vehicle[1]
						local model = GetLabelText(GetDisplayNameFromVehicleModel(vehicle[2]))
						if (model == "NULL") then
							model = GetDisplayNameFromVehicleModel(vehicle[2])
						end

						local class = GetVehicleClassFromName(vehicle[2])
						class = Config.VehicleClasses[class + 1]
						if (classes[class] == nil) then
							classes[class] = {}
						end
						table.insert(classes[class], { model .. " " .. plate, plate, vehicle[2] })
					end

					for class, keys in pairs(classes) do
						local classMenu = menuPool:AddSubmenu(invalidateKeyMenu, class)
						for i, key in ipairs(keys) do
							local item = classMenu:AddItem(key[1])
							item.closeMenuOnClick = true
							item.OnClick = function()
								if (not TableContains(Config.modelBlacklist, key[3])) then
									local result = CB:Trigger("VKC:removeAllKeys", key[2])
									if (type(result) == "boolean" and result == true) then
										Notification(string.format(Config.Strings.deleteKeys, key[1]) , 1)
									elseif (type(result) == "string" and result == "noMoney") then
										Notification(string.format(Config.Strings.removeNoMoney, key[1]) , 0)
									else
										Notification(string.format(Config.Strings.removeFailed, key[1]) , 0)
									end
								else
									Notification(string.format(Config.Strings.removeFailed, key[1]) , 0)
								end
							end
						end
					end
				else
					for i, vehicle in ipairs(vehicleData) do
						local plate = vehicle[1]
						local model = GetLabelText(GetDisplayNameFromVehicleModel(vehicle[2]))
						if (model == "NULL") then
							model = GetDisplayNameFromVehicleModel(vehicle[2])
						end

						local item = invalidateKeyMenu:AddItem(model .. " " .. plate)
						item.closeMenuOnClick = true
						item.OnClick = function()
							if (not TableContains(Config.modelBlacklist, vehicle[2])) then
								local result = CB:Trigger("VKC:removeAllKeys", plate)
								if (type(result) == "boolean" and result == true) then
									Notification(string.format(Config.Strings.deleteKeys, model .. " " .. plate) , 1)
								elseif (type(result) == "string" and result == "noMoney") then
									Notification(string.format(Config.Strings.removeNoMoney, model .. " " .. plate) , 0)
								else
									Notification(string.format(Config.Strings.removeFailed, model .. " " .. plate) , 0)
								end
							else
								Notification(string.format(Config.Strings.removeFailed, model .. " " .. plate), 0)
							end
						end
					end
				end

				keymakerMenu:SetPosition(screenPosition)
				keymakerMenu:Visible(true)
			elseif (IsEntityAPed(hitEntity) and IsPedAPlayer(hitEntity)) then
				local vehicleData = GetPlayerVehicleData()
				local ownedKeys = GetPlayerKeys()
				
				menuPool:Reset()
				
				local interactMenu = menuPool:AddMenu()
				interactMenu.alpha = 150
				
				local giveMasterKeyMenu, giveMasterKeyMenuItem = menuPool:AddSubmenu(interactMenu, Config.Strings.CM.giveMasterKey)
				if (#vehicleData > Config.subCategoryThreshhold) then
					local classes = {}
					for i, vehicle in ipairs(vehicleData) do
						local plate = vehicle[1]
						local model = GetLabelText(GetDisplayNameFromVehicleModel(vehicle[2]))
						if (model == "NULL") then
							model = GetDisplayNameFromVehicleModel(vehicle[2])
						end

						local class = GetVehicleClassFromName(vehicle[2])
						class = Config.VehicleClasses[class + 1]
						if (classes[class] == nil) then
							classes[class] = {}
						end
						table.insert(classes[class], { model .. " " .. plate, plate, model })
					end

					for class, keys in pairs(classes) do
						local classMenu = menuPool:AddSubmenu(giveMasterKeyMenu, class)
						for i, key in ipairs(keys) do
							
							if (Config.enableGiveAwayMasterKey) then
								local masterKeyConfirmMenu, masterKeyConfirmMenuItem = menuPool:AddSubmenu(classMenu, key[1])

								local textItem = masterKeyConfirmMenu:AddTextItem(Config.Strings.CM.safetyConfirm)
								local confirmItem = masterKeyConfirmMenu:AddItem(Config.Strings.CM.safetyConfirmYes)

								confirmItem.OnClick = function()
									if (not TableContains(Config.modelBlacklist, key[3])) then
										local players = GetActivePlayers()
										for i, player in ipairs(players) do
											if (GetPlayerPed(player) == hitEntity) then
												local success = CB:Trigger("VKC:giveMasterKeyToPlayer", key[2], GetPlayerServerId(player))

												if (success) then
													Notification(string.format(Config.Strings.giveMasterSuccess, key[1]) , 1)

													menuPool:CloseAllMenus()
												else
													Notification(string.format(Config.Strings.giveMasterFailed, key[1]) , 0)
												end

												break
											end
										end
									else
										Notification(string.format(Config.Strings.giveMasterFailed, key[1]) , 0)
									end
								end
							else
								local masterKeyItem = classMenu:AddItem(key[1])
							end
						end
					end
				else
					for i, vehicle in ipairs(vehicleData) do
						local plate = vehicle[1]
						local model = GetLabelText(GetDisplayNameFromVehicleModel(vehicle[2]))
						if (model == "NULL") then
							model = GetDisplayNameFromVehicleModel(vehicle[2])
						end
						
						if (Config.enableGiveAwayMasterKey) then
							local masterKeyConfirmMenu, masterKeyConfirmMenuItem = menuPool:AddSubmenu(giveMasterKeyMenu, model .. " " .. plate)

							local textItem = masterKeyConfirmMenu:AddTextItem(Config.Strings.CM.safetyConfirm)
							local confirmItem = masterKeyConfirmMenu:AddItem(Config.Strings.CM.safetyConfirmYes)
							confirmItem.closeMenuOnClick = true

							confirmItem.OnClick = function()
								if (not TableContains(Config.modelBlacklist, vehicle[2])) then
									local players = GetActivePlayers()
									for i, player in ipairs(players) do
										if (GetPlayerPed(player) == hitEntity) then
											local success = CB:Trigger("VKC:giveMasterKeyToPlayer", plate, GetPlayerServerId(player))
									
											if (success) then
												Notification(string.format(Config.Strings.giveMasterSuccess, model .. " " .. plate) , 1)
											else
												Notification(string.format(Config.Strings.giveMasterFailed, model .. " " .. plate) , 0)
											end

											break
										end
									end
								else
									Notification(string.format(Config.Strings.giveMasterFailed, model .. " " .. plate) , 0)
								end
							end
						else
							local masterKeyItem = giveMasterKeyMenu:AddItem(model .. " " .. plate)
						end
					end
				end

				local giveKeyMenu, giveKeyMenuItem = menuPool:AddSubmenu(interactMenu, Config.Strings.CM.giveKey)
				if (#ownedKeys > Config.subCategoryThreshhold) then
					local classes = {}
					for i, key in ipairs(ownedKeys) do
						local model = GetLabelText(GetDisplayNameFromVehicleModel(key.model))
						if (model == "NULL") then
							model = GetDisplayNameFromVehicleModel(key.model)
						end

						local class = GetVehicleClassFromName(key.model)
						class = Config.VehicleClasses[class + 1]
						if (classes[class] == nil) then
							classes[class] = {}
						end
						table.insert(classes[class], { model .. " " .. plate, "x" .. keyCount, plate, key.model })
					end

					for class, keys in pairs(classes) do
						local classMenu = menuPool:AddSubmenu(giveKeyMenu, class)
						for i, key in ipairs(keys) do
							local keyItem = classMenu:AddItem(key[1])
							keyItem.rightText = Text(key[2])
							keyItem.closeMenuOnClick = true
							keyItem.OnClick = function()
								if (not TableContains(Config.modelBlacklist, key[4])) then
									local players = GetActivePlayers()
									for i, player in ipairs(players) do
										if (GetPlayerPed(player) == hitEntity) then
											local success = CB:Trigger("VKC:giveKeyToPlayer", key[3], GetPlayerServerId(player))
											if (success) then
												Notification(string.format(Config.Strings.giveSuccess, key[1]) , 1)
											else
												Notification(string.format(Config.Strings.giveFailed, key[1]) , 0)
											end

											break
										end
									end
								else
									Notification(string.format(Config.Strings.giveFailed, key[1]) , 0)
								end
							end
						end
					end
				else
					for i, key in ipairs(ownedKeys) do
						local model = GetLabelText(GetDisplayNameFromVehicleModel(key.model))
						if (model == "NULL") then
							model = GetDisplayNameFromVehicleModel(key.model)
						end

						local keyItem = giveKeyMenu:AddItem(model .. " " .. key.plate)
						keyItem.rightText = Text("x" .. key.count)
						keyItem.closeMenuOnClick = true
						keyItem.OnClick = function()
							if (not TableContains(Config.modelBlacklist, key.model)) then
								local players = GetActivePlayers()
								for i, player in ipairs(players) do
									if (GetPlayerPed(player) == hitEntity) then
										local success = CB:Trigger("VKC:giveKeyToPlayer", key.plate, GetPlayerServerId(player))
										if (success) then
											Notification(string.format(Config.Strings.giveSuccess, model .. " " .. key.plate) , 1)
										else
											Notification(string.format(Config.Strings.giveFailed, model .. " " .. key.plate) , 0)
										end

										break
									end
								end
							else
								Notification(string.format(Config.Strings.giveFailed, model .. " " .. key.plate) , 0)
							end
						end
					end
				end

				interactMenu:SetPosition(screenPosition)
				interactMenu:Visible(true)
			end
		end
	end

	function IsEntityAKeymaker(entity)
		for i, keymaker in ipairs(keymakers) do
			if (entity == keymaker) then
				return true
			end
		end

		return false
	end
end



-- NativeUI
function GenerateKeymakerMenuNativeUI()
	keymakerMenuNativeUI:Clear()
	
	local vehicleData = GetPlayerVehicleData()
	local ownedKeys = GetPlayerKeys()
	
	keymakerMenuNativeUI = NativeUI.CreateMenu(Config.Strings.NUI.keymakerMenuTitle, Config.Strings.NUI.keymakerMenuSub)
	menuPoolNativeUI:Add(keymakerMenuNativeUI)
	
	local submenuCreateKey = menuPoolNativeUI:AddSubMenu(keymakerMenuNativeUI, Config.Strings.NUI.createKeyTitle, Config.Strings.NUI.createKeyDesc)
	submenuCreateKey.ParentItem:RightLabel(">")
	submenuCreateKey.Subtitle.Text._Text = "~b~" .. Config.Strings.NUI.createKeyTitle
	for i, vehicle in ipairs(vehicleData) do
		local plate = vehicle[1]
		local model = GetLabelText(GetDisplayNameFromVehicleModel(vehicle[2]))
		if (model == "NULL") then
			model = GetDisplayNameFromVehicleModel(vehicle[2])
		end
		local keyCount = GetKeyCount(plate, ownedKeys)

		local vehItem = NativeUI.CreateItem(model .. " " .. plate, string.format(Config.Strings.NUI.createVehicleKey, model, plate))
		vehItem:RightLabel("x" .. tostring(keyCount))

		submenuCreateKey:AddItem(vehItem)
	end
	submenuCreateKey.OnItemSelect = function(menu, item, index)
		local model = GetLabelText(GetDisplayNameFromVehicleModel(vehicleData[index][2]))
		if (model == "NULL") then
			model = GetDisplayNameFromVehicleModel(vehicleData[index][2])
		end

		if (not TableContains(Config.modelBlacklist, vehicleData[index][2])) then
			Citizen.CreateThread(function()
				local result = CB:Trigger("VKC:createNewKey", vehicleData[index][1], 1)
				if (type(result) == "boolean" and result == true) then
					Notification(string.format(Config.Strings.createSuccess, model) , 1)

					if (submenuCreateKey:Visible()) then
						local oldCount = item.Label.Text._Text:gsub("x", "")
						item:RightLabel("x" .. tostring(tonumber(oldCount) + 1))
					end
				elseif (type(result) == "string" and result == "noMoney") then
					Notification(string.format(Config.Strings.createNoMoney, model) , 0)
				else
					Notification(string.format(Config.Strings.createFailed, model) , 0)
				end
			end)
		else
			Notification(string.format(Config.Strings.createFailed, model) , 0)
		end
	end

	local submenuInvalidateKey = menuPoolNativeUI:AddSubMenu(keymakerMenuNativeUI, Config.Strings.NUI.invalKeyTitle, Config.Strings.NUI.invalKeyDesc)
	submenuInvalidateKey.ParentItem:RightLabel(">")
	submenuInvalidateKey.Subtitle.Text._Text = "~b~" .. Config.Strings.NUI.invalKeyTitle
	for i, vehicle in ipairs(vehicleData) do
		local plate = vehicle[1]
		local model = GetLabelText(GetDisplayNameFromVehicleModel(vehicle[2]))
		if (model == "NULL") then
			model = GetDisplayNameFromVehicleModel(vehicle[2])
		end

		local keyItem = NativeUI.CreateItem(model .. " " .. plate, string.format(Config.Strings.NUI.invalVehicleKey, model, plate))
		submenuInvalidateKey:AddItem(keyItem)
	end
	submenuInvalidateKey.OnItemSelect = function(menu, item, index)
		local model = GetLabelText(GetDisplayNameFromVehicleModel(vehicleData[index][2]))
		if (model == "NULL") then
			model = GetDisplayNameFromVehicleModel(vehicleData[index][2])
		end

		if (not TableContains(Config.modelBlacklist, vehicleData[index][2])) then
			Citizen.CreateThread(function()
				local result = CB:Trigger("VKC:removeAllKeys", vehicleData[index][1])
			
				if (type(result) == "boolean" and result == true) then
					Notification(string.format(Config.Strings.deleteKeys, model) , 1)
				elseif (type(result) == "string" and result == "noMoney") then
					Notification(string.format(Config.Strings.removeNoMoney, model), 0)
				else
					Notification(string.format(Config.Strings.removeFailed, model), 0)
				end
			end)
		else
			Notification(string.format(Config.Strings.removeFailed, model), 0)
		end
	end
	
	keymakerMenuNativeUI.OnMenuClosed = function(menu)
		menuOpen = false
	end

	menuPoolNativeUI:ControlDisablingEnabled(false)
	menuPoolNativeUI:MouseControlsEnabled(false)

	menuPoolNativeUI:RefreshIndex()
end

function GenerateKeyInventoryNativeUI()
	keyInvMenuNativeUI:Clear()
	
	local vehicleData = GetPlayerVehicleData()
	local ownedKeys = GetPlayerKeys()
	
	keyInvMenuNativeUI = NativeUI.CreateMenu(Config.Strings.NUI.keyInventoryTitle, Config.Strings.NUI.keyInventorySub)
	menuPoolNativeUI:Add(keyInvMenuNativeUI)
	
	local submenuShowMasterKeys = menuPoolNativeUI:AddSubMenu(keyInvMenuNativeUI, Config.Strings.NUI.masterKeysTitle, Config.Strings.NUI.masterKeysDesc)
	submenuShowMasterKeys.ParentItem:RightLabel(">")
	submenuShowMasterKeys.Subtitle.Text._Text = "~b~" .. Config.Strings.NUI.masterKeysTitle
	for i, vehicle in ipairs(vehicleData) do
		local plate = vehicle[1]
		local model = GetLabelText(GetDisplayNameFromVehicleModel(vehicle[2]))
		if (model == "NULL") then
			model = GetDisplayNameFromVehicleModel(vehicle[2])
		end
		
		if (Config.enableGiveAwayMasterKey) then
			local submenuMasterKey = menuPoolNativeUI:AddSubMenu(submenuShowMasterKeys, model .. " " .. plate, Config.Strings.NUI.giveMasterKeyDesc)
			submenuMasterKey.ParentItem:RightLabel(">")
			local giveItem = NativeUI.CreateItem(Config.Strings.NUI.giveMasterKeyTitle, Config.Strings.NUI.giveMasterKeyDesc)
			submenuMasterKey:AddItem(giveItem)

			submenuMasterKey.OnItemSelect = function(menu, item, index)
				if (item == giveItem) then
					if (not TableContains(Config.modelBlacklist, vehicle[2])) then
						Citizen.CreateThread(function()
							local player = GetClosestPlayer(2.0)
							if (player) then
								local success = CB:Trigger("VKC:giveMasterKeyToPlayer", plate, GetPlayerServerId(player))
								if (success) then
									Notification(string.format(Config.Strings.giveMasterSuccess, model .. " " .. plate) , 1)

									menuPoolNativeUI:CloseAllMenus()
								else
									Notification(string.format(Config.Strings.giveMasterFailed, model .. " " .. plate), 0)
								end
							else
								Notification(string.format(Config.Strings.giveMasterFailed, model .. " " .. plate) , 0)
							end
						end)
					else
						Notification(string.format(Config.Strings.giveMasterFailed, model .. " " .. plate) , 0)
					end
				end
			end
		else
			local vehItem = NativeUI.CreateItem(model .. " " .. plate, "")
			submenuShowMasterKeys:AddItem(vehItem)
		end
	end
	
	local submenuShowKeys = menuPoolNativeUI:AddSubMenu(keyInvMenuNativeUI, Config.Strings.NUI.keysTitle, Config.Strings.NUI.keysDesc)
	submenuShowKeys.ParentItem:RightLabel(">")
	submenuShowKeys.Subtitle.Text._Text = "~b~" .. Config.Strings.NUI.keysTitle
	for i, key in ipairs(ownedKeys) do
		local model = GetLabelText(GetDisplayNameFromVehicleModel(key.model))
		if (model == "NULL") then
			model = GetDisplayNameFromVehicleModel(key.model)
		end
		
		local submenuKey = menuPoolNativeUI:AddSubMenu(submenuShowKeys, model .. " " .. key.plate, "")
		submenuKey.ParentItem:RightLabel("x" .. tostring(key.count) .. " >")
		submenuKey.Subtitle.Text._Text = "~b~" .. model .. " " .. key.plate

		local giveItem = NativeUI.CreateItem(Config.Strings.NUI.giveKeyTitle, Config.Strings.NUI.giveKeyDesc)
		submenuKey:AddItem(giveItem)

		local removeItem = NativeUI.CreateItem(Config.Strings.NUI.removeKeyTitle, Config.Strings.NUI.removeKeyDesc)
		submenuKey:AddItem(removeItem)

		submenuKey.OnItemSelect = function(menu, item, index)
			if (item == giveItem) then
				if (not TableContains(Config.modelBlacklist, key.model)) then
					Citizen.CreateThread(function()
						local player = GetClosestPlayer(2.0)
						if (player) then
							local success = CB:Trigger("VKC:giveKeyToPlayer", key.plate, GetPlayerServerId(player))
							if (success) then
								Notification(string.format(Config.Strings.giveSuccess, key.plate) , 1)
							else
								Notification(string.format(Config.Strings.giveFailed, key.plate) , 0)
							end
						else
							Notification(string.format(Config.Strings.giveFailed, key.plate) , 0)
						end
					end)
				else
					Notification(string.format(Config.Strings.giveFailed, key.plate) , 0)
				end
			elseif (item == removeItem) then
				if (not TableContains(Config.modelBlacklist, key.model)) then
					Citizen.CreateThread(function()
						local success = CB:Trigger("VKC:removeKey", key.plate, 1)
						if (success) then
							Notification(string.format(Config.Strings.removeSuccess, key.plate) , 1)
						
							if (submenuShowKeys:Visible() or submenuKey:Visible()) then
								local oldCount = submenuKey.ParentItem.Label.Text._Text:gsub("x", "")
								oldCount = oldCount:gsub(" >", "")
								submenuKey.ParentItem:RightLabel("x" .. tostring(tonumber(oldCount) - 1) .. " >")
							end
						else
							Notification(string.format(Config.Strings.removeFailed, key.plate) , 0)
						end
					end)
				else
					Notification(string.format(Config.Strings.removeFailed, key.plate) , 0)
				end
			end
		end
	end

	keyInvMenuNativeUI.OnMenuClosed = function(menu)
		menuOpen = false
	end

	menuPoolNativeUI:ControlDisablingEnabled(false)
	menuPoolNativeUI:MouseControlsEnabled(false)

	menuPoolNativeUI:RefreshIndex()
end

if (Config.useNativeUI) then
	Citizen.CreateThread(function()
		while (true) do
			Citizen.Wait(250)
			
			isAtKeymaker = false

			local pos = GetEntityCoords(PlayerPedId())
			for i, keymaker in ipairs(Config.Keymakers) do
				if (Vdist(pos.x, pos.y, pos.z, keymaker.pos.x, keymaker.pos.y, keymaker.pos.z) < 2.0) then
					isAtKeymaker = true
					break
				end
			end
		end
	end)
	
	if (Config.keyMenuCommand) then
		RegisterCommand(Config.keyMenuCommand, function(source, args, raw)
			if (menuPoolNativeUI:IsAnyMenuOpen()) then
				menuPoolNativeUI:CloseAllMenus()
			end

			GenerateKeyInventoryNativeUI()
			keyInvMenuNativeUI:Visible(true)
			menuOpen = true
		end, false)
	end
end



-- lock vehicle
if (Config.lockCommand) then
	RegisterCommand(Config.lockCommand, function(source, args, raw)
		local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 10.0)
		if (DoesEntityExist(vehicle) and IsVehicleOrKeyOwner(vehicle)) then
			ToggleLock(vehicle, GetVehicleDoorLockStatus(vehicle) ~= LockStatus.Locked)
		end
	end, false)
end

function ToggleLock(vehicle, lock)
	local lockStatus = GetVehicleDoorLockStatus(vehicle)

	if (NetworkHasControlOfEntity(vehicle)) then
		ToggleLockOnVehicle(vehicle, lock)
	else
		TriggerServerEvent("VKC:toggleLockNet", NetworkGetNetworkIdFromEntity(vehicle), lock)
	end

	-- play sound
	TriggerServerEvent("VKC:playDoorLockSoundNet", NetworkGetNetworkIdFromEntity(vehicle), lock)

	-- play remote animation
	if (not IsPedInAnyVehicle(PlayerPedId(), false)) then
		PlayRemoteAnimation()
	end

	-- show notification
	if lockStatus == LockStatus.Locked then 
		Notification(Config.Strings.unlockNotif , 1)
	else 
		Notification(Config.Strings.lockNotif , 0)
	end 

	--lockNotif = Notification(lockStatus == LockStatus.Locked and Config.Strings.unlockNotif or Config.Strings.lockNotif)
end

function ToggleLockOnVehicle(vehicle, lock)
	if (lock) then
		SetVehicleDoorsShut(vehicle, false)
		SetVehicleDoorsLocked(vehicle, LockStatus.Locked)
	else
		SetVehicleDoorsLocked(vehicle, LockStatus.Unlocked)
	end
end

function PlayDoorLockSound(vehicle, lock)
	if (lock) then
		PlayVehicleDoorCloseSound(vehicle, 0)
	else
		PlayVehicleDoorOpenSound(vehicle, 0)
	end
end

if (Config.lockCommand or Config.lockKey) then
	RegisterNetEvent("VKC:toggleLockOnPlayer")
	AddEventHandler("VKC:toggleLockOnPlayer", function(vehicleNetId, unlocked)
		local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
		if (DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle)) then
			local lockStatus = GetVehicleDoorLockStatus(vehicle)
			ToggleLockOnVehicle(vehicle, unlocked)
		end
	end)

	RegisterNetEvent("VKC:playDoorLockSound")
	AddEventHandler("VKC:playDoorLockSound", function(vehicleNetId, lock)
		local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
		if (DoesEntityExist(vehicle)) then
			PlayDoorLockSound(vehicle, lock)
		end
	end)
end



RegisterNetEvent("VKC:giveKeyNotif")
AddEventHandler("VKC:giveKeyNotif", function(plate)
	Notification(string.format(Config.Strings.giveSuccessPly, plate))
end)

RegisterNetEvent("VKC:giveMasterKeyNotif")
AddEventHandler("VKC:giveMasterKeyNotif", function(plate)
	Notification(string.format(Config.Strings.giveMasterSuccessPly, plate))
end)



function IsVehicleOwner(vehicle)
	if (not DoesEntityExist(vehicle)) then
		print("^1[ERROR] Parameter \"vehicle\" was nil or vehicle did not exist while triggering export \"IsVehicleOwner\"!")
		return
	end

	return CB:Trigger("VKC:isVehicleOwner", GetVehicleNumberPlateText(vehicle))
end

function IsKeyOwner(vehicle)
	if (not DoesEntityExist(vehicle)) then
		print("^1[ERROR] Parameter \"vehicle\" was nil or vehicle did not exist while triggering export \"IsKeyOwner\"!")
		return
	end

	return CB:Trigger("VKC:isKeyOwner", GetVehicleNumberPlateText(vehicle), GetEntityModel(vehicle))
end

function IsVehicleOrKeyOwner(vehicle)
	if (not DoesEntityExist(vehicle)) then
		print("^1[ERROR] Parameter \"vehicle\" was nil or vehicle did not exist while triggering export \"IsVehicleOrKeyOwner\"!")
		return
	end

	return CB:Trigger("VKC:isVehicleOrKeyOwner", GetVehicleNumberPlateText(vehicle), GetEntityModel(vehicle))
end

function GetPlayerKeys()
	return CB:Trigger("VKC:getPlayerKeys")
end

function GetPlayerVehicleData()
	return CB:Trigger("VKC:getPlayerVehicleData")
end



-- play lock animation
function PlayRemoteAnimation()
    Citizen.CreateThread(function()
        RequestModel(keyPropHash)
        RequestAnimDict("anim@mp_player_intmenu@key_fob@")
        while (not HasModelLoaded(keyPropHash) and not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@")) do
            Citizen.Wait(0)
        end
        
        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)

        local keyObj = CreateObjectNoOffset(keyPropHash, playerPos.x, playerPos.y, playerPos.z, true, true, false)
        SetModelAsNoLongerNeeded(keyPropHash)

        local boneIndex = GetEntityBoneIndexByName(playerPed, "IK_R_Hand")
        local offset = vector3(0.08, 0.025, -0.01)
        local rotOffset = vector3(0, 70, 140)
        AttachEntityToEntity(keyObj, playerPed, boneIndex, offset.x, offset.y, offset.z, rotOffset.x, rotOffset.y, rotOffset.z, false, false, true, false, 2, true)

        TaskPlayAnim(playerPed, "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
        RemoveAnimDict("anim@mp_player_intmenu@key_fob@")

        Citizen.Wait(1500)

        DeleteEntity(keyObj)
    end)
end

-- show text in upper left corner
function ShowHelpText(text)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayHelp(0, false, true, -1)
end

-- displays a notification and returns its handle
function Notification(text , type)
	if type == 0 then 
		TriggerEvent("skyline_notify:Alert", "SCHLÜSSEL" , text , 4000 , "error")
	else 
		TriggerEvent("skyline_notify:Alert","SCHLÜSSEL" , text, 4000 , "success")
	end 
end

-- checks, if a table contains a value
function TableContains(t, v)
	for i, value in ipairs(t) do
		if (value == v) then
			return true
		end
	end

	return false
end

-- get key count
function GetKeyCount(plate, keyArray)
	for i, key in ipairs(keyArray) do
		if (plate == key.plate) then
			return key.count
		end
	end

	return 0
end

-- get all players
function GetAllPlayers()
    local players = {}

	for k, v in ipairs(GetActivePlayers()) do
        table.insert(players, v)
	end

    return players
end

-- get the closest player
function GetClosestPlayer(maxRange)
    local playerPed     = PlayerPedId()
    local players       = GetAllPlayers()

    local playerCoords  = GetEntityCoords(playerPed)

    local closestDistance   = maxRange
    local closestPlayer     = nil

    for i=1, #players, 1 do
        local coords    = GetEntityCoords(GetPlayerPed(players[i]))
        local dist      = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, coords.x, coords.y, coords.z)
        if (dist < closestDistance and players[i] ~= PlayerId()) then
            closestDistance = dist
            closestPlayer   = players[i]
        end
    end

    if (closestPlayer ~= nil and DoesEntityExist(GetPlayerPed(closestPlayer))) then
        return closestPlayer
    else
        return nil
    end
end

-- Return closest loaded vehicle entity or nil if no vehicle is found
function GetClosestVehicle(position, maxRadius)
    local vehicles       = GetAllVehicles()
    local dist           = maxRadius
    local closestVehicle = nil
    
    for i=1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local tempDist = Vdist(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, position.x, position.y, position.z)
        if (tempDist < dist) then
            dist = tempDist
            closestVehicle = vehicles[i]
        end
    end
    
    if (closestVehicle ~= nil and DoesEntityExist(closestVehicle)) then
        return closestVehicle
    else
        return nil
    end
end

-- Returns all loaded vehicles on client side
function GetAllVehicles()
    local vehicles = {}
    
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles, vehicle)
    end
    
    return vehicles
end

-- getting all vehicles
function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end

        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end
local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}
