local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

PlayerData = {}

local jailTime = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	LoadTeleporters()
end)

RegisterNetEvent("skyline:playerLoaded")
AddEventHandler("skyline:playerLoaded", function(newData)
	PlayerData = newData

	Citizen.Wait(10000)

	ESX.TriggerServerCallback("jailihrfotzen:retrieveJailTime", function(inJail, newJailTime)
		if inJail then

			jailTime = newJailTime

			JailLogin()
		end
	end)
end)

RegisterNetEvent("skyline:setJob")
AddEventHandler("skyline:setJob", function(response)
	PlayerData["job"] = response
end)

RegisterNetEvent("jailihrfotzen:openJailMenu")
AddEventHandler("jailihrfotzen:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("jailihrfotzen:jailPlayer")
AddEventHandler("jailihrfotzen:jailPlayer", function(newJailTime)
	jailTime = newJailTime

	Cutscene()
end)

RegisterNetEvent("jailihrfotzen:unJailPlayer")
AddEventHandler("jailihrfotzen:unJailPlayer", function()
	jailTime = 0

	UnJail()
end)

function JailLogin()
	local JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
	InJail()
end

function UnJail()
	InJail()

	ESX.Game.Teleport(PlayerPedId(), vector3(1846.5470, 2585.9280, 45.6720))

	ESX.TriggerServerCallback('spielerskin:getPlayerSkin', function(skin)
		TriggerEvent('skinändernduhs:loadSkin', skin)
	end)

	TriggerEvent("skyline_notify:Alert", "GEFÄGNISS" , "Du wurdest entlassen!" , 2000 , "success")
end

function InJail()

	--Jail Timer--

	TriggerEvent('skinändernduhs:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinändernduhs:loadClothes', skin, Config.Uniforms.prison_wear.male)
		else
			TriggerEvent('skinändernduhs:loadClothes', skin, Config.Uniforms.prison_wear.female)
		end
	end)


	ESX.TriggerServerCallback("jailihrfotzen:removeItems", function() end)


	Citizen.CreateThread(function()

		while jailTime > 0 do

			jailTime = jailTime - 1

			ESX.ShowNotification("Du hast ~r~" .. jailTime .. " Minuten ~w~übrig!")

			TriggerServerEvent("jailihrfotzen:updateJailTime", jailTime)

			if jailTime == 0 then
				UnJail()

				TriggerServerEvent("jailihrfotzen:updateJailTime", 0)
			end

			Citizen.Wait(60000)
		end

	end)

	--Jail Timer--

	--Prison Work--

	Citizen.CreateThread(function()

		while jailTime > 0 do
			

			local pCoords = GetEntityCoords(PlayerPedId())

			if GetDistanceBetweenCoords(pCoords, 1776.3119, 2577.8145, 45.7171, true) > 30.0 then 
				ESX.Game.Teleport(PlayerPedId(), vector3(1776.3119, 2577.8145, 45.7171), function()
					ESX.ShowNotification("~r~Du kannst das Gefägniss erst nach Ablauf deiner Haftzeit verlassen!")
				end)
			end 

			Citizen.Wait(2000)
			
		end

	end)

	--Prison Work--

end

function LoadTeleporters()
	Citizen.CreateThread(function()
		while true do
			
			local sleepThread = 500

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for p, v in pairs(Config.Teleports) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 7.5 then

					sleepThread = 5

					ESX.Game.Utils.DrawText3D(v, "[E] Open Door", 0.4)

					if DistanceCheck <= 1.0 then
						if IsControlJustPressed(0, 38) then
							TeleportPlayer(v)
						end
					end
				end
			end

			Citizen.Wait(sleepThread)

		end
	end)
end

