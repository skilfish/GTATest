-- Client-seitiger Hauptcode
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    
    -- Warte bis ESX geladen ist
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    
    -- Initialisierung
    print('^2[Resource]^7 Client erfolgreich geladen!')
end)

-- Beispiel: Client-seitige Funktion
RegisterCommand('test', function()
    ESX.ShowNotification('Test-Befehl ausgeführt!')
end, false)
