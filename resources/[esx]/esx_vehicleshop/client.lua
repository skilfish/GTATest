-- Fahrzeugshop-Zone mit lib.zones
lib.zones.sphere({
    coords = vec3(-56.49, -1096.58, 26.42),
    radius = 2.0,
    inside = function()
        lib.showTextUI('[E] Fahrzeug kaufen')
        if IsControlJustReleased(0, 38) then
            TriggerEvent('esx_vehicleshop:openShopMenu')
        end
    end,
    onExit = function()
        lib.hideTextUI()
    end
})