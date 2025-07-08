-- Optimiertes Zonenbeispiel mit ox_lib
lib.zones.sphere({
    coords = vec3(215.0, -810.0, 29.7),
    radius = 2.0,
    debug = false,
    inside = function()
        lib.showTextUI('[E] Jobmenü öffnen')
        if IsControlJustReleased(0, 38) then
            TriggerEvent('esx_jobs:openMenu')
        end
    end,
    onExit = function()
        lib.hideTextUI()
    end
})