ESX = nil

TriggerEvent(
    "skylineistback:getSharedObject",
    function(obj)
        ESX = obj
    end
)




RegisterServerEvent('waffenladenfickteuretoten:buyGun')
AddEventHandler('waffenladenfickteuretoten:buyGun', function( gun, money)

    local xPlayer = ESX.GetPlayerFromId(source)
    local pedmoney = xPlayer.getMoney()
    
    if pedmoney < tonumber(money) then
        TriggerClientEvent('waffenladenfickteuretoten:sendMessage', source, "Du hast nicht genug Geld dabei!" , "error")
    elseif xPlayer.hasWeapon(gun) then 
        TriggerClientEvent('waffenladenfickteuretoten:sendMessage', source, "Du hast diese Waffe bereits dabei!" , "error")
    else
        xPlayer.addWeapon("WEAPON_PISTOL", 0)
        ESX.SavePlayer(xPlayer,function() end)
        xPlayer.removeMoney(money)
        TriggerClientEvent('waffenladenfickteuretoten:sendMessage', source, "Waffe gekauft" , "success")
    end
end)






RegisterServerEvent('waffenladenfickteuretoten:buyMelee')
AddEventHandler('waffenladenfickteuretoten:buyMelee', function( melee, money)

    local xPlayer = ESX.GetPlayerFromId(source)
    local pedmoney = xPlayer.getMoney()
    
    if pedmoney < tonumber(money) then
        TriggerClientEvent('waffenladenfickteuretoten:sendMessage', source, "Du hast nicht genug Geld dabei!" , "error")
    elseif xPlayer.hasWeapon(melee) then 
        TriggerClientEvent('waffenladenfickteuretoten:sendMessage', source, Config.Text["hasweapon"])
    else           
        xPlayer.addWeapon(melee, 1)
        xPlayer.removeMoney(money)
        TriggerClientEvent('waffenladenfickteuretoten:sendMessage', source, Config.Text["successful"])
    end
end)
   


RegisterServerEvent('waffenladenfickteuretoten:buyAmmo')
AddEventHandler('waffenladenfickteuretoten:buyAmmo', function(wepname, money, amount)

    local xPlayer = ESX.GetPlayerFromId(source)
    local pedmoney = xPlayer.getMoney()

    xPlayer.removeMoney(1000)
    xPlayer.addInventoryItem("munition", 1)
    TriggerClientEvent('waffenladenfickteuretoten:sendMessage', source, "1x mal Munition gekauft" , "success")


end)





RegisterServerEvent('waffenladenfickteuretoten:buyAttach')
AddEventHandler('waffenladenfickteuretoten:buyAttach', function( weapon, attach, money)

    local xPlayer = ESX.GetPlayerFromId(source)
    local pedmoney = xPlayer.getMoney()

    xPlayer.addWeaponComponent(weapon, attach)
    xPlayer.removeMoney(money)
    TriggerClientEvent('waffenladenfickteuretoten:sendMessage', source, Config.Text["successful"])

end)


ESX.RegisterServerCallback('waffenladenfickteuretoten:getMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getMoney())
end)


ESX.RegisterServerCallback('waffenladenfickteuretoten:getLoadout', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getLoadout())
end)

















RegisterServerEvent('waffenladenfickteuretoten:superLight')
AddEventHandler('waffenladenfickteuretoten:superLight', function(superlight, money)

    local xPlayer = ESX.GetPlayerFromId(source)
    local pedmoney = xPlayer.getMoney()
    
   
    
end)

RegisterServerEvent('waffenladenfickteuretoten:Light')
AddEventHandler('waffenladenfickteuretoten:Light', function( light, money)

    local xPlayer = ESX.GetPlayerFromId(source)
    local pedmoney = xPlayer.getMoney()
    
    xPlayer.removeMoney(1500)
    xPlayer.addInventoryItem("vest_light", 1)
    
end)

RegisterServerEvent('waffenladenfickteuretoten:Standard')
AddEventHandler('waffenladenfickteuretoten:Standard', function( standard, money)

    local xPlayer = ESX.GetPlayerFromId(source)
    local pedmoney = xPlayer.getMoney()
    
    xPlayer.removeMoney(3000)
    xPlayer.addInventoryItem("vest_normal", 1)

end)

RegisterServerEvent('waffenladenfickteuretoten:Heavy')
AddEventHandler('waffenladenfickteuretoten:Heavy', function( heavy, money)

    local xPlayer = ESX.GetPlayerFromId(source)
    local pedmoney = xPlayer.getMoney()
    
    xPlayer.removeMoney(money)
    
end)

RegisterServerEvent('waffenladenfickteuretoten:superHeavy')
AddEventHandler('waffenladenfickteuretoten:superHeavy', function( superheavy, money)

    local xPlayer = ESX.GetPlayerFromId(source)
    local pedmoney = xPlayer.getMoney()
    
    xPlayer.removeMoney(5000)
    xPlayer.addInventoryItem("vest_heavy", 1)
end)