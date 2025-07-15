local function copyCoordsToClipboard()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vector = ('vec3(%.2f, %.2f, %.2f)'):format(coords.x, coords.y, coords.z)
    lib.setClipboard(vector)
    lib.notify({
        title = 'Koordinaten kopiert',
        description = vector,
        type = 'inform'
    })
end

lib.registerContext({
    id = 'admin_utils_menu',
    title = 'Admin Utilities',
    options = {
        {
            title = '📌 Koordinaten kopieren',
            description = 'Kopiert aktuelle Position ins Clipboard',
            icon = 'map-pin',
            onSelect = copyCoordsToClipboard,
        },
    }
})

RegisterCommand('adminutils', function()
    if IsAceAllowed('adminutils.menu') then
        lib.showContext('admin_utils_menu')
    else
        lib.notify({ type = 'error', description = 'Keine Berechtigung' })
    end
end, false)

RegisterKeyMapping('adminutils', 'Admin Utils Menü öffnen', 'keyboard', 'F10')