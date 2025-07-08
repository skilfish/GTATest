SKYLINE = nil

local isVest = false 
local hasJob = false 

Citizen.CreateThread(
    function()
        while SKYLINE == nil do
            TriggerEvent( "skylineistback:getSharedObject",
                function(obj)
                    SKYLINE = obj
                end
            )
            Citizen.Wait(0)
        end
        
        ClearEntityLastDamageEntity(PlayerPedId())
        ClearEntityLastWeaponDamage(PlayerPedId())
end)

-- No vehicle Drops -- 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		DisablePlayerVehicleRewards(PlayerId())
	end
end)
-- No vehicle Drops -- 

Citizen.CreateThread(function()
	while SKYLINE == nil do
		TriggerEvent("skylineistback:getSharedObject", function(obj) SKYLINE = obj end)
		Citizen.Wait(0)
	end

    exports.spawnmanager:setAutoSpawn(false)


	Citizen.Wait(1000)

	SKYLINE.TriggerServerCallback("lsmdistgay:checkJob", function(name) 
		if name == "police" then 
			hasJob = true 
		end 
	end)
end)


RegisterNetEvent("skyline:playerLoaded")
AddEventHandler("skyline:playerLoaded", function(xPlayer)
	if xPlayer.job.name == "police" then 
		hasJob = true  
	end 
end)

RegisterNetEvent("skyline:setJob")
AddEventHandler("skyline:setJob", function(job)
	if job.name == "police" then 
		hasJob = true 
	else 
		hasJob = false 
	end 
end)

-- DAMAGE -- 
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.5) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.34) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"), 0.5) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"), 0.25) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHETE"), 0.7) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SWITCHBLADE"), 0.8) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL"), 0.5) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"), 0.6) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL50"), 0.5) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HEAVYPISTOL"), 0.5)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPDW"), 0.5)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMG"), 0.7)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN"), 0.25)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE"), 2.0)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ADVANCEDRIFLE"), 0.55)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SPECIALCARBINE"), 0.8)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GUSENBERG"), 0.9)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNIPERIFLE"), 0.9)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MARKSMANRIFLE"), 0.6)

    end
end)

Citizen.CreateThread( function()
    while true do
      Citizen.Wait(1)		
      local playerPed = GetPlayerPed(-1)
      local playerVeh = GetVehiclePedIsUsing(playerPed)
  
      if gPlayerVeh ~= 0 then RemovePedHelmet(playerPed,true) end
     end	
end)


local parts = {
    [0]     = 'NONE',
    [31085] = 'HEAD',
    [31086] = 'HEAD',
    [39317] = 'NECK',
    [57597] = 'SPINE',
    [23553] = 'SPINE',
    [24816] = 'SPINE',
    [24817] = 'SPINE',
    [24818] = 'SPINE',
    [10706] = 'UPPER_BODY',
    [64729] = 'UPPER_BODY',
    [11816] = 'LOWER_BODY',
    [45509] = 'LARM',
    [61163] = 'LARM',
    [18905] = 'LHAND',
    [4089] = 'LFINGER',
    [4090] = 'LFINGER',
    [4137] = 'LFINGER',
    [4138] = 'LFINGER',
    [4153] = 'LFINGER',
    [4154] = 'LFINGER',
    [4169] = 'LFINGER',
    [4170] = 'LFINGER',
    [4185] = 'LFINGER',
    [4186] = 'LFINGER',
    [26610] = 'LFINGER',
    [26611] = 'LFINGER',
    [26612] = 'LFINGER',
    [26613] = 'LFINGER',
    [26614] = 'LFINGER',
    [58271] = 'LLEG',
    [63931] = 'LLEG',
    [2108] = 'LFOOT',
    [14201] = 'LFOOT',
    [40269] = 'RARM',
    [28252] = 'RARM',
    [57005] = 'RHAND',
    [58866] = 'RFINGER',
    [58867] = 'RFINGER',
    [58868] = 'RFINGER',
    [58869] = 'RFINGER',
    [58870] = 'RFINGER',
    [64016] = 'RFINGER',
    [64017] = 'RFINGER',
    [64064] = 'RFINGER',
    [64065] = 'RFINGER',
    [64080] = 'RFINGER',
    [64081] = 'RFINGER',
    [64096] = 'RFINGER',
    [64097] = 'RFINGER',
    [64112] = 'RFINGER',
    [64113] = 'RFINGER',
    [36864] = 'RLEG',
    [51826] = 'RLEG',
    [20781] = 'RFOOT',
    [52301] = 'RFOOT',
}

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
      

        if HasPedBeenDamagedByWeapon(PlayerPedId(), 0, 2) then 
            local hit, bone = GetPedLastDamageBone(PlayerPedId())
            local bodypart = parts[bone]

            if bodypart == "HEAD" then 
               ApplyDamageToPed(PlayerPedId(), 15, true)
            

            end 

            ClearEntityLastDamageEntity(PlayerPedId())
            ClearEntityLastWeaponDamage(PlayerPedId())
           
        end 

    end 