function PackPackage(packageId)
	local Package = Config.PrisonWork["Packages"][packageId]

	LoadModel("prop_cs_cardbox_01")

	local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), Package["x"], Package["y"], Package["z"], true)

	PlaceObjectOnGroundProperly(PackageObject)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, false)

	local Packaging = true
	local StartTime = GetGameTimer()

	while Packaging do
		
		Citizen.Wait(1)

		local TimeToTake = 60000 * 1.20 -- Minutes
		local PackPercent = (GetGameTimer() - StartTime) / TimeToTake * 100

		if not IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_BUM_BIN") then
			DeleteEntity(PackageObject)

			ESX.ShowNotification("Canceled!")

			Packaging = false
		end

		if PackPercent >= 100 then

			Packaging = false

			DeliverPackage(PackageObject)

			Package["state"] = false
		else
			ESX.Game.Utils.DrawText3D(Package, "Packaging... " .. math.ceil(tonumber(PackPercent)) .. "%", 0.4)
		end
		
	end
end

function DeliverPackage(packageId)
	if DoesEntityExist(packageId) then
		AttachEntityToEntity(packageId, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

		ClearPedTasks(PlayerPedId())
	else
		return
	end

	local Packaging = true

	LoadAnim("anim@heists@box_carry@")

	while Packaging do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if not IsEntityAttachedToEntity(packageId, PlayerPedId()) then
			Packaging = false
			DeleteEntity(packageId)
		else
			local DeliverPosition = Config.PrisonWork["DeliverPackage"]
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, DeliverPosition["x"], DeliverPosition["y"], DeliverPosition["z"], true)

			ESX.Game.Utils.DrawText3D(DeliverPosition, "[E] Leave Package", 0.4)

			if DistanceCheck <= 2.0 then
				if IsControlJustPressed(0, 38) then
					DeleteEntity(packageId)
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false

					TriggerServerEvent("jailihrfotzen:prisonWorkReward")
				end
			end
		end

	end

end

function OpenJailMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'jail_prison_menu',
		{
			title    = "Knast - Menü",
			align    = 'bottom-right',
			elements = {
				{ label = "Inhaftiere Person", value = "jail_closest_player" },
				{ label = "Person Freilassen", value = "unjail_player" }
			}
		}, 
	function(data, menu)

		local action = data.current.value

		if action == "jail_closest_player" then

			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "Zeit (Minuten)"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
              		ESX.ShowNotification("The time needs to be in minutes!")
            	else
              		menu2.close()

              		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              		if closestPlayer == -1 or closestDistance > 2.0 then
                		TriggerEvent("skyline_notify:Alert", "LSPD" , "Keine Person in der Nähe!" , 2000 , "error")
					else
						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "Grund"
							},
						function(data3, menu3)
		  
						  	local reason = data3.value
		  
						  	if reason == nil then
								TriggerEvent("skyline_notify:Alert", "LSPD" , "Ungültige Eingabe!" , 2000 , "error")
							else
								menu3.close()
		  
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  
								if closestPlayer == -1 or closestDistance > 2.0 then
									TriggerEvent("skyline_notify:Alert", "LSPD" , "Keine Person in der Nähe!" , 2000 , "error")
								else
								  	TriggerServerEvent("jailihrfotzen:jailPlayer", GetPlayerServerId(closestPlayer), jailTime + 1, reason)
								end
		  
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)
              		end

				end

          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "unjail_player" then

			local elements = {}

			ESX.TriggerServerCallback("jailihrfotzen:retrieveJailedPlayers", function(playerArray)

				if #playerArray == 0 then
					ESX.ShowNotification("Es ist niemand im Gefäggnis")
					return
				end

				for i = 1, #playerArray, 1 do
					table.insert(elements, {label = playerArray[i].name .. " | " .. playerArray[i].jailTime .. " Minuten", value = playerArray[i].identifier })
				end

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'jail_unjail_menu',
					{
						title = "Person Freilassen",
						align = "bottom-right",
						elements = elements
					},
				function(data2, menu2)

					local action = data2.current.value

					TriggerServerEvent("jailihrfotzen:unJailPlayer", action)

					menu2.close()

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
		menu.close()
	end)	
end

