ESX = nil

TriggerEvent(
    "skylineistback:getSharedObject",
    function(obj)
        ESX = obj
    end
)

function setCraftingLevel(identifier, level)
    MySQL.Async.execute(
        "UPDATE `users` SET `crafting_level`= @xp WHERE `identifier` = @identifier",
        {["@xp"] = level, ["@identifier"] = identifier},
        function()
        end
    )
end

function getCraftingLevel(identifier)
    return tonumber(
        MySQL.Sync.fetchScalar(
            "SELECT `crafting_level` FROM users WHERE identifier = @identifier ",
            {["@identifier"] = identifier}
        )
    )
end

function giveCraftingLevel(identifier, level)
    MySQL.Async.execute(
        "UPDATE `users` SET `crafting_level`= `crafting_level` + @xp WHERE `identifier` = @identifier",
        {["@xp"] = level, ["@identifier"] = identifier},
        function()
        end
    )
end

RegisterServerEvent("craftingdukleinerhs:setExperiance")
AddEventHandler(
    "craftingdukleinerhs:setExperiance",
    function(identifier, xp)
        setCraftingLevel(identifier, xp)
    end
)

RegisterServerEvent("craftingdukleinerhs:giveExperiance")
AddEventHandler(
    "craftingdukleinerhs:giveExperiance",
    function(identifier, xp)
        giveCraftingLevel(identifier, xp)
    end
)

function craft(src, item, retrying)
    local xPlayer = ESX.GetPlayerFromId(src)
    local cancraft = true

    local count = Config.Recipes[item].Amount

    if not retrying then
        for k, v in pairs(Config.Recipes[item].Ingredients) do
            if xPlayer.getInventoryItem(k).count < v then
                cancraft = false
            end
        end
    end

    if Config.Recipes[item].isGun then
        if cancraft then
            for k, v in pairs(Config.Recipes[item].Ingredients) do
                if not Config.PermanentItems[k] then
                    xPlayer.removeInventoryItem(k, v)
                end
            end

            TriggerClientEvent("craftingdukleinerhs:craftStart", src, item, count)
        else
            TriggerClientEvent("craftingdukleinerhs:sendMessage", src, Config.Text["not_enough_ingredients"])
        end
    else
        if Config.UseLimitSystem then
            local xItem = xPlayer.getInventoryItem(item)

            if xItem.count + count <= xItem.limit then
                if cancraft then
                    for k, v in pairs(Config.Recipes[item].Ingredients) do
                        xPlayer.removeInventoryItem(k, v)
                    end

                    TriggerClientEvent("craftingdukleinerhs:craftStart", src, item, count)
                else
                    TriggerClientEvent("craftingdukleinerhs:sendMessage", src, Config.Text["not_enough_ingredients"])
                end
            else
                TriggerClientEvent("craftingdukleinerhs:sendMessage", src, Config.Text["you_cant_hold_item"])
            end
        else
            if xPlayer.canCarryItem(item, count) then
                if cancraft then
                    for k, v in pairs(Config.Recipes[item].Ingredients) do
                        xPlayer.removeInventoryItem(k, v)
                    end

                    TriggerClientEvent("craftingdukleinerhs:craftStart", src, item, count)
                else
                    TriggerClientEvent("craftingdukleinerhs:sendMessage", src, Config.Text["not_enough_ingredients"])
                end
            else
                TriggerClientEvent("craftingdukleinerhs:sendMessage", src, Config.Text["you_cant_hold_item"])
            end
        end
    end
end