end)

Citizen.CreateThread( function()
    while true do
       Citizen.Wait(0)
       RestorePlayerStamina(PlayerId(), 1.0)
    end    
end)



-- weapon switch -- 
local lastweapon = ""

CreateThread(function()
    while true do
        Wait(0)
        local weapon = GetSelectedPedWeapon(PlayerPedId())
        if weapon ~= lastweapon then
            lastweapon = weapon
            SetCurrentPedWeapon(PlayerPedId(),  GetSelectedPedWeapon(PlayerPedId()), true)
            RefillAmmoInstantly(PlayerPedId())
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local ped = PlayerPedId()

        SetPedSuffersCriticalHits(ped, false)
        StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
  

        if IsPedArmed(ped, 6) then
	       DisableControlAction(1, 140, true)
       	   DisableControlAction(1, 141, true)
           DisableControlAction(1, 142, true)
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if IsPedInAnyVehicle(PlayerPedId(), 0) then 
            local veh = GetVehiclePedIsIn(PlayerPedId(), 0)

            SetPedConfigFlag(PlayerPedId(), 184, true)

            if GetIsTaskActive(PlayerPedId(), 165) then
				--getting seat player is in 
				seat=0
				if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
					seat=-1
				end
			
				SetPedIntoVehicle(PlayerPedId(), veh, seat)
			end
                        
            SetVehicleMaxSpeed(veh, 97.2)
        end 
    end 
end)

-- DAMAGE -- 

-- TAZER -- 
local tiempo = 4000 -- 1000 ms = 1s
local isTaz = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if IsPedBeingStunned(GetPlayerPed(-1)) then
			
			SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)
			
		end
		
		if IsPedBeingStunned(GetPlayerPed(-1)) and not isTaz then
			
			isTaz = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
			
		elseif not IsPedBeingStunned(GetPlayerPed(-1)) and isTaz then
			isTaz = false
			Wait(5000)
			
			SetTimecycleModifier("hud_def_desat_Trevor")
			
			Wait(1000 * 21)
			
            SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
		end
	end
end)

local blocked = false 
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if isTaz and not blocked then 
            blocked = true
        end 

        if blocked then 
            DisablePlayerFiring(PlayerPedId(), true) 
            BlockWeaponWheelThisFrame()
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 199, true) 
            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
        end 
    end 
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if blocked then 
            Citizen.Wait(1000 * 30)
            blocked = false 
        end  
    end 
end)
-- TAZER -- 

-- VARIABLE(S)
local crouched = false


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        DisableControlAction(0, 36, false)

        if IsDisabledControlJustReleased(0, 36) then 
            TriggerEvent("playerCrouch")
        end 

    end 

end)

-- CROUCH -- 

-- Register the network event(s)
RegisterNetEvent( 'playerCrouch' )

