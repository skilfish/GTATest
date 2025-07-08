RegisterNetEvent("playerDropped", function(reason)
    local src = source
    local playerId = tostring(src)
    local playerName = GetPlayerName(src)

    print(("[Disconnect] Spieler %s (ID %s) hat den Server verlassen. Grund: %s"):format(playerName, playerId, reason))

    -- Beispiel: Speichere Spielerposition (wenn oxmysql verfügbar ist)
    local coords = GetEntityCoords(GetPlayerPed(src))
    exports.oxmysql:insert("INSERT INTO player_positions (identifier, x, y, z) VALUES (?, ?, ?, ?)", {
        playerId, coords.x, coords.y, coords.z
    })

    -- Optional: Fahrzeuge freigeben / despawnen
    -- TriggerEvent("your_vehicle_cleanup_logic", src)

    -- Optional: Discord Logging
    -- TriggerEvent("log:disconnect", playerId, playerName, reason)
end)