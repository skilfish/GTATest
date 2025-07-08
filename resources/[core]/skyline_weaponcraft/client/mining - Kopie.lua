local mining = false
local npc = true 

function createPed_3()
	created_ped = CreatePed(0, "u_m_m_partytarget" , 1063.3864, -2003.8312, 31.0147 - 1, 54.0, false)
	FreezeEntityPosition(created_ped, true)
	SetEntityInvincible(created_ped, true)
	SetBlockingOfNonTemporaryEvents(created_ped, true)
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if npc then 
            local coords = GetEntityCoords(PlayerPedId())


            if GetDistanceBetweenCoords(coords , 1063.3864, -2003.8312, 31.0147 , true) < 50 then 
                modelHash = GetHashKey("u_m_m_partytarget")
                RequestModel(modelHash)
                while not HasModelLoaded(modelHash) do
                    Wait(1)
                end
                createPed_3()
    
    
                npc = false
                break
            end
        end 

        
    end 
end)


local isSmelting = false 

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        local pCoords = GetEntityCoords(PlayerPedId())
        
        if GetDistanceBetweenCoords( 1063.3864, -2003.8312, 31.0147 , pCoords , true) < 1.5 and not isSmelting then 
            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um all deine Erze zu schmelzen")
            
            if IsControlJustPressed(0, 38) then 
                isSmelting = true 

                FreezeEntityPosition(PlayerPedId(), true)

                TriggerServerEvent("miningdufotze:smelt")

                
                TriggerEvent("skyline_progressbar:client:progress", {
                    name = "idk",
                    duration = 5000,
                    label = "Visum wird gedruckt...",
                    useWhileDead = false,
                    canCancel = false,
        
        
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                }, function(status)
        
                    if not status then
                        isSmelting = false
                        ClearPedTasksImmediately(PlayerPedId())
                        FreezeEntityPosition(PlayerPedId(), false)

                    end
                      
                end)
            end 
        end 
    end 
end)

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do Wait(0) end
   
    for k, v in pairs(Config.Mining.MiningPositions) do
        addBlip(v.coords, 164, 53, "Mining")
    end 

    addBlip1(1063.3864, -2003.8312, 31.0147, 354, 27, "Schmelze")


    while true do
        local closeTo = 0
        for k, v in pairs(Config.Mining.MiningPositions) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 2.5 then
                closeTo = v
                break
            end
        end
        if type(closeTo) == 'table' then
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 2.5 do
                Wait(0)
                helpText("Drücke ~INPUT_CONTEXT~ um zu Minen.")
                if IsControlJustReleased(0, 38) then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance == -1 or distance >= 3.0 then
                        mining = true
                        SetEntityCoords(PlayerPedId(), closeTo.coords)
                        SetEntityHeading(PlayerPedId(), closeTo.heading)
                        FreezeEntityPosition(PlayerPedId(), true)

                        local model = loadModel(GetHashKey(Config.Mining.Objects['pickaxe']))
                        local axe = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
                        AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)

                        while mining do
                            Wait(0)
                            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'))
                            helpText("Drücke ~INPUT_ATTACK~ zum Minen, ~INPUT_FRONTEND_RRIGHT~ um aufzuhören.")
                            DisableControlAction(0, 24, true)
                            if IsDisabledControlJustReleased(0, 24) then
                                local dict = loadDict('melee@hatchet@streamed_core')
                                TaskPlayAnim(PlayerPedId(), dict, 'plyr_rear_takedown_b', 8.0, -8.0, -1, 2, 0, false, false, false)
                                local timer = GetGameTimer() + 800
                                while GetGameTimer() <= timer do Wait(0) DisableControlAction(0, 24, true) end
                                ClearPedTasks(PlayerPedId())
                                TriggerServerEvent('miningdufotze:getItem')
                            elseif IsControlJustReleased(0, 194) then
                                break
                            end
                        end
                        mining = false
                        DeleteObject(axe)
                        FreezeEntityPosition(PlayerPedId(), false)
                    else
                        TriggerEvent("skyline_notify:Alert", "MINING" , "Du kannst nicht in der Nähe einer anderen Person Minen!" , 3500 , "error")
                    end
                end
            end
        end
        Wait(250)
    end
end)

loadModel = function(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

loadDict = function(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

helpText = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

addBlip = function(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipScale(blip, 0.7)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

addBlip1 = function(x , y , z, sprite, colour, text)
    local blip = AddBlipForCoord(x , y, z)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipScale(blip, 0.9)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end