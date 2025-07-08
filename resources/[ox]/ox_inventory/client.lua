-- Beispielhafte Item-Usages (ox_inventory)
lib.callback.register('ox_inventory:useItem', function(item, slot, data)
    if item.name == 'bread' then
        TriggerEvent('esx_status:add', 'hunger', 200000)
        TriggerServerEvent('ox_inventory:notify', 'success', 'Du hast Brot gegessen.')
        return true
    elseif item.name == 'water' then
        TriggerEvent('esx_status:add', 'thirst', 200000)
        TriggerServerEvent('ox_inventory:notify', 'success', 'Du hast Wasser getrunken.')
        return true
    end
end)
