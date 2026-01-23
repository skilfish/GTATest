-- Server-seitiger Hauptcode
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Beispiel: Server-seitige Funktion
ESX.RegisterServerCallback('example:callback', function(source, cb)
    -- Ihre Logik hier
    cb(true)
end)

-- Beispiel: Event Handler
RegisterNetEvent('example:event')
AddEventHandler('example:event', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    -- Ihre Logik hier
end)

print('^2[Resource]^7 Server erfolgreich geladen!')
