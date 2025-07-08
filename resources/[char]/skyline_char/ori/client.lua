Keys = {
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

SKYLINE = nil

Citizen.CreateThread(function()
    while SKYLINE == nil do
        TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
        Citizen.Wait(0)
    end
end)


-- Schöhnheitsklinik
local isInMenu = false 

local locs =  {
    {x = 1131.9526 , y = -1476.6616 , z = 33.8448},
    {x = -1132.1184 , y = -2798.2764 , z = 26.7087}
}


Citizen.CreateThread(function()
    for k,v in pairs(locs) do
        local blip = AddBlipForCoord(v.x, v.y , v.z)
    
        SetBlipSprite (blip, 403)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip,64)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Schöhnheitsklinik")
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local coords = GetEntityCoords(PlayerPedId())
        local canSleep = true

        for k,v in pairs(locs) do
            if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50.0 then
                canSleep = false
                DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.4, 2.4, 1.0, 0, 0, 255, 100, false, true, 2, false, false, false, false)
            end

            if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50.0 then
                canSleep = false
                DrawMarker(1, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.4, 2.4, 1.0, 0, 0, 255, 100, false, true, 2, false, false, false, false)
            end
        end
        
        if canSleep then
            Citizen.Wait(500)
        end
    end
end)


local peds = {
    {x = 1131.9526 , y = -1476.6616 , z = 33.8448, heading = 280.0},
    {x = -1132.1184 , y = -2798.2764 , z = 26.7087, heading = 197.1185}


}
Citizen.CreateThread(function()
    RequestModel(GetHashKey("s_m_y_autopsy_01"))
    
    while not HasModelLoaded(GetHashKey("s_m_y_autopsy_01")) do
        Wait(1)
    end
    
    for _, item in pairs(peds) do
        local npc = CreatePed(4, 0xB2273D4E, item.x, item.y, item.z, item.heading, false, true)
            
        SetEntityHeading(npc, item.heading)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
    end
  
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if not isInMenu then 
            local pCoords = GetEntityCoords(PlayerPedId())
            local pos = vector3(-1132.1118, -2798.2981, 27.7087)

            if GetDistanceBetweenCoords(pos , pCoords , true) < 1.5 then 
                SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um die ~r~Schöhnheitsklinik ~w~zu nutzen")

                if IsControlJustPressed(0, 38) then 
                            isInMenu = true
                            

                            TriggerEvent('spielerskin:openSaveableMenu', function(data, menu)
                                menu.close()
                        
                                SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
                                    title = "Passt alles?",
                                    align = 'top-left',
                                    elements = {
                                        {label = "<b style=color:green;>Ja",  value = 'yes'},
                                        {label = "<b style=color:red;>Nein", value = 'no'}
                                    }
                                }, function(data, menu)
                                    menu.close()
                                    
                                    if data.current.value == 'yes' then
                                        TriggerEvent('skinändernduhs:getSkin', function(skin)
                                            TriggerServerEvent('spielerskin:save', skin)
                                        end)
        
                                        isInMenu = false 
        
                                    elseif data.current.value == 'no' then
                                        SKYLINE.TriggerServerCallback('spielerskin:getPlayerSkin', function(skin)
                                            TriggerEvent('skinändernduhs:loadSkin', skin) 
                                        end)
        
                                        isInMenu = false 
        
                                    end
                                    
                                 
                                end, function(data, menu)
                                    menu.close()
                                    isInMenu = false 
        
                                    
                                end)
                            end, function(data, menu)
                                menu.close()
                                isInMenu = false 
        
                            end)
                    
                   

                

                  
                end 
            end 

        end 
    end 
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if not isInMenu then 
            local pCoords = GetEntityCoords(PlayerPedId())
            local pos = vector3( 1131.9526, -1476.6616,33.8448)

            if GetDistanceBetweenCoords(pos , pCoords , true) < 1.5 then 
                SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um die ~r~Schöhnheitsklinik ~w~zu nutzen")

                if IsControlJustPressed(0, 38) then 
                    SKYLINE.TriggerServerCallback("skyline_plasticsurgery:checkMoney", function(hasMoney) 
                        if hasMoney then 
                            isInMenu = true
                            

                            TriggerEvent('spielerskin:openSaveableMenu', function(data, menu)
                                menu.close()
                        
                                SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
                                    title = "Passt alles?",
                                    align = 'top-left',
                                    elements = {
                                        {label = "<b style=color:green;>Ja",  value = 'yes'},
                                        {label = "<b style=color:red;>Nein", value = 'no'}
                                    }
                                }, function(data, menu)
                                    menu.close()
                                    
                                    if data.current.value == 'yes' then
                                        TriggerEvent('skinändernduhs:getSkin', function(skin)
                                            TriggerServerEvent('spielerskin:save', skin)
                                        end)

                                        TriggerServerEvent("skyline_plasticsurgery:bezahlendukelb")
        
                                        isInMenu = false 
        
                                    elseif data.current.value == 'no' then
                                        SKYLINE.TriggerServerCallback('spielerskin:getPlayerSkin', function(skin)
                                            TriggerEvent('skinändernduhs:loadSkin', skin) 
                                        end)
        
                                        isInMenu = false 
        
                                    end
                                    
                                 
                                end, function(data, menu)
                                    menu.close()
                                    isInMenu = false 
        
                                    
                                end)
                            end, function(data, menu)
                                menu.close()
                                isInMenu = false 
        
                            end)
                        else 
                            TriggerEvent("skyline_notify:Alert", "Schöhnheitsklinik" , "Du brauchst dafür <b style=color:red;>500.000$" , 4000 , "error")
                        end 
                    end)

                

                  
                end 
            end 

        end 
    end 
