local logFile = "ox_admin_logs.txt"
local webhook = 'https://discord.com/api/webhooks/YOUR_WEBHOOK_URL'

function logAction(action, detail)
    local message = ('[%s] %s: %s\n'):format(os.date('%Y-%m-%d %H:%M:%S'), action, detail)

    -- Datei loggen
    SaveResourceFile(GetCurrentResourceName(), logFile, message, -1)

    -- Konsole
    print('^2[ox_admin LOG]^7 ' .. message)

    -- Discord Webhook
    PerformHttpRequest(webhook, function() end, 'POST', json.encode({
        username = 'ox_admin Logs',
        embeds = {{
            title = action,
            description = detail,
            color = 65352,
            footer = { text = os.date('%c') }
        }}
    }), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('oxadmin:log')
AddEventHandler('oxadmin:log', function(action, detail)
    logAction(action, detail)
end)
