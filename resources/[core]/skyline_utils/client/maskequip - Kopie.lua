local maskOn = false

local AnimDictionary = "missfbi4"
local AnimName = "takeoff_mask"


Citizen.CreateThread(function()    
    while true do
        Citizen.Wait(0)

        if IsControlJustPressed(0, 244) and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsPedFalling(GetPlayerPed(-1), true) then
            local playerPed = GetPlayerPed(-1)
            maskOn = not maskOn

            if maskOn then
                PlayToggleEmote()

                SetPedComponentVariation(playerPed, 1)
                ClearPedTasks(PlayerPedId())
            else
                PlayToggleEmote()
                
                SKYLINE.TriggerServerCallback('spielerskin:getPlayerSkin', function(skin)
                    TriggerEvent('skinändernduhs:loadSkin', skin)
                end)

                ClearPedTasks(PlayerPedId())
            end
        end
    end
end)

function PlayToggleEmote()
	while not HasAnimDictLoaded(AnimDictionary) do
        RequestAnimDict(AnimDictionary)
        Wait(100)
    end

    local Ped = PlayerPedId()
    local Pause = 900-800 if Pause < 800 then Pause = 800 end
    
	TaskPlayAnim(Ped, AnimDictionary, AnimName, 3.0, 3.0, 800, 51, 0, false, false, false)
	Wait(Pause)
end
