MOVE_UP_KEY = 20
MOVE_DOWN_KEY = 44
CHANGE_SPEED_KEY = 21
MOVE_LEFT_RIGHT = 30
MOVE_UP_DOWN = 31
NOCLIP_TOGGLE_KEY = 82
NO_CLIP_NORMAL_SPEED = 0.5
NO_CLIP_FAST_SPEED = 2.5
ENABLE_TOGGLE_NO_CLIP = true
ENABLE_NO_CLIP_SOUND = true

local eps = 0.01
local RESSOURCE_NAME = GetCurrentResourceName();

local playerPed = nil
local playerId = nil
local noClippingEntity = nil


AddEventHandler('playerSpawned', function(spawn)
    playerPed = PlayerPedId()
    playerId = PlayerId()
    noClippingEntity = playerPed
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        playerPed = PlayerPedId()
        playerId = PlayerId()
        noClippingEntity = playerPed

        Citizen.Wait(2000)
    end 
end)




-- Variables --
local isNoClipping = false

local speed = NO_CLIP_NORMAL_SPEED
local input = vector3(0, 0, 0)
local previousVelocity = vector3(0, 0, 0)
local breakSpeed = 10.0;
local offset = vector3(0, 0, 1);


function ToggleNoClipMode()
    TriggerServerEvent("skyline_admin:noclip", isNoClipping)
    return SetNoClip(not isNoClipping)
end

function IsControlAlwaysPressed(inputGroup, control) return IsControlPressed(inputGroup, control) or IsDisabledControlPressed(inputGroup, control) end

function IsControlAlwaysJustPressed(inputGroup, control) return IsControlJustPressed(inputGroup, control) or IsDisabledControlJustPressed(inputGroup, control) end

function Lerp (a, b, t) return a + (b - a) * t end

function IsPedDrivingVehicle(ped, veh)
    return ped == GetPedInVehicleSeat(veh, -1);
end

function SetInvincible(val, id)
    SetEntityInvincible(id, val)
    return SetPlayerInvincible(id, val)
end


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if IsControlJustPressed(0, 82) then 


            SKYLINE.TriggerServerCallback("skyline_admin:rangcheck", function(group) 
                if group == "sup" or group == "event" or group == "mod" or group == "admin" or group == "dev" or group == "superadmin" or group == "pl" or group == "frak" then 
                    ToggleNoClipMode()
                else 
                    TriggerEvent("skyline_notify:Alert", "SYSTEM" , "Dazu hast du keine Rechte!" , 3000 , "error")
                end 
            end)
        end 

      
    end 

end)