end)
-- Schöhnheitsklinik



-- Friseur
local GUIB                     = {}
GUIB.Time                      = 0
local HasAlreadyEnteredMarkerB = false
local LastZoneB                = nil
local CurrentActionB           = nil
local CurrentActionBMsg       = ''
local CurrentActionBData       = {}
local HasPayedB                = false


function OpenShopMenuB()

	HasPayedB = false

	SKYLINE.TriggerServerCallback('skyline_barbershop:checkMoney', function(hasEnoughMoney1)

		if hasEnoughMoney1 then 
			TriggerEvent('spielerskin:openSaveableRestrictedMenu', function(data, menu)

				menu.close()
		
				SKYLINE.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'shop_confirm',
					{
						title = "Möchtest du das bezahlen?",
						align = 'top-left',
						elements = {
							{label = "Ja", value = 'yes'},
							{label = "Nein", value = 'no'},
						}
					},
					function(data, menu)
		
						menu.close()
		
						if data.current.value == 'yes' then
		
							SKYLINE.TriggerServerCallback('skyline_barbershop:checkMoney', function(hasEnoughMoney)
		
								if hasEnoughMoney then
		
									TriggerEvent('skinändernduhs:getSkin', function(skin)
										TriggerServerEvent('spielerskin:save', skin)
									end)
		
									TriggerServerEvent('skyline_barbershop:pay')
		
									HasPayedB = true
								else
		
									TriggerEvent('spielerskin:getLastSkin', function(skin)
										TriggerEvent('skinändernduhs:loadSkin', skin)
									end)
                                    
                                    TriggerEvent("skyline_notify:Alert", 1 , "Friseur", "Du hast nicht genug Geld dabei! Du brauchst <b style=color:red>50$</b>" , 4000 , "error")
								
								end
		
							end)
		
						end
		
						if data.current.value == 'no' then
		
							TriggerEvent('spielerskin:getLastSkin', function(skin)
								TriggerEvent('skinändernduhs:loadSkin', skin)
							end)
		
						end
		
						CurrentActionB     = 'shop_menu'
						CurrentActionBMsg  = "Drücke ~INPUT_CONTEXT~ um den Friseur zu nutzen"
						CurrentActionBData = {}
		
					end,
					function(data, menu)
		
						menu.close()
		
						CurrentActionB     = 'shop_menu'
						CurrentActionBMsg  = "Drücke ~INPUT_CONTEXT~ um den Friseur zu nutzen"
						CurrentActionBData = {}
		
					end
				)
		
			end, function(data, menu)
		
					menu.close()
		
					CurrentActionB     = 'shop_menu'
					CurrentActionBMsg  = "Drücke ~INPUT_CONTEXT~ um den Friseur zu nutzen"
					CurrentActionBData = {}
		
			end, {
				'beard_1',
				'beard_2',
				'beard_3',
				'beard_4',
				'hair_1',
				'hair_2',
				'hair_color_1',
				'hair_color_2',
				'eyebrows_1',
				'eyebrows_2',
				'eyebrows_3',
				'eyebrows_4',
				'makeup_1',
				'makeup_2',
				'makeup_3',
				'makeup_4',
				'lipstick_1',
				'lipstick_2',
				'lipstick_3',
				'lipstick_4',
				'ears_1',
				'ears_2',
			})
		else 
            TriggerEvent("skyline_notify:Alert", "Friseur" , ">Du hast nicht genug Geld dabei! Du brauchst <b style=color:red1.000$" , 4000 , "error")
		end 


	
	end)


