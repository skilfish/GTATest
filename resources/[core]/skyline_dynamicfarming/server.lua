SKYLINE = nil 

TriggerEvent("skylineistback:getSharedObject", function(obj)
	SKYLINE = obj
end)


-- Vars -- 
local webhook = "https://discord.com/api/webhooks/988449133750784010/WOxuqp5S63g_0faarBP_zT_-KPS8aKno2iGcc9C_5-2ASRB_Xy1qFXp6SLPEHMIRT9Z0"


local maxWeight = 25000

local priceBottle = 0 
local bottleSales = 0 

local weedPrice = 0 
local weedSales = 0

local methPrice = 0 
local methSales = 0

local koksPrice = 0 
local koksSales = 0

local tabakPrice = 0 
local tabakSales = 0

koks_farming = {}
kokss = {}
tabak_farming = {}
tabak = {}
tabakk = {}

Config = {
	EnableWeapons = false, -- If you want the players to be able to find weapons (false by default).
	SearchTime = 10000, -- How much time it takes to search in millisecond.

	Dumpsters = { -- Props of the dumpsters wich is getting defined in the client.
		"prop_dumpster_01a",
		"prop_dumpster_02a",
		"prop_dumpster_02b"
	},

	Items = { -- Add whatever items you want here.
        "bottle"
	},
	
	Weapons = { -- Add whatever weapons you want here (don't care about this if EnableWeapons = false).
        "WEAPON_KNIFE",
        "WEAPON_PISTOL"
    }
}

Strings = { -- Translation
	["Search"] = "Drücke [~g~E~s~] zum Durchsuchen",
	["Searched"] = "Hier ist nix mehr..",
	["Found"] = "Du hast gefunden -> ",
	["Searching"] = "Suche...",
	["Nothing"] = "Du hast nichts gefunden"
}

-- Vars -- 


SKYLINE.RegisterServerCallback("jucktnicht_dynamicfarming:getWeedPrice", function(playerId , cb)
    cb(weedPrice)
end)

SKYLINE.RegisterServerCallback("jucktnicht_dynamicfarming:getKoksPrice", function(playerId , cb)
    cb(koksPrice)
end)
SKYLINE.RegisterServerCallback("jucktnicht_dynamicfarming:getPFPrice", function(playerId , cb)
    cb(priceBottle)
end)

SKYLINE.RegisterServerCallback("jucktnicht_dynamicfarming:getTabakPrice", function(playerId , cb)
    cb(tabakPrice)
end)

SKYLINE.RegisterServerCallback("jucktnicht_dynamicfarming:getMethPrice", function(playerId , cb)
    cb(methPrice)
end)

function sendToDiscord(name, message)
	local embed = {
		  {
			  ["color"] = 1752220,
			  ["title"] = "**".. name .."**",
			  ["description"] = message,
			  ["footer"] = {
				  ["text"] = "Copyright © Juckthaltnicht 2022",
			  },
		  }
	  }
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "SKYLINE - Logs", embeds = embed, avatar_url = ""}), { ['Content-Type'] = 'application/json' })
  end

AddEventHandler("onResourceStart" , function(resourceName)
    if (GetCurrentResourceName() == resourceName) then 

        priceBottle = math.random(40 , 60) 
        weedPrice = math.random(1000 , 2000) 
        koksPrice = math.random(6000 , 9000) 
        tabakPrice = math.random(80 , 120) 
        methPrice = math.random(4000 , 7000)

        sendToDiscord("Routen - Preise" , "**Weed-Preis:** » " .. weedPrice .. "$ \n **Pfandflaschen-Preis** » " .. priceBottle .. "$ \n **Kokain-Preis** » " .. koksPrice .. "$ \n **Tabak-Preis** » " .. tabakPrice .. "$ \n **Meth-Preis** » " .. methPrice .. "$")

    end 
end)


AddEventHandler("onResourceStop" , function(resourceName)
    if (GetCurrentResourceName() == resourceName) then 
        sendToDiscord("Routen - Umsatz" , "**Weed-Umsatz** » " .. weedSales .. "$ \n **Pfandflaschen-Umsatz** » " .. bottleSales .. "$ \n **Kokain-Umsatz** » " .. koksSales .. "$ \n **Tabak-Umsatz** » " .. tabakSales .. "$ \n **Meth-Umsatz** » " .. methSales .. "$")
    end 
end)



