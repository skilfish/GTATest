SKYLINE = nil 

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

function ExtractIdentifiers()
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    --Loop over all identifiers
    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)

        --Convert it to a nice table.
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

-- Check -- 
SKYLINE.RegisterServerCallback("jucktnicht_einreise:hasEinreise", function(playerId , cb)
    local xPlayer = SKYLINE.GetPlayerFromId(playerId)

    result = MySQL.Sync.fetchScalar("SELECT hasEinreise FROM einreise WHERE license = '" .. xPlayer.getIdentifier() .. "' ")

    if result == nil then 

        MySQL.Sync.execute('INSERT INTO einreise (license,hasEinreise) VALUES (@identifier, @einreise)', {
            ['@identifier'] = xPlayer.getIdentifier(),
            ['@einreise'] = 0
        }, function (rowsChanged)
        end)

        cb(false)
    else 
        if result == 0 then 
           cb(false)
        else 
            cb(true) 
        end 
    end 

end)

SKYLINE.RegisterServerCallback("jucktnicht_einreise:checkEinreise", function(playerId , cb)
    local xPlayer = SKYLINE.GetPlayerFromId(playerId)

    a = false 

    for _,v in pairs(Config.Groups) do 
       if v == xPlayer.getGroup() then 
           a = true 
           break
       end 
    end 



    if a then 
        TriggerEvent("skyline:showAdvancedNotification", playerId , "Einreise-Amt" , "~r~Einreise" , "~g~Danke für deine Arbeit!" , "CHAR_BANK_BOL" , 1, false , 70)
        cb(true)
    else 
        if not Config.SimpleMode then 
            if xPlayer.getInventoryItem("einreise").count >= 1 then 
                xPlayer.removeInventoryItem("einreise", 1)
                MySQL.Sync.execute("UPDATE einreise SET hasEinreise = '1' WHERE license = '" .. xPlayer.getIdentifier() .. "'")
                cb(true)
            else 
                TriggerEvent("notifications", playerId , "red" , "Einreise-Amt" , "~r~Einreise" , "Sie benötigen ein gültiges Einreise-Visum.")
                cb(false)
            end 
        else 
            MySQL.Sync.execute("UPDATE einreise SET hasEinreise = '1' WHERE license = '" .. xPlayer.getIdentifier() .. "'")
            cb(true)
        end 
       
    end 

   

end)



SKYLINE.RegisterServerCallback("jucktnicht_einreise:checkJob", function(playerId , cb)
    local xPlayer = SKYLINE.GetPlayerFromId(playerId)

    a = false 

     for _,v in pairs(Config.Groups) do 
        if v == xPlayer.getGroup() then 
            a = true 
            break
        end 
     end 

     cb(a)
 end)


RegisterNetEvent("jucktnicht_einreise:addTicket")
AddEventHandler("jucktnicht_einreise:addTicket", function()
    local xPlayer = SKYLINE.GetPlayerFromId(source)

    xPlayer.addInventoryItem("einreise", 1)
end)

SKYLINE.RegisterServerCallback("jucktnicht_einreise:getGroup", function(source , cb)
    local xPlayer = SKYLINE.GetPlayerFromId(source)
    cb(xPlayer.getGroup())
end)

SKYLINE.RegisterServerCallback("jucktnicht_einreise:isBanable", function(source , cb , target)
    
    local xPlayer = SKYLINE.GetPlayerFromId(target)
    
    if target ~= nil then 
        result = MySQL.Sync.fetchScalar("SELECT hasEinreise FROM einreise WHERE license = '" .. xPlayer.getIdentifier() .. "' ")

        if result ~= nil then 
            if result == 1 then 
                cb(true)
            else 
                cb(false)
            end 
        else   
            cb(false)
        end 
    else 
        cb(false)
    end 
end)



RegisterNetEvent("jucktnicht_einreise:ban")
AddEventHandler("jucktnicht_einreise:ban", function(target)
    local xPlayer = SKYLINE.GetPlayerFromId(target)
    local addTime = 60 * 60 -- minutes
    local a = 2 * 3600 
    local banTime = os.time(os.date("!*t")) + a  + addTime


    MySQL.Sync.execute("UPDATE einreise SET isBanned = '1' WHERE license = '" .. xPlayer.getIdentifier() .. "'")
    MySQL.Sync.execute("UPDATE einreise SET time = '" .. banTime .. "' WHERE license = '" .. xPlayer.getIdentifier() .. "'")
    xPlayer.kick("Einreise nicht bestanden.")
end)

function disp_time(time)
    local days = math.floor(time/86400)
    local hours = math.floor(math.fmod(time, 86400)/3600)
    local minutes = math.floor(math.fmod(time,3600)/60)
    local seconds = math.floor(math.fmod(time,60))
    return string.format("%02d",minutes)
  end

local function OnPlayerConnecting(name, setKickReason, deferrals)
    deferrals.defer()

    local identifiers = ExtractIdentifiers()


    local player = source
    local license_1 = GetPlayerIdentifier(player, 1)
    local license = identifiers.steam

  

    result = MySQL.Sync.fetchScalar("SELECT isBanned FROM einreise WHERE license = '" .. license .. "' ")

    if result ~= nil and result == 1 then 
        banTime = MySQL.Sync.fetchScalar("SELECT time FROM einreise WHERE license = '" .. license .. "' ")

        local a = 2 * 3600 
        local c = os.time(os.date("!*t")) + a

        if banTime <= c then 
            deferrals.done()
            MySQL.Sync.execute("UPDATE einreise SET isBanned = '0' WHERE license = '" .. license .. "'")
            MySQL.Sync.execute("UPDATE einreise SET time = '" .. 0 .. "' WHERE license = '" .. license .. "'")
        else 
            local a = disp_time(c - banTime) *-1 

            if  math.floor(a) == 1 then 
                deferrals.done("Einreise nicht bestanden. \n Nächster Versuch: " .. math.floor(a) .. " Minute")
            else 
                deferrals.done("Einreise nicht bestanden. \n Nächster Versuch: " .. math.floor(a) .. " Minuten")
            end 
        end 


    else 
        deferrals.done()
    end 

end

AddEventHandler("playerConnecting", OnPlayerConnecting)

