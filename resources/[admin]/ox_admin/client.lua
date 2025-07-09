local menuOpen = false

RegisterCommand('adminmenu', function()
    if menuOpen then return end
    menuOpen = true

    local options = {}

    if IsPlayerAceAllowed(PlayerId(), 'oxadmin.revive') then
        options[#options+1] = {
            title = '🩺 Revive Spieler',
            icon = 'heart',
            onSelect = function()
                local input = lib.inputDialog('Revive Spieler', {'Spieler-ID'})
                if input and input[1] then
                    TriggerServerEvent('oxadmin:reviveTarget', tonumber(input[1]))
                end
            end
        }
    end

    if IsPlayerAceAllowed(PlayerId(), 'oxadmin.noclip') then
        options[#options+1] = {
            title = '🚀 Noclip umschalten',
            icon = 'fighter-jet',
            onSelect = function()
                TriggerEvent('oxadmin:noclip')
            end
        }
    end

    if IsPlayerAceAllowed(PlayerId(), 'oxadmin.kick') then
        options[#options+1] = {
            title = '🚪 Spieler kicken',
            icon = 'door-open',
            onSelect = function()
                local input = lib.inputDialog('Kick Spieler', {'Spieler-ID'})
                if input and input[1] then
                    ExecuteCommand('kick ' .. input[1])
                end
            end
        }
    end

    if IsPlayerAceAllowed(PlayerId(), 'oxadmin.ban') then
        options[#options+1] = {
            title = '⛔ Spieler bannen',
            icon = 'ban',
            onSelect = function()
                local input = lib.inputDialog('Ban Spieler', {'Spieler-ID'})
                if input and input[1] then
                    ExecuteCommand('ban ' .. input[1])
                end
            end
        }
    end

    if IsPlayerAceAllowed(PlayerId(), 'oxadmin.giveitem') then
        options[#options+1] = {
            title = '🎁 Item geben',
            icon = 'box',
            onSelect = function()
                local input = lib.inputDialog('Item geben', {'Spieler-ID', 'Item', 'Anzahl'})
                if input and input[1] and input[2] then
                    ExecuteCommand(('giveitem %s %s %s'):format(input[1], input[2], input[3] or 1))
                end
            end
        }
    end

    if IsPlayerAceAllowed(PlayerId(), 'oxadmin.givemoney') then
        options[#options+1] = {
            title = '💵 Geld geben',
            icon = 'money-bill-wave',
            onSelect = function()
                local input = lib.inputDialog('Geld geben', {'Spieler-ID', 'Betrag'})
                if input and input[1] and input[2] then
                    ExecuteCommand(('givemoney %s %s'):format(input[1], input[2]))
                end
            end
        }
    end

    lib.registerContext({
        id = 'admin_main_menu',
        title = '🛠 Admin-Menü',
        options = options
    })

    lib.showContext('admin_main_menu')
    menuOpen = false
end, false)

RegisterKeyMapping('adminmenu', 'Admin-Menü öffnen', 'keyboard', 'F10')
