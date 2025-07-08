
SKYLINE.RegisterUsableItem('brot', function(source)

	local _source = source
    local xPlayer = SKYLINE.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('brot', 1)

	TriggerClientEvent('statusundso:add', source, 'hunger', 200000)
	TriggerClientEvent('essenundtrinken:onEat', source)
    TriggerClientEvent("skyline_notify:Alert", source, "TASCHE" , "Du hast 1x <b style=color:yellow;>Brot</b> gegessen." , 3000 , "success")

end)

SKYLINE.RegisterUsableItem('wasser', function(source)

	local _source = source
    local xPlayer = SKYLINE.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('wasser', 1)

	TriggerClientEvent('statusundso:add', source, 'thirst', 200000)
	TriggerClientEvent('essenundtrinken:onDrink', source)
    TriggerClientEvent("skyline_notify:Alert", source, "TASCHE" , "Du hast 1x <b style=color:yellow;>Wasser</b> getrunken." , 3000 , "success")

end)