SKYLINE["RegisterServerCallback"]("jucktnicht_dynamicfarming:sammelMüll", function(source, cb)
    local player = SKYLINE["GetPlayerFromId"](source)
    local luck = math["random"](1, 6)

    if player then
        if luck == 4 or luck == 3 or luck == 1 or luck == 2 or luck == 5 then
            local randomItem = Config["Items"][math["random"](#Config["Items"])]
            local quantity = math["random"](#Config["Items"])
            local itemLabel = SKYLINE["GetItemLabel"](randomItem)
            local item = player.getInventoryItem(randomItem)
            local b = math.random(1,5)
            
            if player.canCarryItem(randomItem, b) then 
                player["addInventoryItem"](randomItem, quantity * b)
                cb(true, itemLabel, quantity * b)
            else 
                TriggerClientEvent("skyline_notify:Alert", source, "FARMING" , "Deine Taschen sind voll!" , 3000 , "error")
                cb(false)
            end 


         
              
            
              
            
        else
            if Config["EnableWeapons"] then -- disabled by default, enable in the config.
                if luck == 2 then
                    local randomWeapon = Config["Weapons"][math["random"](#Config["Weapons"])]
                    local ammunition = math["random"](#Config["Weapons"])
                    local weaponLabel = SKYLINE["GetWeaponLabel"](randomWeapon)

                    if player["hasWeapon"](randomWeapon) then
                        cb(false)
                    else
                        player["addWeapon"](randomWeapon, ammunition)
                        cb(true, weaponLabel, 1)
                    end
                else
                    cb(false)
                end
            else
                cb(false)
            end
        end
    else
        cb(false)
    end
end)


local function startFarmKoks(source)


    SetTimeout(7 * 1000, function() 
        if koks_farming[source] then 
            local playerPed = GetPlayerPed(-1)
            local xPlayer = SKYLINE.GetPlayerFromId(source)
            local koks = xPlayer.getInventoryItem("koks")
           
            local count = math.random(6 , 9)

            if xPlayer.canCarryItem("koks", count) then
                xPlayer.addInventoryItem("koks", count)
                local space = (maxWeight - xPlayer.getWeight()) / 1
                TriggerClientEvent("jucktnicht_dynamicfarming:koksCounter", source, space)
				startFarmKoks(source)
            else
                TriggerClientEvent("skyline_notify:Alert", source, "FARMING" , "Deine Taschen sind voll!" , 3000 , "error")
                TriggerClientEvent("jucktnicht_dynamicfarming:cancelFarmKoks" , source)
			
            end 
        end 
    
    end)

end 

local function startFarmKokss(source)


    SetTimeout(7 * 1000, function() 
        if kokss[source] then 
            local playerPed = GetPlayerPed(-1)
            local xPlayer = SKYLINE.GetPlayerFromId(source)
            local koks = xPlayer.getInventoryItem("koks")
           
            if xPlayer.canCarryItem("koks_p", 1) then
               if koks.count >= 1000 then
                    xPlayer.removeInventoryItem("koks", 1000)
                    xPlayer.addInventoryItem("koks_p", 1)
                    startFarmKokss(source)

               else 
                TriggerClientEvent("skyline_notify:Alert", source, "FARMING" , "Du brauchst mind. 1000 Gramm Kokain" , 3000 , "error")
                TriggerClientEvent("jucktnicht_dynamicfarming:cancelFarmKokss" , source)
               end 
              
            else
                TriggerClientEvent("skyline_notify:Alert", source, "FARMING" , "Deine Taschen sind voll!" , 3000 , "error")
                TriggerClientEvent("jucktnicht_dynamicfarming:cancelFarmKokss" , source)
			
            end 
        end 
    
    end)

end 

local function startFarmTabakk(source)


    SetTimeout(7 * 1000, function() 
        if tabakk[source] then 
            local playerPed = GetPlayerPed(-1)
            local xPlayer = SKYLINE.GetPlayerFromId(source)
            local tabak = xPlayer.getInventoryItem("tabak")
           
            if xPlayer.canCarryItem("kippe", 1) then
               if tabak.count >= 2 then
                    xPlayer.removeInventoryItem("tabak", 2)
                    xPlayer.addInventoryItem("kippe", 1)
                    startFarmTabakk(source)

               else 
                TriggerClientEvent("skyline_notify:Alert", source, "FARMING" , "Du brauchst mind. 2 Tabak" , 3000 , "error")
                TriggerClientEvent("jucktnicht_dynamicfarming:cancelFarmKokss" , source)
               end 
              
            else
                TriggerClientEvent("skyline_notify:Alert", source, "FARMING" , "Deine Taschen sind voll!" , 3000 , "error")
                TriggerClientEvent("jucktnicht_dynamicfarming:cancelFarmTabak" , source)
			
            end 
        end 
    
    end)

end 

local function startFarmTabak(source)


    SetTimeout(7 * 1000, function() 
        if tabak[source] then 
            local playerPed = GetPlayerPed(-1)
            local xPlayer = SKYLINE.GetPlayerFromId(source)
            local tabak = xPlayer.getInventoryItem("tabak")
           
            if xPlayer.canCarryItem("tabak", 2) then
                xPlayer.addInventoryItem("tabak", 2)
                local space = (maxWeight - xPlayer.getWeight()) / 50
                TriggerClientEvent("jucktnicht_dynamicfarming:tabakCounter", source, space)              
                startFarmTabak(source)
            else
                TriggerClientEvent("skyline_notify:Alert", source, "FARMING" , "Deine Taschen sind voll!" , 3000 , "error")
                TriggerClientEvent("jucktnicht_dynamicfarming:cancelFarmTabak" , source)
			
            end 
        end 
    
    end)

end 

RegisterServerEvent('jucktnicht_dynamicfarming:startTabak')
AddEventHandler('jucktnicht_dynamicfarming:startTabak', function()
    
	if not tabak[source] then
		tabak[source] = true
		startFarmTabak(source)
	end
end)


RegisterServerEvent('jucktnicht_dynamicfarming:startKoks')
AddEventHandler('jucktnicht_dynamicfarming:startKoks', function()
    
	if not koks_farming[source] then
		koks_farming[source] = true
		startFarmKoks(source)
	end
end)

RegisterServerEvent('jucktnicht_dynamicfarming:startKokss')
AddEventHandler('jucktnicht_dynamicfarming:startKokss', function()
    
	if not kokss[source] then
		kokss[source] = true
		startFarmKokss(source)
	end
end)


RegisterServerEvent('jucktnicht_dynamicfarming:startTabakk')
AddEventHandler('jucktnicht_dynamicfarming:startTabakk', function()
    
	if not tabakk[source] then
		tabakk[source] = true
		startFarmTabakk(source)
	end
end)

RegisterNetEvent("jucktnicht_dynamicfarming:stopTabakk")
AddEventHandler("jucktnicht_dynamicfarming:stopTabakk", function()
	tabakk[source] = false
end)


RegisterServerEvent('jucktnicht_dynamicfarming:emergencyStop')
AddEventHandler('jucktnicht_dynamicfarming:emergencyStop', function()
    koks_farming[source] = false
    kokss[source] = false 
end)



RegisterNetEvent("jucktnicht_dynamicfarming:stopKoks")
AddEventHandler("jucktnicht_dynamicfarming:stopKoks", function()
	koks_farming[source] = false
end)

RegisterNetEvent("jucktnicht_dynamicfarming:stopTabak")
AddEventHandler("jucktnicht_dynamicfarming:stopTabak", function()
	tabak[source] = false
end)


RegisterNetEvent("jucktnicht_dynamicfarming:stopKokss")
AddEventHandler("jucktnicht_dynamicfarming:stopKokss", function()
	kokss[source] = false
end)






RegisterNetEvent("jucktnicht_dynamicfarming:sellPF")
AddEventHandler("jucktnicht_dynamicfarming:sellPF", function()
    local xPlayer = SKYLINE.GetPlayerFromId(source)
    local a = xPlayer.getInventoryItem("bottle").count 

    if a >= 1 then 
        xPlayer.addMoney(a * priceBottle)
        bottleSales = bottleSales + (a * priceBottle)
        xPlayer.removeInventoryItem("bottle", a)
        TriggerClientEvent("skyline_notify:Alert", source , "FARMING" , "Verkauft: <b style=lime;>" .. a * priceBottle .. "$</b>" , 3000 , "success")

    else 
        TriggerClientEvent("skyline_notify:Alert", source, "FARMING" , "Du hast keine Pfandflaschen dabei!" , 3000 , "error")
    end 
end)



RegisterNetEvent("jucktnicht_dynamicfarming:sellWeed")
AddEventHandler("jucktnicht_dynamicfarming:sellWeed", function()
    local xPlayer = SKYLINE.GetPlayerFromId(source)
    local a = xPlayer.getInventoryItem("weed_pooch").count 

    if a >= 1 then 
        xPlayer.addAccountMoney('black_money', a * weedPrice)
        weedSales = weedSales + (a * weedPrice)
        xPlayer.removeInventoryItem("weed_pooch", a)
        TriggerClientEvent("skyline_notify:Alert", source , "FARMING" , "Verkauft: <b style=lime;>" .. a * weedPrice .. "$</b>" , 3000 , "success")

    else 
        TriggerClientEvent("skyline_notify:Alert", source, "FARMING" , "Du hast keine Weed dabei!" , 3000 , "error")
    end 
end)
RegisterNetEvent("jucktnicht_dynamicfarming:sellKoks")
AddEventHandler("jucktnicht_dynamicfarming:sellKoks", function()
    local xPlayer = SKYLINE.GetPlayerFromId(source)
    local a = xPlayer.getInventoryItem("koks_p").count 

    if a >= 1 then 
        xPlayer.addAccountMoney('black_money', a * koksPrice)
        koksSales = koksSales + (a * koksPrice)
        xPlayer.removeInventoryItem("koks_p", a)
        TriggerClientEvent("skyline_notify:Alert", source , "FARMING" , "Verkauft: <b style=lime;>" .. a * koksPrice .. "$</b>" , 3000 , "success")

    else 
        TriggerClientEvent("skyline_notify:Alert", source, "FARMING" , "Du hast keine Weed dabei!" , 3000 , "error")
    end 
end)

RegisterNetEvent("jucktnicht_dynamicfarming:sellMeth")
AddEventHandler("jucktnicht_dynamicfarming:sellMeth", function()
    local xPlayer = SKYLINE.GetPlayerFromId(source)
    local a = xPlayer.getInventoryItem("meth_packaged").count 

    if a >= 1 then 
        xPlayer.addAccountMoney('black_money', a * methPrice)
        methSales = methSales + (a * methPrice)
        xPlayer.removeInventoryItem("meth_packaged", a)
        TriggerClientEvent("skyline_notify:Alert", source , "FARMING" , "Verkauft: <b style=lime;>" .. a * methPrice .. "$</b>" , 3000 , "success")

    else 
        TriggerClientEvent("skyline_notify:Alert", source, "FARMING" , "Du hast keine Meth dabei!" , 3000 , "error")
    end 
end)

RegisterNetEvent("jucktnicht_dynamicfarming:sellTabak")
AddEventHandler("jucktnicht_dynamicfarming:sellTabak", function()
    local xPlayer = SKYLINE.GetPlayerFromId(source)
    local a = xPlayer.getInventoryItem("kippe").count 

    if a >= 1 then 
        xPlayer.addMoney(tabakPrice * a)
        tabakSales = tabakSales + (a * tabakPrice)
        xPlayer.removeInventoryItem("kippe", a)
        TriggerClientEvent("skyline_notify:Alert", source , "FARMING" , "Verkauft: <b style=lime;>" .. a * tabakPrice .. "$</b>" , 3000 , "success")

    else 
        TriggerClientEvent("skyline_notify:Alert", source, "FARMING" , "Du hast keine Kippe dabei!" , 3000 , "error")
    end 
end)