RegisterServerEvent("craftingdukleinerhs:itemCrafted")
AddEventHandler(
    "craftingdukleinerhs:itemCrafted",
    function(item, count)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        if Config.Recipes[item].SuccessRate > math.random(0, Config.Recipes[item].SuccessRate) then
            if Config.UseLimitSystem then
                local xItem = xPlayer.getInventoryItem(item)

                if xItem.count + count <= xItem.limit then
                    if Config.Recipes[item].isGun then
                        xPlayer.addWeapon(item, 0)
                    else
                        xPlayer.addInventoryItem(item, count)
                    end
                    TriggerClientEvent("craftingdukleinerhs:sendMessage", src, Config.Text["item_crafted"])
                    giveCraftingLevel(xPlayer.identifier, Config.ExperiancePerCraft)
                else
                    TriggerEvent("craftingdukleinerhs:craft", item)
                    TriggerClientEvent("craftingdukleinerhs:sendMessage", src, Config.Text["inv_limit_exceed"])
                end
            else
                if Config.Recipes[item].isGun or xPlayer.canCarryItem(item, count)  then
                    if Config.Recipes[item].isGun then
                        xPlayer.addWeapon(item, 0)
                    else
                        xPlayer.addInventoryItem(item, count)
                    end
                    TriggerClientEvent("craftingdukleinerhs:sendMessage", src, Config.Text["item_crafted"])
                    giveCraftingLevel(xPlayer.identifier, Config.ExperiancePerCraft)
                else
                    TriggerClientEvent("craftingdukleinerhs:sendMessage", src, Config.Text["inv_limit_exceed"])
                end
            end
        else
            TriggerClientEvent("craftingdukleinerhs:sendMessage", src, Config.Text["crafting_failed"])
        end
    end
)

RegisterServerEvent("craftingdukleinerhs:craft")
AddEventHandler(
    "craftingdukleinerhs:craft",
    function(item, retrying)
        local src = source
        craft(src, item, retrying)
    end
)

ESX.RegisterServerCallback(
    "craftingdukleinerhs:getXP",
    function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)

        cb(getCraftingLevel(xPlayer.identifier))
    end
)

ESX.RegisterServerCallback(
    "craftingdukleinerhs:getItemNames",
    function(source, cb)
        local names = {}

        MySQL.Async.fetchAll(
            "SELECT * FROM items WHERE 1",
            {},
            function(info)
                names["WEAPON_PISTOL"] =  ESX.GetWeaponLabel('WEAPON_PISTOL')
                names["WEAPON_PISTOL50"] =  ESX.GetWeaponLabel('WEAPON_PISTOL50')
                names["WEAPON_SMG"] =  ESX.GetWeaponLabel('WEAPON_SMG')
                names["WEAPON_GUSENBERG"] =  ESX.GetWeaponLabel('WEAPON_GUSENBERG')
                names["WEAPON_ADVANCEDRIFLE"] =  ESX.GetWeaponLabel('WEAPON_ADVANCEDRIFLE')
                names["WEAPON_KNIFE"] =  ESX.GetWeaponLabel('WEAPON_KNIFE')

                for _, v in ipairs(info) do
                    names[v.name] = v.label
                end

            

                cb(names)
            end
        )
    end
)

RegisterCommand(
    "givecraftingxp",
    function(source, args, rawCommand)
        if source ~= 0 then
            local xPlayer = ESX.GetPlayerFromId(source)

            if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
                if args[1] ~= nil then
                    local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
                    if xTarget ~= nil then
                        if args[2] ~= nil then
                            giveCraftingLevel(xTarget.identifier, tonumber(args[2]))
                        else
                            TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                        end
                    else
                        TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                    end
                else
                    TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                end
            else
                TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
            end
        end
    end,
    false
)

RegisterCommand(
    "setcraftingxp",
    function(source, args, rawCommand)
        if source ~= 0 then
            local xPlayer = ESX.GetPlayerFromId(source)

            if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
                if args[1] ~= nil then
                    local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
                    if xTarget ~= nil then
                        if args[2] ~= nil then
                            setCraftingLevel(xTarget.identifier, tonumber(args[2]))
                        else
                            TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                        end
                    else
                        TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                    end
                else
                    TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                end
            else
                TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
            end
        end
    end,
    false
)

