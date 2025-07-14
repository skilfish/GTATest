lib.callback.register('spawn_core:getSpawnPosition', function(source)
    local pos = getLastKnownPositionFromDB(source)
    if not pos then
        pos = Config.DefaultSpawn
        logSpawnIssue(source, "Default spawn used - no saved position")
    end

    return pos
end)

function logSpawnIssue(src, reason)
    if not Config.LoggingWebhook then return end

    local playerName = GetPlayerName(src)
    PerformHttpRequest(Config.LoggingWebhook, function() end, "POST", json.encode({
        username = "Spawn Logger",
        embeds = {{
            title = "Spawn Info",
            description = ("Player **%s** used fallback spawn.
Reason: `%s`"):format(playerName, reason),
            color = 16711680
        }}
    }), { ["Content-Type"] = "application/json" })
end
