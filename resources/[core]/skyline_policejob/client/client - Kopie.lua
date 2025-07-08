SKYLINE = nil

hasJob = false 
grade = -1
grade_name = ""

local isInUmkleide = false 
local isInBoss = false 
local isInF6 = false 
local isHandcuffed = false 
local handcuff_type = ""

dragStatus = {}
dragStatus.isDragged =  false
dragStatus.CopId = -1 

Citizen.CreateThread(function()
    while SKYLINE == nil do
        TriggerEvent("skylineistback:getSharedObject", function(obj) SKYLINE = obj end)
        Citizen.Wait(0)
    end

    Citizen.Wait(1000)

    SKYLINE.TriggerServerCallback("skyline_policejob:getJobData", function(job , grade1 , gradename) 
        if job == "police" then 
            hasJob = true 
            grade = grade1
            grade_name = gradename
        end 
    end)
end)

-- Job Handler -- 
RegisterNetEvent("skyline:playerLoaded")
AddEventHandler("skyline:playerLoaded", function(xPlayer)
	if xPlayer.job.name == "police" then 
		hasJob = true  
        grade = xPlayer.job.grade
        grade_name = xPlayer.job.grade_name
	end 
end)

RegisterNetEvent("skyline:setJob")
AddEventHandler("skyline:setJob", function(job)
	if job.name == "police" then 
		hasJob = true 
        grade = job.grade
        grade_name = job.grade_name
	else 
		hasJob = false 
	end 
end)
-- Job Handler -- 

-- Umkleide -- 
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if hasJob then 
            local pCoords = GetEntityCoords(PlayerPedId())

            if GetDistanceBetweenCoords(pCoords , Config.Umkleide , true) < 25.0 then 
                DrawMarker(1, Config.Umkleide.x, Config.Umkleide.y, Config.Umkleide.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 0.2, 0, 0, 255, 255, false, false, 2, false, nil, nil, false)
            end 

            if GetDistanceBetweenCoords(pCoords , Config.Umkleide , true) > 1.0 and isInUmkleide then 
                SKYLINE.UI.Menu.CloseAll()
                isInUmkleide = false 
            end 

            if GetDistanceBetweenCoords(pCoords , Config.Umkleide , true) < 1.0 then 
                if not isInUmkleide then 
                    SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den ~y~Kleiderschrank ~w~zu benutzen")
                    
                    if IsControlJustPressed(0 , 38) then 
                        isInUmkleide = true 

                        SKYLINE.UI.Menu.CloseAll()

                        local elements = {
                            { label = "Zivil-Kleidung", value = "citizen_wear" },
                            { label = "Dienstkleidung", value = "bullet_wear" }
                        }

                        SKYLINE.UI.Menu.Open("default", GetCurrentResourceName(), "lspd_cloakroom", {
                            title    = "LSPD - Umkleide",
                            align    = "top-left",
                            elements = elements
                        }, function(data, menu)
                    
                            if data.current.value == "citizen_wear" then
                                    SKYLINE.TriggerServerCallback("spielerskin:getPlayerSkin", function(skin)
                                        TriggerEvent("skinändernduhs:loadSkin", skin)
                                        TriggerEvent("skyline_notify:Alert", "LSPD" , "Zivil-Kleidung angezogen." , 2000 , "success")
                                        menu.close()
                                        isInUmkleide = false 
                                    end)
                                    
                            end

                            if data.current.value == "bullet_wear" then 
                                TriggerEvent('skinändernduhs:getSkin', function(skin)
                                    local uniformObject = nil 

                                    if skin.sex == 0 then
                                        uniformObject = Config.Uniform.male
                                    else
                                        uniformObject = Config.Uniform.female
                                    end
                                    menu.close()
                                    isInUmkleide = false 

                                    TriggerEvent('skinändernduhs:loadClothes', skin, uniformObject)
                                    TriggerEvent("skyline_notify:Alert", "LSPD" , "Dienstkleidung angezogen." , 2000 , "success")
                                  
                                end)
                            end 
                      
                       
                        end, function(data, menu)
                            menu.close()
                            isInUmkleide = false 
                        end)
                    end 
               
                end 
            end 
        end 
    end 
end)
-- Umkleide -- 

