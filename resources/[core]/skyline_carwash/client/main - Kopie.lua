SKYLINE = nil

Citizen.CreateThread(function()
	while SKYLINE == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	for i=1, #Config.Locations, 1 do
		carWashLocation = Config.Locations[i]

		local blip = AddBlipForCoord(carWashLocation)
		SetBlipSprite(blip, 100)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 44)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString("Waschanlage")
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local canSleep = true

		if CanWashVehicle() then

			for i=1, #Config.Locations, 1 do
				local carWashLocation = Config.Locations[i]
				local distance = GetDistanceBetweenCoords(coords, carWashLocation, true)

				if distance < 50 then
					DrawMarker(1, carWashLocation, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, false, false, 2, false, false, false, false)
					canSleep = false
				end

				if distance < 5 then
					canSleep = false

					if Config.EnablePrice then
						SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um dein Fahrzeu zu waschen. (Kosten: " .. Config.Price .. "$)")
					else
						--SKYLINE.ShowHelpNotification(_U('prompt_wash'))
					end

					if IsControlJustReleased(0, 38) then
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

						if GetVehicleDirtLevel(vehicle) > 2 then
							WashVehicle()
						else
							TriggerEvent("skyline_notify:Alert", "WASCHANLAGE" , "Dein Auto ist schon sauber!" , 2000 , "error")

						end
					end
				end
			end

			if canSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(500)
		end
	end
end)

function CanWashVehicle()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)

		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			return true
		end
	end

	return false
end

function WashVehicle()
	SKYLINE.TriggerServerCallback('autowäscheduhs:canAfford', function(canAfford)
		if canAfford then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			SetVehicleDirtLevel(vehicle, 0.1)

			if Config.EnablePrice then
				TriggerEvent("skyline_notify:Alert", "WASCHANLAGE" , "Du hast <b>" .. Config.Price .. "$</b> bezahlt." , 2000 , "success")
			
			end
			Citizen.Wait(5000)
		else
			TriggerEvent("skyline_notify:Alert", "WASCHANLAGE" , "Dein Auto ist schon sauber!" , 2000 , "error")
			Citizen.Wait(5000)
		end
	end)
end
