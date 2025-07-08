Config = {}
function L(cd) if Locales[Config.Language][cd] then return Locales[Config.Language][cd] else print('Locale is nil ('..cd..')') end end


--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


Config.Framework = 'esx' ---[ 'esx' / 'qbcore' / 'vrp' / 'none' / 'other' ] Choose your framework.
Config.Language = 'DE' --[ 'EN' / 'BG' / 'DE' / 'CZ' / 'ES' / 'FI' / 'FR' / 'NL' / 'PT' / 'SE' / 'SK' ] You can add your own locales to the Locales.lua. But make sure to change the Config.Language to match it.

Config.FrameworkTriggers = { --You can change the esx/qbus events (IF NEEDED).
    main = 'skylineistback:getSharedObject',   --ESX = 'esx:getSharedObject'   QBCORE = 'QBCore:GetObject'
    load = 'skyline:playerLoaded',      --ESX = 'esx:playerLoaded'      QBCORE = 'QBCore:Client:OnPlayerLoaded'
    job = 'skyline:setJob',             --ESX = 'esx:setJob'            QBCORE = 'QBCore:Client:OnJobUpdate'
    resource_name = 'es_extended'   --ESX = 'es_extended'           QBCORE = 'qb-core'
}

Config.NotificationType = { --[ 'esx' / 'qbcore' / 'mythic_old' / 'mythic_new' / 'chat' / 'other' ] Choose your notification script.
    client = 'esx' 
}


--██╗███╗   ███╗██████╗  ██████╗ ██████╗ ████████╗ █████╗ ███╗   ██╗████████╗
--██║████╗ ████║██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║╚══██╔══╝
--██║██╔████╔██║██████╔╝██║   ██║██████╔╝   ██║   ███████║██╔██╗ ██║   ██║   
--██║██║╚██╔╝██║██╔═══╝ ██║   ██║██╔══██╗   ██║   ██╔══██║██║╚██╗██║   ██║   
--██║██║ ╚═╝ ██║██║     ╚██████╔╝██║  ██║   ██║   ██║  ██║██║ ╚████║   ██║   
--╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝

Config.FuelScript = 'legacyfuel' --[ 'none' / 'legacyfuel' / 'frfuel' / 'other' ] Choose your fuel script so we can get a vehicles fuel to display on the carhud UI.


--███╗   ███╗ █████╗ ██╗███╗   ██╗
--████╗ ████║██╔══██╗██║████╗  ██║
--██╔████╔██║███████║██║██╔██╗ ██║
--██║╚██╔╝██║██╔══██║██║██║╚██╗██║
--██║ ╚═╝ ██║██║  ██║██║██║ ╚████║
--╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝


Config.DisableExitingVehicle = false --Do you want to disable exiting the vehicle when the seatbelt is enabled? (If this is enabled, this will increase the ms usage slightly).
Config.HideMiniMap = false --Do you want the mini-map to be hidden when the player is on foot, and only show when a player is in a vehicle? (if disabled the mini-map will always be visible).


--██╗  ██╗███████╗██╗   ██╗███████╗     █████╗ ███╗   ██╗██████╗      ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
--██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝    ██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
--█████╔╝ █████╗   ╚████╔╝ ███████╗    ███████║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
--██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║    ██╔══██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
--██║  ██╗███████╗   ██║   ███████║    ██║  ██║██║ ╚████║██████╔╝    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
--╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝


Config.Settings = {
    ENABLE = true, --Do you want to allow player's to use the settings UI?
    command = 'carhud', --The chat command.
    key = 'y', --The key to press.
    description = L('settings_description'), --The chat suggestion description.
}

Config.Seatbelt = {
    ENABLE = true, --Do you want to use the built-in seatbelt?
    command = 'seatbelt', --The chat command to toggle the seatbelt.
    key = 'b', --Customise the key to toggle the seatbelt.
    description = L('seatbelt_description'),

    eject = true, --Do you want player's to be ejected from the vehicle when they crash hard enough?
    ragdoll = true, --Do you want player's to ragdoll for a short time after being ejected from a vehicle?
    tyrepop = true, --Do you want a random tyre to pop when they crash hard enough?
}

Config.Cruise = {
    ENABLE = true, --Do you want to use the built-in cruise control?
    command = 'cruise',
    key = 'equals',
    description = L('cruise_description'),
}

Config.ToggleCarhud = {
    ENABLE = true, --Do you want to allow player's to show/hide their carhud UI?
    command = 'carhudtoggle',
    description = L('togglecarhud_description'),
    minimap = true, --Do you want the map to be hidden while the main carhud UI is hidden?
}