-- The main event handler 
AddEventHandler( 'playerCrouch', function()
    -- Get the local ped 
    local ped = GetPlayerPed( -1 )

    -- Make sure the player is alive
    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 

        -- Here we create thread, but notice how we don't have a while loop.
        -- This is because we use it to Wait for the animation dictionary to load.
        Citizen.CreateThread( function()        
            -- Request the crouched animation set     
            RequestAnimSet( "move_ped_crouched" )

            -- Wait until it has loaded 
            while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                Citizen.Wait( 100 )
            end 

            -- We inverse the crouch variable for the next time it is called 
            if ( crouched == true ) then 
                ResetPedMovementClipset( ped, 0 )
                crouched = false 
            elseif ( crouched == false ) then
                SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                crouched = true 
            else
                Citizen.Trace( "Crouch Script Error: variable 'crouched' not found or not a boolean value." )
            end 
        end )
    end 
end )

-- CROCUH -- 

-- Munition -- 
RegisterNetEvent("skyline_utils:tryToUseMunition")
AddEventHandler("skyline_utils:tryToUseMunition", function()
    
    if IsPedArmed(PlayerPedId(), 4) then 
        TriggerServerEvent("skyline_utils:useMunition", GetSelectedPedWeapon(PlayerPedId()))
        TriggerEvent("skyline_notify:Alert", "TASCHE" , "Munition benutzt." , 4000 , "success")

    else 
        TriggerEvent("skyline_notify:Alert", "TASCHE" , "Du musst eine Waffe in die Hand nehmen." , 4000 , "error")
    end 
end)

-- Munition -- 

-- vest -- 
RegisterNetEvent("skyline_utils:tryToUseVest")
AddEventHandler("skyline_utils:tryToUseVest", function(vest)
    
    if not isVest then 
        isVest = true 

        TriggerEvent("skyline_progressbar:client:progress", {
            name = "printer_einreiseamt",
            duration = 5000,
            label = "Visum wird gedruckt...",
            useWhileDead = false,
            canCancel = false,

            animation = {
                animDict = "anim@heists@narcotics@funding@gang_idle",
                anim = "gang_chatting_idle01",
            },

            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(status)

            if not status then
                isVest = false
                ClearPedTasksImmediately(PlayerPedId())

                if vest ==  "light" then 
                    AddArmourToPed(PlayerPedId(), 20)
                    SetPedComponentVariation(PlayerPedId(), 9, 6, 0, 0)
                    TriggerServerEvent("skyline_utils:useVest" , "vest_light")

                elseif vest == "normal" then
                    AddArmourToPed(PlayerPedId(), 50)
                    SetPedComponentVariation(PlayerPedId(), 9, 6, 0, 0)
                    TriggerServerEvent("skyline_utils:useVest" , "vest_normal")

                elseif vest == "heavy"then
                TriggerServerEvent("skyline_utils:useVest" , "vest_heavy")

                    AddArmourToPed(PlayerPedId(), 100)
                    SetPedComponentVariation(PlayerPedId(), 9, 6, 0, 0)
                end 
            end
              
        end)
        
    end 
end)

RegisterNetEvent("skyline_utils:tryToUseLSPDVest")
AddEventHandler("skyline_utils:tryToUseLSPDVest", function()
    
    if not isVest then 
        isVest = true 

        TriggerEvent("skyline_progressbar:client:progress", {
            name = "printer_einreiseamt",
            duration = 5000,
            label = "Visum wird gedruckt...",
            useWhileDead = false,
            canCancel = false,

            animation = {
                animDict = "anim@heists@narcotics@funding@gang_idle",
                anim = "gang_chatting_idle01",
            },
           
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(status)

            if not status then
                isVest = false
                ClearPedTasksImmediately(PlayerPedId())
                AddArmourToPed(PlayerPedId(), 100)
                SetPedComponentVariation(PlayerPedId(), 9, 21, 0, 0)
                TriggerServerEvent("skyline_utils:useVest" , "vest_lspd")

                 
            end
              
        end)
        
    end 
end)
-- vest -- 

RegisterNetEvent("skyline_utils:tryToUseSchwamm")
AddEventHandler("skyline_utils:tryToUseSchwamm", function()
    local playerPed		= PlayerPedId()
	local coords		= GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 2.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)

			Citizen.CreateThread(function()
				

				Citizen.Wait(2 * 1000)

				if CurrentAction ~= nil then
                    SetVehicleDirtLevel(vehicle, 0.1)
					ClearPedTasksImmediately(playerPed)

					TriggerEvent("skyline_notify:Alert", "TASCHE" , "Wäsche erfolgreich beendet" , 2500 , "success")
				end

				TriggerServerEvent('skyline_utils:removeSchwamm')
				
                ClearPedTasks(PlayerPedId())
				TerminateThisThread()
			end)
		

		Citizen.CreateThread(function()
			Citizen.Wait(0)

			if CurrentAction ~= nil then
				SetTextComponentFormat('STRING')
				AddTextComponentString("Drücke ~g~[~r~X~g~]~w~ zum abbrechen")
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, 73) then
					TerminateThread(ThreadID)
                    ClearPedTasks(PlayerPedId())
					TriggerEvent("skyline_notify:Alert", "TASCHE" , "Reperatur abgebrochen!" , 2500 , "error")
					CurrentAction = nil
				end
			end

		end)
	else
        TriggerEvent("skyline_notify:Alert", "TASCHE" , "Kein Fahrzeug in der Nähe!" , 2500 , "error")
	end 
   
end)