end

AddEventHandler('skyline_barbershop:hasEnteredMarker', function(zone)
	CurrentActionB     = 'shop_menu'
	CurrentActionBMsg  = "Drücke ~INPUT_CONTEXT~ um den Friseur zu nutzen"
	CurrentActionBData = {}
end)

AddEventHandler('skyline_barbershop:hasExitedMarker', function(zone)
	
	SKYLINE.UI.Menu.CloseAll()
	CurrentActionB = nil

	if not HasPayed then

		TriggerEvent('spielerskin:getLastSkin', function(skin)
			TriggerEvent('skinändernduhs:loadSkin', skin)
		end)

	end

end)

-- Create Blips
Citizen.CreateThread(function()
	
	for i=1, #ConfigBS.Shops, 1 do
		
		local blip = AddBlipForCoord(ConfigBS.Shops[i].x, ConfigBS.Shops[i].y, ConfigBS.Shops[i].z)

		SetBlipSprite (blip, 71)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipColour (blip, 12)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Friseur")
		EndTextCommandSetBlipName(blip)
	end

end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		
		Wait(0)
		
		local coords = GetEntityCoords(GetPlayerPed(-1))
		
		for k,v in pairs(ConfigBS.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < ConfigBS.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end

	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		
		Wait(0)
		
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarkerB  = false
		local currentZone = nil

		for k,v in pairs(ConfigBS.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarkerB  = true
				currentZone = k
			end
		end

		if (isInMarkerB and not HasAlreadyEnteredMarkerB) or (isInMarkerB and LastZone ~= currentZone) then
			HasAlreadyEnteredMarkerB = true
			LastZone                = currentZone
			TriggerEvent('skyline_barbershop:hasEnteredMarker', currentZone)
		end

		if not isInMarkerB and HasAlreadyEnteredMarkerB then
			HasAlreadyEnteredMarkerB = false
			TriggerEvent('skyline_barbershop:hasExitedMarker', LastZone)
		end

	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentActionB ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionBMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUIB.Time) > 300 then
				
				if CurrentActionB == 'shop_menu' then
					OpenShopMenuB()
				end

				CurrentActionB = nil
				GUIB.Time      = GetGameTimer()
				
			end

		end

	end
end)
-- Friseur

-- Kleidungsladen


local GUI, CurrentActionData = {}, {}
GUI.Time = 0
local LastZone, CurrentAction, CurrentActionMsg
local HasPayed, HasLoadCloth, HasAlreadyEnteredMarker = false, false, false


function OpenShopMenu()
  local elements = {}

  table.insert(elements, {label = "Kleidungsladen",  value = 'shop_clothes'})
  table.insert(elements, {label = "Deine Outfits", value = 'player_dressing'})
  table.insert(elements, {label = "Outfits löschen", value = 'suppr_cloth'})

  SKYLINE.UI.Menu.CloseAll()

  SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_main', {
      title    = "Willkommen ! Was möchtest du tun ?",
      align    = 'top-left',
      elements = elements,
    }, function(data, menu)
	menu.close()

      if data.current.value == 'shop_clothes' then
			HasPayed = false

			SKYLINE.TriggerServerCallback('skyline_clotheshop:checkMoney', function(hasEnoughMoney1)
				if hasEnoughMoney1 then 
					TriggerEvent('spielerskin:openSaveableRestrictedMenu', function(data, menu)

						menu.close()
				
						SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
								title = "Möchtest du diese Kleidung kaufen?",
								align = 'top-left',
								elements = {
									{label = "Ja", value = 'yes'},
									{label = "Nein", value = 'no'},
								}
							}, function(data, menu)
				
								menu.close()
				
								if data.current.value == 'yes' then
				
									SKYLINE.TriggerServerCallback('skyline_clotheshop:checkMoney', function(hasEnoughMoney)
				
										if hasEnoughMoney then
				
											TriggerEvent('skinändernduhs:getSkin', function(skin)
												TriggerServerEvent('spielerskin:save', skin)
											end)
				
											TriggerServerEvent('skyline_clotheshop:pay')
				
											HasPayed = true
				
											SKYLINE.TriggerServerCallback('skyline_clotheshop:checkPropertyDataStore', function(foundStore)
				
												if foundStore then
				
													SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'save_dressing', {
															title = "Als Outfit speichern?",
															align = 'top-left',
															elements = {
																{label = "Ja", value = 'yes'},
																{label = "Nein",  value = 'no'},
															}
														}, function(data2, menu2)
				
															menu2.close()
				
															if data2.current.value == 'yes' then
				
																SKYLINE.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
																		title = "Gebe ein Namen ein",
																	}, function(data3, menu3)
				
																		menu3.close()
				
																		TriggerEvent('skinändernduhs:getSkin', function(skin)
																			TriggerServerEvent('skyline_clotheshop:saveOutfit', data3.value, skin)
																		end)
				
																		TriggerEvent("skyline_notify:Alert", "Kleidungsladen" , "Aktuelle Kleidung erfolgreich als Outfits gespeichert." , 5000 , "long")


				
																	end, function(data3, menu3)
																		menu3.close()
																	end)
															end
														end)
												end
											end)
				
										else
				
											TriggerEvent('spielerskin:getLastSkin', function(skin)
												TriggerEvent('skinändernduhs:loadSkin', skin)
											end)

											TriggerEvent("skyline_notify:Alert", "Kleidungsladen" , "Du hast nicht genug Geld dabei!" , 4000 , "error")

										end
									end)
								end
				
								if data.current.value == 'no' then
				
									TriggerEvent('spielerskin:getLastSkin', function(skin)
										TriggerEvent('skinändernduhs:loadSkin', skin)
									end)
								end
				
								CurrentAction     = 'shop_menu'
								CurrentActionMsg  = "Drücke ~INPUT_CONTEXT~ um deine ~y~Kleidung ~w~zu ändern"
								CurrentActionData = {}
				
							end, function(data, menu)
				
								menu.close()
				
								CurrentAction     = 'shop_menu'
								CurrentActionMsg  = "Drücke ~INPUT_CONTEXT~ um deine ~y~Kleidung ~w~zu ändern"
								CurrentActionData = {}
				
							end)
					end, function(data, menu)
				
							menu.close()
				
							CurrentAction     = 'shop_menu'
							CurrentActionMsg  = "Drücke ~INPUT_CONTEXT~ um deine ~y~Kleidung ~w~zu ändern"
							CurrentActionData = {}
				
					end, {
						'tshirt_1',
						'tshirt_2',
						'torso_1',
						'torso_2',
						'decals_1',
						'decals_2',
						'arms',
						'pants_1',
						'pants_2',
						'shoes_1',
						'shoes_2',
						'chain_1',
						'chain_2',
						'helmet_1',
						'helmet_2',
						'glasses_1',
						'glasses_2',
						'mask_1',
						'mask_2',
						'bags_1',
						'bags_2',
					})
				else 
					TriggerEvent("skyline_notify:Alert", "Kleidungsladen" , "<span style=color:red>Du hast nicht genug Geld dabei! Du brauchst <b style=color:red>85$" , 4000 , "error")
				end 
			end)


      end

      if data.current.value == 'player_dressing' then
		
        SKYLINE.TriggerServerCallback('skyline_clotheshop:getPlayerDressing', function(dressing)
          local elements = {}

          for i=1, #dressing, 1 do
            table.insert(elements, {label = dressing[i], value = i})
          end

          SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
              title    = "Deine Outfits",
              align    = 'top-left',
              elements = elements,
            }, function(data, menu)

              TriggerEvent('skinändernduhs:getSkin', function(skin)

                SKYLINE.TriggerServerCallback('skyline_clotheshop:getPlayerOutfit', function(clothes)

                  TriggerEvent('skinändernduhs:loadClothes', skin, clothes)
                  TriggerEvent('spielerskin:setLastSkin', skin)

                  TriggerEvent('skinändernduhs:getSkin', function(skin)
                    TriggerServerEvent('spielerskin:save', skin)
                  end)
				  TriggerEvent("skyline_notify:Alert", "Kleidungsladen" , "Outfit geladen" , 5000)

				  HasLoadCloth = true
                end, data.current.value)
              end)
            end, function(data, menu)
              menu.close()
			  
			  CurrentAction     = 'shop_menu'
			  CurrentActionMsg  = "Drücke ~INPUT_CONTEXT~ um deine ~y~Kleidung ~w~zu ändern"
			  CurrentActionData = {}
            end
          )
        end)
      end
	  
	  if data.current.value == 'suppr_cloth' then
		SKYLINE.TriggerServerCallback('skyline_clotheshop:getPlayerDressing', function(dressing)
			local elements = {}

			for i=1, #dressing, 1 do
				table.insert(elements, {label = dressing[i], value = i})
			end
			
			SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'supprime_cloth', {
              title    = "Welches Outfit soll gelösch werden?",
              align    = 'top-left',
              elements = elements,
            }, function(data, menu)
			menu.close()
				TriggerServerEvent('skyline_clotheshop:deleteOutfit', data.current.value)
				 
				TriggerEvent("skyline_notify:Alert", "Kleidungsladen" , "Outfitf gelöscht." , 5000)

            end, function(data, menu)
              menu.close()
			  
			  CurrentAction     = 'shop_menu'
			  CurrentActionMsg  = "Drücke ~INPUT_CONTEXT~ um deine ~y~Kleidung ~w~zu ändern"
			  CurrentActionData = {}
            end)
		end)
	  end
    end, function(data, menu)

      menu.close()

      CurrentAction     = 'room_menu'
      CurrentActionMsg  = "Drücke ~INPUT_CONTEXT~ um deine ~y~Kleidung ~w~zu ändern"
      CurrentActionData = {}
    end)