-- Boss Menu -- 
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if hasJob and grade > 7 then 
            local pCoords = GetEntityCoords(PlayerPedId())

            if GetDistanceBetweenCoords(pCoords , Config.Boss , true) < 25.0 then 
                DrawMarker(21, Config.Boss.x, Config.Boss.y, Config.Boss.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, 0, 0, 255, 255, true, false, 2, true, nil, nil, false)
            end 

            if GetDistanceBetweenCoords(pCoords , Config.Boss , true) < 0.8 then 
                if not isInBoss then 
                    SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um das ~y~Boss-Menü ~w~zu benutzen")

                    if IsControlJustPressed(0 , 38) then 
                        TriggerEvent('jobsundso:openBossMenu', 'police', function(data, menu)
                            menu.close()
    
                        
                        end, { wash = false , deposit = false , withdraw = false , grades = false}) 
                    end 
                end 
            end 
        end 
    end 
end)

-- Boss Menu -- 

-- F6 Menu -- 
function OpenBodySearchMenu(player)
	SKYLINE.TriggerServerCallback('skyline_policejob:getOtherPlayerData', function(data)
		local elements = {}

		for i=1, #data.accounts, 1 do
			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				table.insert(elements, {
					label    = "Schwarzgeld: <b style=color:red>" .. SKYLINE.Math.Round(data.accounts[i].money) .. "</b>",
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end
		end

		table.insert(elements, {label = "Waffen"})

		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = "Waffe: <b style=color:red>" ..  SKYLINE.GetWeaponLabel(data.weapons[i].name) .. "</b>",
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, {label = "Tasche"})

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = "Gegenstand: <b style=color:green>" ..data.inventory[i].count .. "x " .. data.inventory[i].label .. "</b>",
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end

		SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
			title    = "Durchsuchen",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				TriggerServerEvent('skyline_policejob:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
				OpenBodySearchMenu(player)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function ShowPlayerLicense(player)
	local elements = {}

	SKYLINE.TriggerServerCallback('skyline_policejob:getOtherPlayerData', function(playerData)
		if playerData.licenses then
			for i=1, #playerData.licenses, 1 do
				if playerData.licenses[i].label and playerData.licenses[i].type then
					table.insert(elements, {
						label = playerData.licenses[i].label,
						type = playerData.licenses[i].type
					})
				end
			end
		end

		SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license', {
			title    = "Lizenz - Entziehen",
			align    = 'bottom-right',
			elements = elements,
		}, function(data, menu)
            TriggerEvent("skyline_notify:Alert", "LSPD" , "Du hast die Lizenz: " .. data.current.label .. " " .. playerData.name .. " entzogen!" , 3000 , "success")
			
            TriggerServerEvent('skyline_policejob:message', GetPlayerServerId(player), data.current.label)

			TriggerServerEvent('bruderlizenzenundso:removeLicense', GetPlayerServerId(player), data.current.type)

			SKYLINE.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenIdentityCardMenu(player)
	SKYLINE.TriggerServerCallback('skyline_policejob:getOtherPlayerData', function(data)
		local elements = {
			{label =  data.name}
		}

            local b = ""

            if data.sex == "male" then 
                b = "Männlich"
            else 
                b = "Weiblich"
            end 

			table.insert(elements, {label = "Geschlecht: " .. b})
			table.insert(elements, {label = "Geb.: " .. data.dob})
			table.insert(elements, {label = "Größe: " .. data.height .. "cm"})
		

		SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = "LSPD - Aktionsmenü",
			align    = 'bottom-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end


function OpenVehicleInfosMenu(vehicleData)
	SKYLINE.TriggerServerCallback('skyline_policejob:getVehicleInfos', function(retrivedInfo)
		local elements = {{label = "Kennzeichen: " .. retrivedInfo.plate}}

		if not retrivedInfo.owner then
			table.insert(elements, {label = "Besitzer: Unbekannt"})
		else
			table.insert(elements, {label = "Besitzer: " .. retrivedInfo.owner})
		end

		SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			title    = "Fahrzeug Informationen",
			align    = 'bottom-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, vehicleData.plate)
end

function LookupVehicle()
	SKYLINE.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle', {
		title = "Kennzeichen eingeben",
	}, function(data, menu)
		local length = string.len(data.value)
		if not data.value or length < 2 or length > 8 then
			TriggerEvent("skyline_notify:Alert", "Ungültige Eingabe" , 3000 , "error")
		else
			SKYLINE.TriggerServerCallback('skyline_policejob:getVehicleInfos', function(retrivedInfo)
				local elements = {{label = "Kennzeichen: " .. retrivedInfo.plate}}
				menu.close()

				if not retrivedInfo.owner then
					table.insert(elements, {label = "Besitzer: Unbekannt"})
				else
					table.insert(elements, {label = "Besitzer: " .. retrivedInfo.owner})
				end

				SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
					title    = "Fahrzeug - Informationen",
					align    = 'bottom-right',
					elements = elements
				}, nil, function(data2, menu2)
					menu2.close()
				end)
			end, data.value)

		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	SKYLINE.TriggerServerCallback('rechnungundso:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, SKYLINE.Math.GroupDigits(bill.amount)),
				billId = bill.id
			})
		end

		SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = "Unbezahlte Rechnungen",
			align    = 'bottom-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if hasJob then 
            if not isInF6 then 
            

                if IsControlJustPressed(0, 167) then 
                    isInF6 = true 


                    SKYLINE.UI.Menu.Open("default", GetCurrentResourceName(), "lspd_f6", {
                        title = "LSPD - Menü", 
                        elements = {
                            {label = "Aktions - Menü" , value = "actions"}, 
                            {label = "Fahrzeug - Menü" , value = "veh"}, 
                            {label = "Bestrafungen" , value = "jail"}, 
                            {label = "Tablet" , value = "tablet"}, 
                            {label = "Objekte" , value = "object"}
                        },
                        align = "bottom-right",
                    }, function(data , menu)

                        if data.current.value == "jail" then 
                            SKYLINE.UI.Menu.Open("default", GetCurrentResourceName(), "lspd_action", {
                                title = "LSPD - Knast-Menü",
                                align = "bottom-right",
                                elements = {
                                    {label = "Menü" , value = "mj"},
                                    {label = "Rechnung austellen", value = "billing"},
                                    {label = "Unbezahlte Rechnungen", value = "ur"}


                                }
                            }, function(data , menu)

                                if data.current.value == "mj" then 
                                    ExecuteCommand("jailmenu")

                                end 

                                if data.current.value == "billing" then 
                                                        SKYLINE.UI.Menu.Open(
                            'dialog', GetCurrentResourceName(), 'billing',
                            {
                                title = "Menge"
                            },
                            function(data, menu)
                                local amount = tonumber(data.value)
                                if amount == nil or amount < 0 then
                                SKYLINE.ShowNotification("Ungültige Menge")
                                else
                                
                                local closestPlayer, closestDistance = SKYLINE.Game.GetClosestPlayer()
                                if closestPlayer == -1 or closestDistance > 1.5 then
                                    TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist niemand in der Nähe!" , 2000 , "error")
                                else
                                    menu.close()
                                    TriggerServerEvent('rechnungundso:sendBill', GetPlayerServerId(closestPlayer), 'society_police', "LSPD", amount)
                                end
                                end
                            end,
                            function(data, menu)
                            menu.close()
                            end
                            )
                                end 

                                if data.current.value == "ur" then 
                                    
                                    local closestPlayer, closestPlayerDistance = SKYLINE.Game.GetClosestPlayer()

                                    if closestPlayer == -1 or closestPlayerDistance > 1.5 then
                                       TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist niemand in der Nähe!" , 2000 , "error")
                                    else
                                        OpenUnpaidBillsMenu(closestPlayer)
                                    end
                                end 

                             
                              
                            end, function(datacl , menucl)
                                menucl.close()
                            end)
                        end 

                        if data.current.value == "veh" then 
                            SKYLINE.UI.Menu.Open("default", GetCurrentResourceName(), "lspd_action", {
                                title = "LSPD - Fahrzeugmenü",
                                align = "bottom-right",
                                elements = {
                                    {label = "Ins Auto setzen" , value = "putIn"},
                                    {label = "Aus Auto holen" , value = "out"},
                                    {label = "Auto aufbrechen" , value = "break"},
                                    {label = "Auto abschleppen" , value = "abschleppen"},
                                    {label = "Auto überprüfen" , value = "car"},
                                    {label = "Kennzeichen überprüfen" , value = "car1"},
                                    {label = "Kennzeichen Orten" , value = "car2"},


                                }
                            }, function(data , menu)

                                if data.current.value == "car2" then 
                                    ExecuteCommand("tracker")

                                end 

                                if data.current.value == "car1" then 
                                    LookupVehicle()

                                end 

                                if data.current.value == "abschleppen" then 
                                    local coords  = GetEntityCoords(PlayerPedId())
                                    local vehicles = SKYLINE.Game.GetVehiclesInArea(coords, 3.0)


                                    if DoesEntityExist(vehicles[1]) then 
                                        local vehicleData = SKYLINE.Game.GetVehicleProperties(vehicles[1])
						               
                                            TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                                            Citizen.Wait(4000)
                                            ClearPedTasksImmediately(PlayerPedId())

                                            SKYLINE.Game.DeleteVehicle(vehicles[1])
                                            TriggerEvent("skyline_notify:Alert", "LSPD" , "Fahrzeug abgeschleppt" , 2000 , "success")
                                         
                                    else 
                                        TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist kein Fahrzeug in der Nähe!" , 2000 , "error")
                                    end 

                                end 

                                if data.current.value == "break" then 
                                    local coords  = GetEntityCoords(PlayerPedId())
                                    local vehicles = SKYLINE.Game.GetVehiclesInArea(coords, 3.0)


                                    if DoesEntityExist(vehicles[1]) then 
                                        local vehicleData = SKYLINE.Game.GetVehicleProperties(vehicles[1])
						               
                                        if GetVehicleDoorLockStatus(vehicles[1]) ~= 0 then 
                                            TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_WELDING', 0, true)
                                            Citizen.Wait(4000)
                                            ClearPedTasksImmediately(PlayerPedId())

                                            SetVehicleDoorsLocked(vehicles[1], 1)
                                            SetVehicleDoorsLockedForAllPlayers(vehicles[1], false)
                                            TriggerEvent("skyline_notify:Alert", "LSPD" , "Fahrzeug geöffnet" , 2000 , "success")
                                        else 
                                            TriggerEvent("skyline_notify:Alert", "LSPD" , "Diese Fahrzeug ist schon offen!" , 2000 , "error")

                                        end 
                                    else 
                                        TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist kein Fahrzeug in der Nähe!" , 2000 , "error")
                                    end 

                                end 

                               
                                if data.current.value == "car" then 
                                    local coords  = GetEntityCoords(PlayerPedId())
                                    local vehicles = SKYLINE.Game.GetVehiclesInArea(coords, 2.0)


                                    if DoesEntityExist(vehicles[1]) then 
                                        local vehicleData = SKYLINE.Game.GetVehicleProperties(vehicles[1])
						                OpenVehicleInfosMenu(vehicleData)
                                    else 
                                        TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist kein Fahrzeug in der Nähe!" , 2000 , "error")
                                    end 

                                end 

                                if data.current.value == "putIn" then 
                                    local closestPlayer, closestPlayerDistance = SKYLINE.Game.GetClosestPlayer()

                                    if closestPlayer == -1 or closestPlayerDistance > 1.0 then
                                       TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist niemand in der Nähe!" , 2000 , "error")
                                    else
                                        SKYLINE.TriggerServerCallback("skyline_policejob:isCuffed", function(isCuffed) 
                                            if isCuffed then 
                                                TriggerServerEvent('skyline_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
                                            else 
                                                TriggerEvent("skyline_notify:Alert", "LSPD" , "Diese Person ist nicht gefesselt!" , 2000 , "error")

                                            end 
                                        end, GetPlayerServerId(closestPlayer))
                                    end

                                end

                                if data.current.value == "out" then 
                                    local closestPlayer, closestPlayerDistance = SKYLINE.Game.GetClosestPlayer()

                                    if closestPlayer == -1 or closestPlayerDistance > 5.0 then
                                       TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist niemand in der Nähe!" , 2000 , "error")
                                    else
                                        SKYLINE.TriggerServerCallback("skyline_policejob:isCuffed", function(isCuffed) 
                                            if isCuffed then 
                                                TriggerServerEvent('skyline_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
                                            else 
                                                TriggerEvent("skyline_notify:Alert", "LSPD" , "Diese Person ist nicht gefesselt!" , 2000 , "error")

                                            end 
                                        end, GetPlayerServerId(closestPlayer))
                                    end

                                end

                              
                            end, function(datacl , menucl)
                                menucl.close()
                            end)
                        end 

                        if data.current.value == "actions" then 
                            SKYLINE.UI.Menu.Open("default", GetCurrentResourceName(), "lspd_action", {
                                title = "LSPD - Aktionsmenü",
                                align = "bottom-right",
                                elements = {
                                    {label = "Fuß & Hand Fessel" , value = "hardcuff"},
                                    {label = "Handfessel" , value = "softcuff"},
                                    {label = "Entfesseln" , value = "uncuff"},
                                    {label = "Tragen" , value = "drag"},
                                    {label = "Durchsuchen" , value = "search"},
                                    {label = "Lizenzen Überprüfen" , value = "license"},
                                    {label = "Waffenschein austellen" , value = "wf"},
                                    {label = "Identität überprüfen" , value = "id"}



                                }
                            }, function(data , menu)
                                if data.current.value == "hardcuff" then 
                                    local closestPlayer, closestPlayerDistance = SKYLINE.Game.GetClosestPlayer()

                                    if closestPlayer == -1 or closestPlayerDistance > 1.0 then
                                       TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist niemand in der Nähe!" , 2000 , "error")
                                    else
                                        SKYLINE.TriggerServerCallback("skyline_policejob:isCuffed", function(isCuffed) 
                                            if not isCuffed then 
                                                TriggerServerEvent("skyline_policejob:cuff", GetPlayerServerId(closestPlayer) , "hardcuff")
                                            else 
                                                TriggerEvent("skyline_notify:Alert", "LSPD" , "Diese Person ist bereits gefesselt!" , 2000 , "error")

                                            end 
                                        end, GetPlayerServerId(closestPlayer))
                                    end

                                end 

                                if data.current.value == "softcuff" then 
                                    local closestPlayer, closestPlayerDistance = SKYLINE.Game.GetClosestPlayer()

                                    if closestPlayer == -1 or closestPlayerDistance > 1.0 then
                                       TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist niemand in der Nähe!" , 2000 , "error")
                                    else
                                        SKYLINE.TriggerServerCallback("skyline_policejob:isCuffed", function(isCuffed) 
                                            if not isCuffed then 
                                                TriggerServerEvent("skyline_policejob:cuff", GetPlayerServerId(closestPlayer) , "softcuff")
                                            else 
                                                TriggerEvent("skyline_notify:Alert", "LSPD" , "Diese Person ist bereits gefesselt!" , 2000 , "error")

                                            end 
                                        end, GetPlayerServerId(closestPlayer))
                                    end

                                end 

                                if data.current.value == "uncuff" then 
                                    local closestPlayer, closestPlayerDistance = SKYLINE.Game.GetClosestPlayer()

                                    if closestPlayer == -1 or closestPlayerDistance > 1.0 then
                                       TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist niemand in der Nähe!" , 2000 , "error")
                                    else
                                        SKYLINE.TriggerServerCallback("skyline_policejob:isCuffed", function(isCuffed) 
                                            if isCuffed then 
                                                TriggerServerEvent("skyline_policejob:uncuff", GetPlayerServerId(closestPlayer))
                                            else 
                                                TriggerEvent("skyline_notify:Alert", "LSPD" , "Diese Person ist nicht gefesselt!" , 2000 , "error")

                                            end 
                                        end, GetPlayerServerId(closestPlayer))
                                    end

                                end 

                                if data.current.value == "search" then 
                                    local closestPlayer, closestPlayerDistance = SKYLINE.Game.GetClosestPlayer()

                                    if closestPlayer == -1 or closestPlayerDistance > 1.0 then
                                       TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist niemand in der Nähe!" , 2000 , "error")
                                    else
                                        OpenBodySearchMenu(closestPlayer)
                                    end

                                end 

                                if data.current.value == "drag" then 
                                    local closestPlayer, closestPlayerDistance = SKYLINE.Game.GetClosestPlayer()

                                    if closestPlayer == -1 or closestPlayerDistance > 1.0 then
                                       TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist niemand in der Nähe!" , 2000 , "error")
                                    else
                                        SKYLINE.TriggerServerCallback("skyline_policejob:isCuffed", function(isCuffed) 
                                            if isCuffed then 
                                                TriggerServerEvent('skyline_policejob:drag', GetPlayerServerId(closestPlayer))
                                            else 
                                                TriggerEvent("skyline_notify:Alert", "LSPD" , "Diese Person ist nicht gefesselt!" , 2000 , "error")

                                            end 
                                        end, GetPlayerServerId(closestPlayer))
                                    end

                                end

                              

                                if data.current.value == "license" then 
                                    local closestPlayer, closestPlayerDistance = SKYLINE.Game.GetClosestPlayer()

                                    if closestPlayer == -1 or closestPlayerDistance > 1.5 then
                                       TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist niemand in der Nähe!" , 2000 , "error")
                                    else
                                        ShowPlayerLicense(closestPlayer)
                                    end

                                end

                                if data.current.value == "wf" then 
                                    local closestPlayer, closestPlayerDistance = SKYLINE.Game.GetClosestPlayer()

                                    if closestPlayer == -1 or closestPlayerDistance > 1.5 then
                                       TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist niemand in der Nähe!" , 2000 , "error")
                                    else
                                        TriggerServerEvent('bruderlizenzenundso:addLicense', GetPlayerServerId(closestPlayer), "weapon")
                                        TriggerEvent("skyline_notify:Alert", "LSPD" , "Waffenschein ausgestellt!" , 2000 , "success")
                                        TriggerServerEvent("skyline_policejob:message1" , GetPlayerServerId(closestPlayer))
                                    end

                                end

                                if data.current.value == "id" then 
                                    local closestPlayer, closestPlayerDistance = SKYLINE.Game.GetClosestPlayer()

                                    if closestPlayer == -1 or closestPlayerDistance > 1.5 then
                                       TriggerEvent("skyline_notify:Alert", "LSPD" , "Es ist niemand in der Nähe!" , 2000 , "error")
                                    else
                                        OpenIdentityCardMenu(closestPlayer)
                                    end

                                end
                            end, function(datacl , menucl)
                                menucl.close()
                            end)
                        end 
                        
                        if data.current.value == "tablet" then 
                            ExecuteCommand("ot1")
                        end 

                        if data.current.value == "object" then 
                            SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'object', {
                                title    = "Objekt - Spawner",
                                align    = 'bottom-right',
                                elements = {
                                    {label = "Verkehrshut", model = 'prop_roadcone02a'},
                                    {label = "Absperrung", model = 'prop_barrier_work05'},
                                    {label = "Spikes", model = 'p_ld_stinger_s'},
                            }}, function(data2, menu2)
                                local playerPed = PlayerPedId()
                                local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
                                local objectCoords = (coords + forward * 1.0)
                
                                SKYLINE.Game.SpawnObject(data2.current.model, objectCoords, function(obj)
                                    SetEntityHeading(obj, GetEntityHeading(playerPed))
                                    PlaceObjectOnGroundProperly(obj)
                                end)

                            end, function(data2, menu2)
                                menu2.close()
                            end)
                        end 
                        
                    end, 
                    
                    function(datacl , menucl)
                        menucl.close()
                        isInF6 = false 
                    end)
                end 
              
            end 
        end    
    end 
end)

RegisterNetEvent('skyline_policejob:cuff')
AddEventHandler('skyline_policejob:cuff', function(type)
	isHandcuffed = true 
    handcuff_type = type 

    RequestAnimDict('mp_arresting')
    while not HasAnimDictLoaded('mp_arresting') do
        Citizen.Wait(100)
    end

    TaskPlayAnim( PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
end)

RegisterNetEvent('skyline_policejob:uncuff')
AddEventHandler('skyline_policejob:uncuff', function()
	isHandcuffed = false 
    handcuff_type = "" 

    ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('skyline_policejob:putInVehicle')
AddEventHandler('skyline_policejob:putInVehicle', function()
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

				for i=maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				if freeSeat then
					TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
					dragStatus.isDragged = false
				end
			end
		end
	
end)

RegisterNetEvent('skyline_policejob:OutVehicle')
AddEventHandler('skyline_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        
        if isHandcuffed then 
           
            if not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) then 
                Citizen.Wait(250)
                TaskPlayAnim( PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            end 

          
			SetCurrentPedWeapon( PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true) 
			

            if handcuff_type == "hardcuff" then 

                DisableAllControlActions(0)
                EnableControlAction(0, 2, true)
                EnableControlAction(0, 1, true)

            end 

            if handcuff_type == "softcuff" then 

                DisableAllControlActions(0)
                EnableControlAction(0, 2, true)
                EnableControlAction(0, 1, true)
                EnableControlAction(0, 30, true)
                EnableControlAction(0, 31, true)

            end
        end 
    end 
end)

RegisterNetEvent('skyline_policejob:drag')
AddEventHandler('skyline_policejob:drag', function(copId)
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
end)

Citizen.CreateThread(function()
	local wasDragged

	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed and dragStatus.isDragged then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Citizen.Wait(100)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(playerPed, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(playerPed, true, false)
		else
			Citizen.Wait(100)
		end
	end
end)

local isInDelete = false
local crE = nil 

AddEventHandler('skyline_policejob:hasEnteredEntityZone', function(entity)
    isInDelete = true 
    crE = entity 
	
end)

AddEventHandler('skyline_policejob:hasExitedEntityZone', function(entity)
    isInDelete = false 
    cRE = nil 
	
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if hasJob and IsPedOnFoot(PlayerPedId()) and isInDelete then
            SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um das Objekt zu löschen")
            if IsControlJustPressed(0, 38) then 
                
                DeleteEntity(crE)
            end 
          
        end


        
    end 
end)


Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_barrier_work05',
		'p_ld_stinger_s',
		'prop_boxpile_07d',
		'hei_prop_cash_crate_half_full'
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(playerCoords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance = #(playerCoords - objCoords)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

    

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('skyline_policejob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('skyline_policejob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)
function RemoveSpike()
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    local vehCoord = GetEntityCoords(veh)
    if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
       spike = GetClosestObjectOfType(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), false, false, false)
       SetEntityAsMissionEntity(spike, true, true)
       DeleteEntity(spike)
    end
 end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      local ped = GetPlayerPed(-1)
      local veh = GetVehiclePedIsIn(ped, false)
      local vehCoord = GetEntityCoords(veh)
      if IsPedInAnyVehicle(ped, false) then
        if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
            RemoveSpike()
           SetVehicleTyreBurst(veh, 0, true, 1000.0)
           SetVehicleTyreBurst(veh, 1, true, 1000.0)
           SetVehicleTyreBurst(veh, 2, true, 1000.0)
           SetVehicleTyreBurst(veh, 3, true, 1000.0)
           SetVehicleTyreBurst(veh, 4, true, 1000.0)
           SetVehicleTyreBurst(veh, 5, true, 1000.0)
           SetVehicleTyreBurst(veh, 6, true, 1000.0)
           SetVehicleTyreBurst(veh, 7, true, 1000.0)
         end
       end
     end
  end)

local isInA = false 

function OpenWeaponComponentShop(components, weaponName, parentShop)
	SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons_components', {
		title    = "LSPD - Komponente",
		align    = 'top-left',
		elements = components
	}, function(data, menu)
		if data.current.hasComponent then
			SKYLINE.ShowNotification("Du hast diese Erweiterung schon!")
		else
			SKYLINE.TriggerServerCallback('skyline_policejob:buyWeapon', function(bought)
				if bought then
					

					menu.close()
					parentShop.close()
					OpenBuyWeaponsMenu()
				else
				end
			end, weaponName, 2, data.current.componentNum)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenBuyWeaponsMenu()
	local elements = {}
	local playerPed = PlayerPedId()

	for k,v in ipairs(Config.AuthorizedWeapons[grade_name]) do
		local weaponNum, weapon = SKYLINE.GetWeapon(v.weapon)
		local components, label = {}
		local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

		if v.components then
			for i=1, #v.components do
				if v.components[i] then
					local component = weapon.components[i]
					local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)

					if hasComponent then
						label = ('%s: <span style="color:green;">%s</span>'):format(component.label, "✔️")
					else
						if v.components[i] > 0 then
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, "$", SKYLINE.Math.GroupDigits(v.components[i]))
						else
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, "Gratis")
						end
					end

					table.insert(components, {
						label = label,
						componentLabel = component.label,
						hash = component.hash,
						name = component.name,
						price = v.components[i],
						hasComponent = hasComponent,
						componentNum = i
					})
				end
			end
		end

		if hasWeapon and v.components then
			label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
		elseif hasWeapon and not v.components then
			label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label,"✔️")
		else
			if v.price > 0 then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, "$", SKYLINE.Math.GroupDigits(v.price))
			else
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, "Gratis")
			end
		end

		table.insert(elements, {
			label = label,
			weaponLabel = weapon.label,
			name = weapon.name,
			components = components,
			price = v.price,
			hasWeapon = hasWeapon
		})
	end

	SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons', {
		title    = "LSPD - Waffenkammer",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.hasWeapon then
			if #data.current.components > 0 then
				OpenWeaponComponentShop(data.current.components, data.current.name, menu)
			end
		else
			SKYLINE.TriggerServerCallback('skyline_policejob:buyWeapon', function(bought)
				if bought then
					

					menu.close()
					OpenBuyWeaponsMenu()
				else
					SKYLINE.ShowNotification("")
				end
			end, data.current.name, 1)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetWeaponMenu()
	SKYLINE.TriggerServerCallback('skyline_policejob:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. SKYLINE.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon', {
			title    = "LSPD - Waffen - Nehmen",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			SKYLINE.TriggerServerCallback('skyline_policejob:removeArmoryWeapon', function()
				OpenGetWeaponMenu()
			end, data.current.value)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = SKYLINE.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label,
				value = weaponList[i].name
			})
		end
	end

	SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon', {
		title    = "LSPD - Waffen - Einlagern",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		SKYLINE.TriggerServerCallback('skyline_policejob:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, true)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()
	SKYLINE.TriggerServerCallback('skyline_policejob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
            if items[i].count > 0 then
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
           end
		end

		SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = "LSPD - Einlagern",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			SKYLINE.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = "Menge"
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					SKYLINE.ShowNotification("~r~Menge ungültig!")
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('skyline_policejob:getStockItem', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	SKYLINE.TriggerServerCallback('skyline_policejob:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = "Tasche",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			SKYLINE.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = "Menge"
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					SKYLINE.ShowNotification("~r~Menge Ungültig!")
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('skyline_policejob:putStockItems', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenArmoryMenu()
    local elements = {}

    table.insert(elements, {label = "Waffe einlagern",     value = 'put_weapon'})
	table.insert(elements, {label = "Gegenstand nehmen",  value = 'get_stock'})
	table.insert(elements, {label = "Gegenstand lagern", value = 'put_stock'})

	if grade >= 7 then
		table.insert(elements, {label = "Waffe nehmen",     value = 'get_weapon'})
		
	end

	SKYLINE.UI.Menu.CloseAll()

	SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = "LSPD - Lager",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'get_weapon' then
			OpenGetWeaponMenu()
		elseif data.current.value == 'put_weapon' then
			OpenPutWeaponMenu()
		elseif data.current.value == 'buy_weapons' then
			OpenBuyWeaponsMenu()
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenPDShop()


	SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'pd_shop', {
		title    = "Gegenstände",
		align    = 'top-left',
		elements = {
			{label = "LSPD Weste ", item = 'vest_lspd', type = 'slider', value = 1, min = 1, max = 100},
			{label = "Munition", item = 'munition', type = 'slider', value = 1, min = 1, max = 100},
            {label = "Medikit", item = 'medikit', type = 'slider', value = 1, min = 1, max = 100},
            {label = "Diensthandy", item = 'phone', type = 'slider', value = 1, min = 1, max = 1},
            {label = "Brot", item = 'brot', type = 'slider', value = 1, min = 1, max = 100},
            {label = "Wasser", item = 'wasser', type = 'slider', value = 1, min = 1, max = 100},
            {label = "PD Kleidung", item = 'pd_outfit', type = 'slider', value = 1, min = 1, max = 1}



	}}, function(data, menu)
		TriggerServerEvent('skyline_policejob:giveItem', data.current.item, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if hasJob then 
            local pCoords = GetEntityCoords(PlayerPedId())

            if GetDistanceBetweenCoords(pCoords, Config.Weapons, true) > 2.0 and  isInA then 
                SKYLINE.UI.Menu.CloseAll()
                isInA = false 
            end 

            if GetDistanceBetweenCoords(pCoords, Config.Weapons, true) < 2.0 and not isInA then 
                SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ zum Benutzen")

                if IsControlJustPressed(0, 38) then 
                    isInA = true 

                    local elements = {
                        { label = "Lager", value = "lager" },
                        { label = "Waffen kaufen", value = "buy" },
                        { label = "Wichtige Gegenstände", value = "items" }

                    }

                    SKYLINE.UI.Menu.Open("default", GetCurrentResourceName(), "lspd_lager", {
                        title    = "LSPD - Lager",
                        align    = "top-left",
                        elements = elements
                    }, function(data, menu)
                
                        if data.current.value == "buy" then 
                            OpenBuyWeaponsMenu()
                        end 

                        if data.current.value == "lager" then 
                            isInA = false 
                            OpenArmoryMenu()
                        end 

                        if data.current.value == "items" then 
                            OpenPDShop()
                        end 
                  
                   
                    end, function(data, menu)
                        menu.close()
                        isInA = false 
                    end)
                end 
            end 

            if GetDistanceBetweenCoords(pCoords, Config.Weapons, true) < 50.0 then 
                DrawMarker(1,  Config.Weapons.x,  Config.Weapons.y,  Config.Weapons.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 0.3, 0, 0, 255, 255, false, false, 2, false, nil, nil, false)
            end 
        end 
    end 
end)