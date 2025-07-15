local function sendWebhook(url, embed)
    PerformHttpRequest(url, function() end, 'POST', json.encode({ embeds = { embed } }), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('combat:flushBuffer')
AddEventHandler('combat:flushBuffer', function(buffer)
    for _, data in ipairs(buffer) do
        local color = (data.bone == 'HEAD') and 16711680 or 16776960 -- rot bei Headshot, gelb sonst
        local embed = {
            title = data.kill and "Kill-Log" or "Hit-Log",
            description = string.format("**%s** hat **%s** mit **%s** getroffen.", data.sourceName, data.targetName, data.weapon),
            color = color,
            fields = {
                { name = "Distanz", value = data.distance .. "m", inline = true },
                { name = "Körperteil", value = data.bone, inline = true },
            },
            footer = { text = os.date("%Y-%m-%d %H:%M:%S") }
        }
        local webhook = data.kill and Config.WebhookKill or Config.WebhookHit
        sendWebhook(webhook, embed)
    end
end)
