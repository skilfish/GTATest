-- Zonenbasierter Zugang zum Polizei-Menü
lib.zones.sphere({
    coords = vec3(450.0, -980.0, 30.6),
    radius = 2.0,
    inside = function()
        lib.showTextUI('[E] Polizei-Menü')
        if IsControlJustReleased(0, 38) then
            TriggerEvent('esx_policejob:openMenu')
        end
    end,
    onExit = function()
        lib.hideTextUI()
    end
})