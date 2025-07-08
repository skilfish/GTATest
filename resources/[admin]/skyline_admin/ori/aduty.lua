local hasAduty = false 

RegisterKeyMapping("aduty", "Aduty-Hotkey", "keyboard", "")

RegisterCommand("aduty", function(source , args)
    SKYLINE.TriggerServerCallback("skyline_admin:rangcheck", function(group) 
        
        if group ~= "user" then 
            TriggerEvent("skyline_admin:aduty" , group)
        else 
            TriggerEvent("skyline_notify:Alert", "ADMIN-SYSTEM" , "<b style=color:red;>Dazu hast du keine Rechte!" , 3000 , "error")
        end 
    end)
end, false)


RegisterNetEvent("skyline_admin:aduty")
AddEventHandler("skyline_admin:aduty", function(group)
    local playerPed = GetPlayerPed(-1)

    if not hasAduty then 
        TriggerEvent("skinändernduhs:getSkin", function(skin)
            if group == "superadmin" then 
                hasAduty = true

                if skin.sex == 0 then   
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.superadmin.male)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!" , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                else 
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.superadmin.female)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!"  , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                end 
            end 

            if group == "pl" then 
                hasAduty = true

                if skin.sex == 0 then   
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.pl.male)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!" , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                else 
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.pl.female)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!"  , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                end 
            end 

            if group == "frak" then 
                hasAduty = true

                if skin.sex == 0 then   
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.frak.male)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!"  , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                else 
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.frak.female)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!"  , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                end 
            end 

            if group == "mod" then 
                hasAduty = true

                if skin.sex == 0 then   
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.mod.male)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!"  , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                else 
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.mod.female)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!"  , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                end 
            end 

            if group == "admin" then 
                hasAduty = true

                if skin.sex == 0 then   
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.admin.male)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!"  , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                else 
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.admin.female)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!"  , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                end 
            end 

            if group == "sup" then 
                hasAduty = true

                if skin.sex == 0 then   
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.sup.male)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!"  , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                else 
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.sup.female)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!"  , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                end 
            end 

            if group == "event" then 
                hasAduty = true

                if skin.sex == 0 then   
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.event.male)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!"  , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                else 
                    TriggerEvent("skinändernduhs:loadClothes", skin, Config.Adutys.event.female)
                    TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:green;>Aduty geladen!"  , 2000 , "success")
                    SetEntityInvincible(playerPed, true)
                end 
            end 
        end)
    else 
        TriggerEvent("skyline_notify:Alert","ADMIN-SYSTEM" , "<b style=color:red;>Aduty entfernt!"  , 2000 , "error")
        hasAduty = false

        SKYLINE.TriggerServerCallback("spielerskin:getPlayerSkin", function(skin)
            TriggerEvent("skinändernduhs:loadSkin", skin)
        end)
    end 

end)

Citizen.CreateThread(function() 
	while true do
		Citizen.Wait(1)

		if hasAduty then
			SetEntityInvincible(GetPlayerPed(-1), true)
			SetPlayerInvincible(PlayerId(), true)
			SetPedCanRagdoll(GetPlayerPed(-1), false)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			--SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), false)
		elseif not hasAduty then
			SetEntityInvincible(GetPlayerPed(-1), false)
			SetPlayerInvincible(PlayerId(), false)
			SetPedCanRagdoll(GetPlayerPed(-1), true)
		--	SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
			SetEntityCanBeDamaged(GetPlayerPed(-1), true)
		end
	end
end)