-- Repairkit -- 
local CurrentAction = ""
local ThreadID = ""

RegisterNetEvent("skyline_utils:tryToUseRepairkit")
AddEventHandler("skyline_utils:tryToUseRepairkit", function()
    local playerPed		= PlayerPedId()
	local coords		= GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 2.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)

			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
				CurrentAction = 'repair'

				Citizen.Wait(5 * 1000)

				if CurrentAction ~= nil then
					SetVehicleFixed(vehicle)
					SetVehicleDeformationFixed(vehicle)
					SetVehicleUndriveable(vehicle, false)
					SetVehicleEngineOn(vehicle, true, true)
					ClearPedTasksImmediately(playerPed)

					TriggerEvent("skyline_notify:Alert", "TASCHE" , "Reperatur erfolgreich beendet" , 2500 , "success")
				end

				TriggerServerEvent('skyline_utils:removeKit')
				
                ClearPedTasks(PlayerPedId())
				CurrentAction = nil
				TerminateThisThread()
			end)
		

		Citizen.CreateThread(function()
			Citizen.Wait(0)

			if CurrentAction ~= nil then
				SetTextComponentFormat('STRING')
				AddTextComponentString("Drücke ~g~[~r~X~g~]~w~ zum abbrechen")
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, 73) then
					TerminateThread(ThreadID)
                    ClearPedTasks(PlayerPedId())
					TriggerEvent("skyline_notify:Alert", "TASCHE" , "Reperatur abgebrochen!" , 2500 , "error")
					CurrentAction = nil
				end
			end

		end)
	else
        TriggerEvent("skyline_notify:Alert", "TASCHE" , "Kein Fahrzeug in der Nähe!" , 2500 , "error")
	end 
   
end)

-- -- Repairkit -- 

-- Point Finger -- 
local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)
-- Point Finger -- 

-- Hands Up -- 
Citizen.CreateThread(function()
    local dict = "missminuteman_1ig_2"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 74) and not IsPedInAnyVehicle(PlayerPedId(), 0) then --Start holding X
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)
-- Hands Up --

-- MD & PD Blips -- 
local blips = {
    {title = "LSPD" , colour = 3 , id = 60 , x = 432.5335 , y = -981.7633 , z = 30.7109},
    {title = "LSMD" , colour = 1 , id = 61 , x = 298.9090 , y = -584.0751, z = 43.2608}

 }
     
Citizen.CreateThread(function()
   for _, info in pairs(blips) do
     info.blip = AddBlipForCoord(info.x, info.y, info.z)
     SetBlipSprite(info.blip, info.id)
     SetBlipDisplay(info.blip, 4)
     SetBlipScale(info.blip, 1.0)
     SetBlipColour(info.blip, info.colour)
     SetBlipAsShortRange(info.blip, true)
     BeginTextCommandSetBlipName("STRING")
     AddTextComponentString(info.title)
     EndTextCommandSetBlipName(info.blip)
   end
end)
-- MD & PD Blip -- 

-- PD Waffenkammer -- 
SKYLINE = nil

local isVest = false 


