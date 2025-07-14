local Config = require "ox_admin.config"

function getDiscordIdentifier(src)
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.sub(id, 1, 8) == "discord:" then
            return id
        end
    end
    return "discord:0"
end

function getPlayerRole(discordID)
    return Config.DiscordRoles[discordID] or "Unbekannt"
end

function sendToDiscord(title, description, color, actionType)
    local webhookUrl = Config.Webhooks[actionType] or Config.Webhooks["general"]
    local embed = {
        {
            ["title"] = title,
            ["description"] = description,
            ["color"] = color or 16711680,
            ["footer"] = {
                ["text"] = "ox_admin Logsystem"
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }

    PerformHttpRequest(webhookUrl, function(err, text, headers) end, "POST", json.encode({ embeds = embed }), {
        ["Content-Type"] = "application/json"
    })
end

function logAdminAction(source, action, actionType)
    local name = GetPlayerName(source)
    local discordID = getDiscordIdentifier(source)
    local role = getPlayerRole(discordID)

    local msg = ("**Spieler:** %s\n**Rang:** %s\n**Aktion:** %s\n**Discord-ID:** %s")
        :format(name, role, action, discordID)

    sendToDiscord("🔔 Admin-Aktion", msg, 3447003, actionType)
end
