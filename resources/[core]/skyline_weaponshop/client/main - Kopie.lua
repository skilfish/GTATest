ESX = nil

Loaded = false
local display = false


Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "skylineistback:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end

    end
)


RegisterNetEvent("skyline:setJob")
AddEventHandler(
    "skyline:setJob",
    function(j)
        job = j.name
        grade = j.grade
    end
)


RegisterNetEvent('skyline:onPlayerSpawn')
AddEventHandler('skyline:onPlayerSpawn', function()

    Citizen.Wait(3000)
    Loaded = true

 
end)



RegisterNUICallback("close", function(data)
    TriggerScreenblurFadeOut(1000)
    SetNuiFocus(false, false)
    display = false
end)


Citizen.CreateThread(function()
	for k,v in pairs(Config.WeaponShopCoords) do
		
		local blip = AddBlipForCoord(v)

        SetBlipAsShortRange(blip, true)
        SetBlipSprite(blip, Config.BlipSprite)                                                                                
        SetBlipDisplay(blip, 4)
        SetBlipColour(blip, Config.BlipColor)
        SetBlipScale(blip, 0.9)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Waffenladen")
        EndTextCommandSetBlipName(blip)
        
        
    end
end)

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(0)
        
        for _,v in ipairs(Config.WeaponShopCoords) do
            local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), false), v)
            if distance < 10.0 then 
                DrawText3D(v[1],v[2], v[3] , Config.Text['hologram'])
                if (IsControlJustReleased(0, 38) and distance < 3.0) then 
                    if display == false then                       
                        SetDisplay(true, "WeaponShop")
                    end
                end
            end  
        end
      
    end
end)


function SetDisplay(bool, shop)
        display = bool
        SetNuiFocus(bool, bool)
        TriggerScreenblurFadeIn(1000)
        ESX.TriggerServerCallback('waffenladenfickteuretoten:getLoadout', function(loadout)
            SendNUIMessage({
                type="show",
                config = Config,
                loadout = loadout,
                shoptype = shop
            })  
        end)
   
end


RegisterNetEvent("waffenladenfickteuretoten:sendMessage")
AddEventHandler("waffenladenfickteuretoten:sendMessage",function(msg , type)

    TriggerEvent("skyline_notify:Alert", "WAFFENLADEN", msg , 3000 , type)
    
end)


RegisterNUICallback("buyGun", function(data)

    local gun = data["gun"]
    local money = data["money"]

    TriggerServerEvent('waffenladenfickteuretoten:buyGun', gun, money)
    
end)    

RegisterNUICallback("buyExplosive", function(data)

    local explosive = data["explosive"]
    local money = data["money"]
    local hash = GetHashKey(explosive)
    local ped = PlayerPedId()



    ESX.TriggerServerCallback('waffenladenfickteuretoten:getMoney', function(pedmoney)
        if pedmoney >= tonumber(money) then
            if GetAmmoInPedWeapon(ped, hash) < 25 then

                TriggerServerEvent('waffenladenfickteuretoten:buyExplosive', explosive, money)
                    
            else
                SendTextMessage(Config.Text["maxexplosive"])          
            end
        else
            SendTextMessage(Config.Text["missingmoney"]) 
        end                   
    end)    
end)    
 


RegisterNUICallback("buyMelee", function(data)
    
    local melee = data["melee"]
    local money = data["money"]
    
    TriggerServerEvent('waffenladenfickteuretoten:buyMelee', melee, money)
        
end)   


RegisterNUICallback("buyAmmo", function(data)

    local money = data["money"]
    local amount = data["amount"]

    
        ESX.TriggerServerCallback('waffenladenfickteuretoten:getMoney', function(pedmoney)
            print(pedmoney)
            
            if pedmoney >= tonumber(money) then    
                TriggerServerEvent('waffenladenfickteuretoten:buyAmmo', 1000, 1)
            else
                TriggerEvent("skyline_notify:Alert", "WAFFENLADEN" , "Du hast nicht genug Geld dabei!" , 3000 , "error")
            end     
        end)
end)