Citizen.CreateThread(
    function()
        while SKYLINE == nil do
            TriggerEvent( "skylineistback:getSharedObject",
                function(obj)
                    SKYLINE = obj
                end
            )
            Citizen.Wait(0)
        end
        
        ClearEntityLastDamageEntity(PlayerPedId())
        ClearEntityLastWeaponDamage(PlayerPedId())
end)

-- No vehicle Drops -- 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		DisablePlayerVehicleRewards(PlayerId())
	end
end)
-- No vehicle Drops -- 


-- DAMAGE -- 
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.5) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.34) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"), 0.5) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"), 0.25) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHETE"), 0.7) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SWITCHBLADE"), 0.8) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL"), 0.5) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"), 0.6) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL50"), 0.5) 
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HEAVYPISTOL"), 0.5)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPDW"), 0.5)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMG"), 0.7)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN"), 0.25)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE"), 0.6)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE"), 0.9)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ADVANCEDRIFLE"), 0.55)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SPECIALCARBINE"), 0.8)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GUSENBERG"), 0.9)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNIPERIFLE"), 0.9)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MARKSMANRIFLE"), 0.6)

    end
end)

Citizen.CreateThread( function()
    while true do
      Citizen.Wait(1)		
      local playerPed = GetPlayerPed(-1)
      local playerVeh = GetVehiclePedIsUsing(playerPed)
  
      if gPlayerVeh ~= 0 then RemovePedHelmet(playerPed,true) end
     end	
end)


local parts = {
    [0]     = 'NONE',
    [31085] = 'HEAD',
    [31086] = 'HEAD',
    [39317] = 'NECK',
    [57597] = 'SPINE',
    [23553] = 'SPINE',
    [24816] = 'SPINE',
    [24817] = 'SPINE',
    [24818] = 'SPINE',
    [10706] = 'UPPER_BODY',
    [64729] = 'UPPER_BODY',
    [11816] = 'LOWER_BODY',
    [45509] = 'LARM',
    [61163] = 'LARM',
    [18905] = 'LHAND',
    [4089] = 'LFINGER',
    [4090] = 'LFINGER',
    [4137] = 'LFINGER',
    [4138] = 'LFINGER',
    [4153] = 'LFINGER',
    [4154] = 'LFINGER',
    [4169] = 'LFINGER',
    [4170] = 'LFINGER',
    [4185] = 'LFINGER',
    [4186] = 'LFINGER',
    [26610] = 'LFINGER',
    [26611] = 'LFINGER',
    [26612] = 'LFINGER',
    [26613] = 'LFINGER',
    [26614] = 'LFINGER',
    [58271] = 'LLEG',
    [63931] = 'LLEG',
    [2108] = 'LFOOT',
    [14201] = 'LFOOT',
    [40269] = 'RARM',
    [28252] = 'RARM',
    [57005] = 'RHAND',
    [58866] = 'RFINGER',
    [58867] = 'RFINGER',
    [58868] = 'RFINGER',
    [58869] = 'RFINGER',
    [58870] = 'RFINGER',
    [64016] = 'RFINGER',
    [64017] = 'RFINGER',
    [64064] = 'RFINGER',
    [64065] = 'RFINGER',
    [64080] = 'RFINGER',
    [64081] = 'RFINGER',
    [64096] = 'RFINGER',
    [64097] = 'RFINGER',
    [64112] = 'RFINGER',
    [64113] = 'RFINGER',
    [36864] = 'RLEG',
    [51826] = 'RLEG',
    [20781] = 'RFOOT',
    [52301] = 'RFOOT',
}

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
      

        if HasPedBeenDamagedByWeapon(PlayerPedId(), 0, 2) then 
            local hit, bone = GetPedLastDamageBone(PlayerPedId())
            local bodypart = parts[bone]

            if bodypart == "HEAD" then 
               ApplyDamageToPed(PlayerPedId(), 15, true)
             
            end 

            ClearEntityLastDamageEntity(PlayerPedId())
            ClearEntityLastWeaponDamage(PlayerPedId())
           
        end 

    end 
end)

Citizen.CreateThread( function()
    while true do
       Citizen.Wait(0)
       RestorePlayerStamina(PlayerId(), 1.0)
    end    
end)



