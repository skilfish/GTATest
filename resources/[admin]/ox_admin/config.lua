Config = {}

-- 🌐 Webhook-Zuordnung je Aktionstyp
Config.Webhooks = {
    ban     = "https://discord.com/api/webhooks/DEIN-BAN-WEBHOOK",
    revive  = "https://discord.com/api/webhooks/DEIN-REVIVE-WEBHOOK",
    noclip  = "https://discord.com/api/webhooks/DEIN-NOCLIP-WEBHOOK",
    general = "https://discord.com/api/webhooks/DEIN-GENERAL-WEBHOOK"
}

-- 👥 Discord-Rollen-Zuordnung (discord:ID -> Rangname)
Config.DiscordRoles = {
    ["discord:123456789012345678"] = "Supporter",
    ["discord:234567890123456789"] = "Moderator",
    ["discord:345678901234567890"] = "Admin",
    ["discord:456789012345678901"] = "Projektleitung"
}
