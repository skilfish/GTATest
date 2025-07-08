-- Serverseitige Registrierung
RegisterServerEvent('core_identity:register')
AddEventHandler('core_identity:register', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    print(('Spieler %s registriert sich als: %s %s (%s, %s)'):format(
        src, data[1], data[2], data[3], data[4]
    ))

    -- Beispiel: Hier könnte man SQL INSERT schreiben
end)

-- Automatische Charakterprüfung bei Verbindung
AddEventHandler('playerLoaded', function(playerId, xPlayer)
    -- Hier würdest du normalerweise prüfen, ob der Spieler bereits registriert ist
    -- Wir simulieren: immer öffnen
    TriggerClientEvent('core_identity:openRegistration', playerId)
end)
