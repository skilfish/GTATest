ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("skylineistback:getSharedObject", function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)