local buffer = {}

RegisterNetEvent('combat:playerHit', function(data)
    if not data or data.source == -1 or data.source == data.target then return end
    if data.targetType ~= 'player' then return end
    table.insert(buffer, data)
end)

CreateThread(function()
    while true do
        Wait(Config.BufferTime * 1000)
        if #buffer > 0 then
            TriggerServerEvent('combat:flushBuffer', buffer)
            buffer = {}
        end
    end
end)