end

AddEventHandler('skyline_clotheshop:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = "Drücke ~INPUT_CONTEXT~ um deine ~y~Kleidung ~w~zu ändern"
	CurrentActionData = {}
end)

AddEventHandler('skyline_clotheshop:hasExitedMarker', function(zone)
	
	SKYLINE.UI.Menu.CloseAll()
	CurrentAction = nil

	if not HasPayed then
		if not HasLoadCloth then 

			TriggerEvent('spielerskin:getLastSkin', function(skin)
				TriggerEvent('skinändernduhs:loadSkin', skin)
			end)
		end
	end
end)


-- Create Blips
Citizen.CreateThread(function()

	for i=1, #Config.Shops, 1 do

		local blip = AddBlipForCoord(Config.Shops[i].x, Config.Shops[i].y, Config.Shops[i].z)

		SetBlipSprite (blip, 73)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, tonumber("0.8"))
		SetBlipColour (blip, 66)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Kleidungsladen")
		EndTextCommandSetBlipName(blip)
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do

		Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('skyline_clotheshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('skyline_clotheshop:hasExitedMarker', LastZone)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  38) and (GetGameTimer() - GUI.Time) > 300 then

				if CurrentAction == 'shop_menu' then
					OpenShopMenu()
				end

				CurrentAction = nil
				GUI.Time      = GetGameTimer()
			end
		end
	end
end)
