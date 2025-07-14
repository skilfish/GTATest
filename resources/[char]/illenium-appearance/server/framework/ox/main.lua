-- Gefixte ox_core-Integration (ohne GetPlayerCalls)
local function getPlayer(source)
    return exports.ox_core:GetPlayer(source)
end

RegisterNetEvent('illenium:appearance:save', function(data)
    local src = source
    local player = Player(src)
    if not player then return end

    player.set('appearance', data)
end)
