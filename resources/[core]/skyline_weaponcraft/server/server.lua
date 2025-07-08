ESX = nil

TriggerEvent("skylineistback:getSharedObject", function(obj) ESX = obj end)

RegisterServerEvent("miningdufotze:getItem")
AddEventHandler("miningdufotze:getItem", function()
    local xPlayer, randomItem = ESX.GetPlayerFromId(source), Config.Mining.Items[math.random(1, #Config.Mining.Items)]
    if math.random(0, 100) <= Config.Mining.ChanceToGetItem then
        if xPlayer.canCarryItem(randomItem, 1) then 
            xPlayer.addInventoryItem(randomItem, 1)
        else 
            TriggerClientEvent("skyline_notify:Alert", source, "MINING" , "Du hast kein Platz in deiner Tasche!" , 2500 , "error")
        end 
    end
end)

RegisterServerEvent("miningdufotze:smelt")
AddEventHandler("miningdufotze:smelt", function()
    local xPlayer =  ESX.GetPlayerFromId(source)

    Citizen.Wait(1876)


    if xPlayer.getInventoryItem("iron_ore").count >= 1 then 
        xPlayer.addInventoryItem("iron", xPlayer.getInventoryItem("iron_ore").count)
        xPlayer.removeInventoryItem("iron_ore", xPlayer.getInventoryItem("iron_ore").count)
    end 

    Citizen.Wait(1876)


    if xPlayer.getInventoryItem("gold_ore").count >= 1 then 
        xPlayer.addInventoryItem("gold2", xPlayer.getInventoryItem("gold_ore").count)
        xPlayer.removeInventoryItem("gold_ore", xPlayer.getInventoryItem("gold_ore").count)
    end 

    Citizen.Wait(1876)
       

    if xPlayer.getInventoryItem("aluminum_ore").count >= 1 then 
        xPlayer.addInventoryItem("aluminum", xPlayer.getInventoryItem("aluminum_ore").count)
        xPlayer.removeInventoryItem("aluminum_ore", xPlayer.getInventoryItem("aluminum_ore").count)
    end 
end)