function SetNoClip(val)

    if (isNoClipping ~= val) then

        noClippingEntity = playerPed;

        if IsPedInAnyVehicle(playerPed, false) then
            local veh = GetVehiclePedIsIn(playerPed, false);
            if IsPedDrivingVehicle(playerPed, veh) then
                noClippingEntity = veh;
            end
        end

        local isVeh = IsEntityAVehicle(noClippingEntity);

        isNoClipping = val;

        if ENABLE_NO_CLIP_SOUND then

            if isNoClipping then
                PlaySoundFromEntity(-1, "SELECT", playerPed, "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
            else
                PlaySoundFromEntity(-1, "CANCEL", playerPed, "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
            end

        end

        TriggerEvent('msgprinter:addMessage', ((isNoClipping and ":airplane: No-clip enabled") or ":rock: No-clip disabled"), GetCurrentResourceName());
        SetUserRadioControlEnabled(not isNoClipping);

        if (isNoClipping) then

            TriggerEvent('instructor:add-instruction', { MOVE_LEFT_RIGHT, MOVE_UP_DOWN }, "move", RESSOURCE_NAME);
            TriggerEvent('instructor:add-instruction', { MOVE_UP_KEY, MOVE_DOWN_KEY }, "move up/down", RESSOURCE_NAME);
            TriggerEvent('instructor:add-instruction', { 1, 2 }, "Turn", RESSOURCE_NAME);
            TriggerEvent('instructor:add-instruction', CHANGE_SPEED_KEY, "(hold) fast mode", RESSOURCE_NAME);
            TriggerEvent('instructor:add-instruction', NOCLIP_TOGGLE_KEY, "Toggle No-clip", RESSOURCE_NAME);
            SetEntityAlpha(noClippingEntity, 51, 0)

            -- Start a No CLip thread
            Citizen.CreateThread(function()

                local clipped = noClippingEntity
                local pPed = playerPed;
                local isClippedVeh = isVeh;
                -- We start with no-clip mode because of the above if --
                SetInvincible(true, clipped);

                if not isClippedVeh then
                    ClearPedTasksImmediately(pPed)
                end

                while isNoClipping do
                    Citizen.Wait(0);

                    FreezeEntityPosition(clipped, true);
                    SetEntityCollision(clipped, false, false);

                    SetEntityVisible(clipped, false, false);
                    SetLocalPlayerVisibleLocally(true);
                    SetEntityAlpha(clipped, 51, false)

                    SetEveryoneIgnorePlayer(pPed, true);
                    SetPoliceIgnorePlayer(pPed, true);

                    -- `(a and b) or c`, is basically `a ? b : c` --
                    input = vector3(GetControlNormal(0, MOVE_LEFT_RIGHT), GetControlNormal(0, MOVE_UP_DOWN), (IsControlAlwaysPressed(1, MOVE_UP_KEY) and 1) or ((IsControlAlwaysPressed(1, MOVE_DOWN_KEY) and -1) or 0))
                    speed = ((IsControlAlwaysPressed(1, CHANGE_SPEED_KEY) and NO_CLIP_FAST_SPEED) or NO_CLIP_NORMAL_SPEED) * ((isClippedVeh and 2.75) or 1)

                    MoveInNoClip();

                end

                Citizen.Wait(0);

                FreezeEntityPosition(clipped, false);
                SetEntityCollision(clipped, true, true);

                SetEntityVisible(clipped, true, false);
                SetLocalPlayerVisibleLocally(true);
                ResetEntityAlpha(clipped);

                SetEveryoneIgnorePlayer(pPed, false);
                SetPoliceIgnorePlayer(pPed, false);
                ResetEntityAlpha(clipped);

                Citizen.Wait(500);

                -- We're done with the while so we aren't in no-clip mode anymore --
                -- Wait until the player starts falling or is completely stopped --
                if isClippedVeh then

                    while (not IsVehicleOnAllWheels(clipped)) and not isNoClipping do
                        Citizen.Wait(0);
                    end

                    while not isNoClipping do

                        Citizen.Wait(0);

                        if IsVehicleOnAllWheels(clipped) then

                            -- We hit land. We can safely remove the invincibility --
                            return SetInvincible(false, clipped);

                        end

                    end

                else

                    if (IsPedFalling(clipped) and math.abs(1 - GetEntityHeightAboveGround(clipped)) > eps) then
                        while (IsPedStopped(clipped) or not IsPedFalling(clipped)) and not isNoClipping do
                            Citizen.Wait(0);
                        end
                    end

                    while not isNoClipping do

                        Citizen.Wait(0);

                        if (not IsPedFalling(clipped)) and (not IsPedRagdoll(clipped)) then

                            -- We hit land. We can safely remove the invincibility --
                            return SetInvincible(false, clipped);

                        end

                    end

                end

            end)

        else
            ResetEntityAlpha(noClippingEntity)
            TriggerEvent('instructor:flush', RESSOURCE_NAME);
        end

    end

end

function MoveInNoClip()

    SetEntityRotation(noClippingEntity, GetGameplayCamRot(0), 0, false)
    local forward, right, up, c = GetEntityMatrix(noClippingEntity);
    previousVelocity = Lerp(previousVelocity, (((right * input.x * speed) + (up * -input.z * speed) + (forward * -input.y * speed))), Timestep() * breakSpeed);
    c = c + previousVelocity
    SetEntityCoords(noClippingEntity, c - offset, true, true, true, false)

end

function MoveCarInNoClip()

    SetEntityRotation(noClippingEntity, GetGameplayCamRot(0), 0, false)
    local forward, right, up, c = GetEntityMatrix(noClippingEntity);
    previousVelocity = Lerp(previousVelocity, (((right * input.x * speed) + (up * input.z * speed) + (forward * -input.y * speed))), Timestep() * breakSpeed);
    c = c + previousVelocity
    SetEntityCoords(noClippingEntity, (c - offset) + (vec(0, 0, .3)), true, true, true, false)

end