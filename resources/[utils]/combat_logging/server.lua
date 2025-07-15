local function sendWebhook(url, message)
    PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({content = message}), {['Content-Type'] = 'application/json'})
end

RegisterServerEvent('combat:logHit')
AddEventHandler('combat:logHit', function(data)
    local src = source
    local name = GetPlayerName(src)
    local targetName = data.targetName or 'Unbekannt'
    local weapon = data.weapon or 'Unbekannt'
    local distance = data.distance or 0
    local bodypart = data.bodypart or 'Unbekannt'

    local msg = ('🔫 HIT: %s → %s | %s | %sm | %s'):format(name, targetName, weapon, distance, bodypart)
    sendWebhook('YOUR_WEBHOOK_HIT_URL_HERE', msg)
end)

RegisterServerEvent('combat:logKill')
AddEventHandler('combat:logKill', function(data)
    local src = source
    local name = GetPlayerName(src)
    local targetName = data.targetName or 'Unbekannt'
    local weapon = data.weapon or 'Unbekannt'
    local distance = data.distance or 0
    local bodypart = data.bodypart or 'Unbekannt'

    local msg = ('💀 KILL: %s → %s | %s | %sm | %s'):format(name, targetName, weapon, distance, bodypart)
    sendWebhook('YOUR_WEBHOOK_KILL_URL_HERE', msg)
end)