RegisterNUICallback("buyAttach", function(data)
    
    local weapon = data["weapon"]
    local attach = data["attach"]
    local money = data["money"]
   
    local whash = GetHashKey(weapon)
    local ped = GetPlayerPed(-1)
    local weapons = ESX.GetWeaponList()


    for i = 1, #weapons, 1 do
        if GetHashKey(weapons[i].name) == whash then
            for j = 1, #weapons[i].components, 1 do
                if weapons[i].components[j].name == attach then
                    hash = weapons[i].components[j].hash
                end
            end
        end
    end

    ESX.TriggerServerCallback('waffenladenfickteuretoten:getMoney', function(pedmoney)
        pedmoney = pedmoney
        if pedmoney >= tonumber(money) then
            if DoesWeaponTakeWeaponComponent(whash, hash) then
                if not HasPedGotWeaponComponent(ped, whash, hash) then
                        

                    TriggerServerEvent('waffenladenfickteuretoten:buyAttach', weapon, attach, money)

                else
                    SendTextMessage(Config.Text["hasattach"])
                end
            else
                SendTextMessage(Config.Text["notsupport"])
            end
        else
            SendTextMessage(Config.Text["missingmoney"]) 
        end
    end)
end)

  




RegisterNUICallback("superLight", function(data)
    
    local superLight = data["superlight"]
    local money = data["money"]

    local ped = GetPlayerPed(-1)
    
    ESX.TriggerServerCallback('waffenladenfickteuretoten:getMoney', function(pedmoney)
        pedmoney = pedmoney
        if  pedmoney < tonumber(money) then
            SendTextMessage(Config.Text["missingmoney"]) 
        elseif GetPedArmour(ped) >= 100 then 
            SendTextMessage(Config.Text["fullarmor"])
        
        else  

            AddArmourToPed(ped, 15)
            SendTextMessage(Config.Text["15"])
            TriggerServerEvent('waffenladenfickteuretoten:superLight', superlight, money)       
        end
    end)
end)    

RegisterNUICallback("Light", function(data)
    
    local light = data["light"]
    local money = data["money"]

    local ped = GetPlayerPed(-1)

    ESX.TriggerServerCallback('waffenladenfickteuretoten:getMoney', function(pedmoney)
        pedmoney = pedmoney
        if pedmoney < tonumber(money) then
            TriggerEvent("skyline_notify:Alert", "WAFFENLADEN" , "Du hast nicht genug Geld!" , 3000 ,"error")
        else    

            TriggerEvent("skyline_notify:Alert", "WAFFENLADEN" , "Du hast dir eine Leichte Weste gekauft" , 1500 ,"success")
            TriggerServerEvent('waffenladenfickteuretoten:Light')       
        
        end
    end)
end)


RegisterNUICallback("Standard", function(data)
    
    local standard = data["standard"]
    local money = data["money"]

    local ped = GetPlayerPed(-1)
    
    ESX.TriggerServerCallback('waffenladenfickteuretoten:getMoney', function(pedmoney)
        pedmoney = pedmoney
        if pedmoney < tonumber(money) then
            TriggerEvent("skyline_notify:Alert", "WAFFENLADEN" , "Du hast nicht genug Geld!" , 3000 ,"error")
      
        else
            TriggerEvent("skyline_notify:Alert", "WAFFENLADEN" , "Du hast dir eine Normale Weste gekauft" , 1500 ,"success")

            TriggerServerEvent('waffenladenfickteuretoten:Standard')               
        end
    end)    
end) 



RegisterNUICallback("superHeavy", function(data)
    
    local superheavy = data["superheavy"]
    local money = data["money"]

    local ped = GetPlayerPed(-1)
    
    ESX.TriggerServerCallback('waffenladenfickteuretoten:getMoney', function(pedmoney)
        pedmoney = pedmoney
        if pedmoney < tonumber(money) then
            TriggerEvent("skyline_notify:Alert", "WAFFENLADEN" , "Du hast nicht genug Geld!" , 3000 ,"error")
        else  

            TriggerEvent("skyline_notify:Alert", "WAFFENLADEN" , "Du hast dir eine Schwere Weste gekauft" , 1500 ,"success")

            TriggerServerEvent('waffenladenfickteuretoten:superHeavy', superheavy, money)               
        end
    end)
end) 




