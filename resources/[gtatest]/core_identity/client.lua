-- ox_lib UI für Charaktereingabe
RegisterNetEvent('core_identity:openRegistration', function()
    local input = lib.inputDialog('Charakter erstellen', {
        {type = 'input', label = 'Vorname', placeholder = 'Max'},
        {type = 'input', label = 'Nachname', placeholder = 'Mustermann'},
        {type = 'date', label = 'Geburtsdatum'},
        {type = 'select', label = 'Geschlecht', options = {
            {label = 'Männlich', value = 'm'},
            {label = 'Weiblich', value = 'f'}
        }}
    })

    if not input then return end
    TriggerServerEvent('core_identity:register', input)
end)