-- weapon switch -- 
local lastweapon = ""

CreateThread(function()
    while true do
        Wait(0)

        
            local weapon = GetSelectedPedWeapon(PlayerPedId())
            if weapon ~= lastweapon then
                lastweapon = weapon
                SetCurrentPedWeapon(PlayerPedId(),  GetSelectedPedWeapon(PlayerPedId()), true)
                RefillAmmoInstantly(PlayerPedId())
            end
         
       
    end
end)

local isInVehicle = false
local isEnteringVehicle = false
local currentVehicle = 0
local currentSeat = 0
local wep = nil 

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local ped = PlayerPedId()

		if not isInVehicle and not IsPlayerDead(PlayerId()) then
			if DoesEntityExist(GetVehiclePedIsTryingToEnter(ped)) and not isEnteringVehicle then
				local vehicle = GetVehiclePedIsTryingToEnter(ped)
				local seat = GetSeatPedIsTryingToEnter(ped)
				local netId = VehToNet(vehicle)
				isEnteringVehicle = true

                wep = GetSelectedPedWeapon(PlayerPedId())
            

			elseif not DoesEntityExist(GetVehiclePedIsTryingToEnter(ped)) and not IsPedInAnyVehicle(ped, true) and isEnteringVehicle then
				isEnteringVehicle = false
                wep = nil 
			elseif IsPedInAnyVehicle(ped, false) then
				isEnteringVehicle = false
				isInVehicle = true
				currentVehicle = GetVehiclePedIsUsing(ped)
				local model = GetEntityModel(currentVehicle)
				local name = GetDisplayNameFromVehicleModel()
				local netId = VehToNet(currentVehicle)
			end
		elseif isInVehicle then
			if not IsPedInAnyVehicle(ped, false) or IsPlayerDead(PlayerId()) then
				local model = GetEntityModel(currentVehicle)
				local name = GetDisplayNameFromVehicleModel()
				local netId = VehToNet(currentVehicle)
				

                if wep == nil then 
                    SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
                else 
                    SetCurrentPedWeapon(PlayerPedId(), wep, true)
                    wep = nil 
                end 

				isInVehicle = false
				currentVehicle = 0
				currentSeat = 0
			end
		end
		Citizen.Wait(50)
	end
end)





Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local ped = PlayerPedId()

        SetPedSuffersCriticalHits(ped, false)
        StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
  

        if IsPedArmed(ped, 6) then
	       DisableControlAction(1, 140, true)
       	   DisableControlAction(1, 141, true)
           DisableControlAction(1, 142, true)
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if IsPedInAnyVehicle(PlayerPedId(), 0) then 
            local veh = GetVehiclePedIsIn(PlayerPedId(), 0)

            SetPedConfigFlag(PlayerPedId(), 184, true)

            if GetIsTaskActive(PlayerPedId(), 165) then
				--getting seat player is in 
				seat=0
				if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
					seat=-1
				end
			
				SetPedIntoVehicle(PlayerPedId(), veh, seat)
			end
                        
            SetVehicleMaxSpeed(veh, 97.2)
        end 
    end 
end)

-- DAMAGE -- 

-- TAZER -- 
local tiempo = 4000 -- 1000 ms = 1s
local isTaz = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if IsPedBeingStunned(GetPlayerPed(-1)) then
			
			SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)
			
		end
		
		if IsPedBeingStunned(GetPlayerPed(-1)) and not isTaz then
			
			isTaz = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
			
		elseif not IsPedBeingStunned(GetPlayerPed(-1)) and isTaz then
			isTaz = false
			Wait(5000)
			
			SetTimecycleModifier("hud_def_desat_Trevor")
			
			Wait(1000 * 21)
			
            SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
		end
	end
end)

local blocked = false 
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if isTaz and not blocked then 
            blocked = true
        end 

        if blocked then 
            DisablePlayerFiring(PlayerPedId(), true) 
            BlockWeaponWheelThisFrame()
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 199, true) 
            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
        end 
    end 
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if blocked then 
            Citizen.Wait(1000 * 30)
            blocked = false 
        end  
    end 
end)
-- TAZER -- 