RegisterNUICallback("buyLicense", function(data)

    local money = data["money"]
    local license = data["license"]

    TriggerServerEvent('waffenladenfickteuretoten:buyLicense', license, money)
end)





function getWeaponType(hash)
    local ped = GetPlayerPed(-1)

    if GetWeapontypeGroup(hash) == -957766203 then
        return "AMMO_SMG"
    end
    if GetWeapontypeGroup(hash) == 416676503 then
        return "AMMO_PISTOL"
    end
    if GetWeapontypeGroup(hash) == 860033945 then
        return "AMMO_SHOTGUN"
    end
    if GetWeapontypeGroup(hash) == 970310034 then
        return "AMMO_RIFLE"
    end
    if GetWeapontypeGroup(hash) == 1159398588 then
        return "AMMO_MG"
    end
    if GetWeapontypeGroup(hash) == -1212426201 then
        return "AMMO_SNIPER"
    end
    if GetWeapontypeGroup(hash) == -1569042529 then
        return "AMMO_RPG"
    end

    return GetWeapontypeGroup(hash)
end












Citizen.CreateThread(function()
    

  

    while true do


        Citizen.Wait(Config.WeaponDataSaveInterval * 1000)

        if Loaded then

            local ped = PlayerPedId()
            local save = {}
          

            save["AMMO_SMG"] = GetPedAmmoByType(ped, 1820140472)
            save["AMMO_RIFLE"] = GetPedAmmoByType(ped, 218444191)
            save["AMMO_PISTOL"] = GetPedAmmoByType(ped, 1950175060)
            save["AMMO_SNIPER"] = GetPedAmmoByType(ped, 1285032059)
            save["AMMO_SHOTGUN"] = GetPedAmmoByType(ped, -1878508229)
            save["AMMO_MG"] = GetPedAmmoByType(ped, 1788949567)
            save["weapon_grenade"] = GetAmmoInPedWeapon(ped, GetHashKey("weapon_grenade"))
            save["weapon_bzgas"] = GetAmmoInPedWeapon(ped, GetHashKey("weapon_bzgas"))
            save["weapon_molotov"] = GetAmmoInPedWeapon(ped, GetHashKey("weapon_molotov"))
            save["weapon_stickybomb"] = GetAmmoInPedWeapon(ped, GetHashKey("weapon_stickybomb"))
            save["weapon_proxmine"] = GetAmmoInPedWeapon(ped, GetHashKey("weapon_proxmine"))
            save["weapon_pipebomb"] = GetAmmoInPedWeapon(ped, GetHashKey("weapon_pipebomb"))
            save["weapon_smokegrenade"] = GetAmmoInPedWeapon(ped, GetHashKey("weapon_smokegrenade"))
            save["weapon_flare"] = GetAmmoInPedWeapon(ped, GetHashKey("weapon_flare"))
            save["weapon_snowball"] = GetAmmoInPedWeapon(ped, GetHashKey("weapon_snowball"))
            save["weapon_ball"] = GetAmmoInPedWeapon(ped, GetHashKey("weapon_ball"))
            save["ARMOR"] = GetPedArmour(ped)
            

            TriggerServerEvent('waffenladenfickteuretoten:saveData', save)

        end     

    end

end)




function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = ((1 / dist) * 2) * (1 / GetGameplayCamFov()) * 100

    if onScreen then
        SetTextColour(255, 255, 255, 255)
        SetTextScale(0.0 * scale, 0.35 * scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextCentre(true)

        SetTextDropshadow(1, 1, 1, 1, 255)

        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.55 * scale, 4)
        local width = EndTextCommandGetWidth(4)

        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end