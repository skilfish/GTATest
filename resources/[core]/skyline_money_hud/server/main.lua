SKYLINE = nil 

-- SKYLINE
TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

SKYLINE.RegisterServerCallback("skyline_money_hud:loadMoney", function(playerId , cb)
    local xPlayer = SKYLINE.GetPlayerFromId(playerId)


    cb(xPlayer.getMoney() , xPlayer.getAccount('black_money').money)
end)