-- VARIABLE(S)
local crouched = false


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        DisableControlAction(0, 36, false)

        if IsDisabledControlJustReleased(0, 36) then 
            TriggerEvent("playerCrouch")
        end 

    end 

end)

-- CROUCH -- 

-- Register the network event(s)
RegisterNetEvent( 'playerCrouch' )

-- The main event handler 
AddEventHandler( 'playerCrouch', function()
    -- Get the local ped 
    local ped = GetPlayerPed( -1 )

    -- Make sure the player is alive
    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 

        -- Here we create thread, but notice how we don't have a while loop.
        -- This is because we use it to Wait for the animation dictionary to load.
        Citizen.CreateThread( function()        
            -- Request the crouched animation set     
            RequestAnimSet( "move_ped_crouched" )

            -- Wait until it has loaded 
            while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                Citizen.Wait( 100 )
            end 

            -- We inverse the crouch variable for the next time it is called 
            if ( crouched == true ) then 
                ResetPedMovementClipset( ped, 0 )
                crouched = false 
            elseif ( crouched == false ) then
                SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                crouched = true 
            else
                Citizen.Trace( "Crouch Script Error: variable 'crouched' not found or not a boolean value." )
            end 
        end )
    end 
end )

-- CROCUH -- 

-- Munition -- 

-- Munition -- 

