function sendLog(type, title, description, color)
    local webhook = Config.Logging.Webhooks[type]
    if not webhook then return end

    local embed = {{
        title = title or "Log",
        description = description or "Keine Beschreibung.",
        color = color or 16777215,
        footer = {{
            text = os.date("%Y-%m-%d %H:%M:%S")
        }}
    }}

    PerformHttpRequest(webhook, function() end, "POST", json.encode({
        username = "RP Logbot",
        embeds = embed
    }), { ["Content-Type"] = "application/json" })
end
