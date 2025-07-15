
local hitBuffer = {}
local lastSent = {}

local function sendWebhook(data)
    local embed = {
        {
            title = data.title,
            description = data.description,
            color = data.color or 16776960, -- default gelb
            footer = { text = os.date('%Y-%m-%d %H:%M:%S') }
        }
    }
    PerformHttpRequest(Config.WebhookURL, function() end, 'POST', json.encode({ embeds = embed }), { ['Content-Type'] = 'application/json' })
end

CreateThread(function()
    while true do
        Wait(10000)
        for id, logs in pairs(hitBuffer) do
            for _, log in ipairs(logs) do
                sendWebhook(log)
            end
        end
        hitBuffer = {}
    end
end)

RegisterNetEvent('combat:handleHit', function(data)
    local src = source
    if not data or not data.victim or not data.weapon or not data.bone then return end
    if tonumber(data.victim) == tonumber(src) then return end -- self hit
    if GetPlayerName(data.victim) == nil then return end -- NPC or invalid

    local attackerName = GetPlayerName(src)
    local victimName = GetPlayerName(data.victim)
    local distance = tonumber(data.distance) or 0
    local bone = data.bone
    local weapon = data.weapon

    local log = {
        title = "💥 Treffer-Log",
        description = ("**%s** traf **%s** mit **%s**
📍 **Körperteil:** %s
📏 **Distanz:** %.2f m"):format(attackerName, victimName, weapon, bone, distance),
        color = (bone == "HEAD" or bone == "head") and 16711680 or 16776960
    }

    hitBuffer[src] = hitBuffer[src] or {}
    table.insert(hitBuffer[src], log)
end)