-- vest -- 
RegisterNetEvent("skyline_utils:tryToUseVest")
AddEventHandler("skyline_utils:tryToUseVest", function(vest)
    
    if not isVest then 
        isVest = true 

        TriggerEvent("skyline_progressbar:client:progress", {
            name = "printer_einreiseamt",
            duration = 5000,
            label = "Visum wird gedruckt...",
            useWhileDead = false,
            canCancel = false,

            animation = {
                animDict = "anim@heists@narcotics@funding@gang_idle",
                anim = "gang_chatting_idle01",
            },

            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(status)

            if not status then
                isVest = false
                ClearPedTasksImmediately(PlayerPedId())

                if vest ==  "light" then 
                    AddArmourToPed(PlayerPedId(), 20)
                    SetPedComponentVariation(PlayerPedId(), 9, 6, 0, 0)
                    TriggerServerEvent("skyline_utils:useVest" , "vest_light")

                elseif vest == "normal" then
                    AddArmourToPed(PlayerPedId(), 50)
                    SetPedComponentVariation(PlayerPedId(), 9, 6, 0, 0)
                    TriggerServerEvent("skyline_utils:useVest" , "vest_normal")

                elseif vest == "heavy"then
                TriggerServerEvent("skyline_utils:useVest" , "vest_heavy")

                    AddArmourToPed(PlayerPedId(), 100)
                    SetPedComponentVariation(PlayerPedId(), 9, 6, 0, 0)
                end 
            end
              
        end)
        
    end 
end)

RegisterNetEvent("skyline_utils:tryToUseLSPDVest")
AddEventHandler("skyline_utils:tryToUseLSPDVest", function()
    
    if not isVest then 
        isVest = true 

        TriggerEvent("skyline_progressbar:client:progress", {
            name = "printer_einreiseamt",
            duration = 5000,
            label = "Visum wird gedruckt...",
            useWhileDead = false,
            canCancel = false,

            animation = {
                animDict = "anim@heists@narcotics@funding@gang_idle",
                anim = "gang_chatting_idle01",
            },
           
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(status)

            if not status then
                isVest = false
                ClearPedTasksImmediately(PlayerPedId())
                AddArmourToPed(PlayerPedId(), 100)
                SetPedComponentVariation(PlayerPedId(), 9, 21, 0, 0)
                TriggerServerEvent("skyline_utils:useVest" , "vest_lspd")
                 
            end
              
        end)
        
    end 
end)

RegisterNetEvent("skyline_utils:tryToUseMedikit")
AddEventHandler("skyline_utils:tryToUseMedikit", function()
    
    if not isVest then 
        isVest = true 

        TriggerEvent("skyline_progressbar:client:progress", {
            name = "printer_einreiseamt",
            duration = 5000,
            label = "Visum wird gedruckt...",
            useWhileDead = false,
            canCancel = false,

            animation = {
                animDict = "anim@heists@narcotics@funding@gang_idle",
                anim = "gang_chatting_idle01",
            },
           
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(status)

            if not status then
                isVest = false
                ClearPedTasksImmediately(PlayerPedId())
                TriggerServerEvent("skyline_utils:useVest" , "medikit")
                SetEntityHealth(PlayerPedId(), 200)

                 
            end
              
        end)
        
    end 
end)
-- vest -- 





-- Point Finger -- 
local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)
-- Point Finger -- 

-- Hands Up -- 
Citizen.CreateThread(function()
    local dict = "missminuteman_1ig_2"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 74) and not IsPedInAnyVehicle(PlayerPedId(), 0) then --Start holding X
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)
-- Hands Up --

-- MD & PD Blips -- 
local blips = {
    {title = "LSPD" , colour = 3 , id = 60 , x = 432.5335 , y = -981.7633 , z = 30.7109},
    {title = "LSMD" , colour = 1 , id = 61 , x = 298.9090 , y = -584.0751, z = 43.2608}

 }
     
Citizen.CreateThread(function()
   for _, info in pairs(blips) do
     info.blip = AddBlipForCoord(info.x, info.y, info.z)
     SetBlipSprite(info.blip, info.id)
     SetBlipDisplay(info.blip, 4)
     SetBlipScale(info.blip, 1.0)
     SetBlipColour(info.blip, info.colour)
     SetBlipAsShortRange(info.blip, true)
     BeginTextCommandSetBlipName("STRING")
     AddTextComponentString(info.title)
     EndTextCommandSetBlipName(info.blip)
   end
end)
-- MD & PD Blip -- 

-- PD Waffenkammer -- 


-- carry -- 
local carry = {
	InProgress = false,
	targetSrc = -1,
	type = "",
	personCarrying = {
		animDict = "missfinale_c2mcs_1",
		anim = "fin_c2_mcs_1_camman",
		flag = 49,
	},
	personCarried = {
		animDict = "nm",
		anim = "firemans_carry",
		attachX = 0.27,
		attachY = 0.15,
		attachZ = 0.63,
		flag = 33,
	}
}

local function drawNativeNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local function GetClosestPlayer(radius)
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _,playerId in ipairs(players) do
        local targetPed = GetPlayerPed(playerId)
        if targetPed ~= playerPed then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(targetCoords-playerCoords)
            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = playerId
                closestDistance = distance
            end
        end
    end
	if closestDistance ~= -1 and closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

local function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end        
    end
    return animDict
end

RegisterCommand("carry",function(source, args)
	if not carry.InProgress then
		local closestPlayer = GetClosestPlayer(3)
		if closestPlayer then
			local targetSrc = GetPlayerServerId(closestPlayer)
			if targetSrc ~= -1 then
				carry.InProgress = true
				carry.targetSrc = targetSrc
				TriggerServerEvent("tragen:sync",targetSrc)
				ensureAnimDict(carry.personCarrying.animDict)
				carry.type = "carrying"
			else
			--	drawNativeNotification("~r~Es ist niemand in der Nähe!")
			end
		else
           -- drawNativeNotification("~r~Es ist niemand in der Nähe!")
		end
	else
		carry.InProgress = false
		ClearPedSecondaryTask(PlayerPedId())
		DetachEntity(PlayerPedId(), true, false)
		TriggerServerEvent("tragen:stop",carry.targetSrc)
		carry.targetSrc = 0
	end
end,false)

RegisterNetEvent("tragen:syncTarget")
AddEventHandler("tragen:syncTarget", function(targetSrc)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	carry.InProgress = true
	ensureAnimDict(carry.personCarried.animDict)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
	carry.type = "beingcarried"
end)

RegisterNetEvent("tragen:cl_stop")
AddEventHandler("tragen:cl_stop", function()
	carry.InProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
	while true do
		if carry.InProgress then
			if carry.type == "beingcarried" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, 100000, carry.personCarried.flag, 0, false, false, false)
				end
			elseif carry.type == "carrying" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, 100000, carry.personCarrying.flag, 0, false, false, false)
				end
			end
		end
		Wait(0)
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