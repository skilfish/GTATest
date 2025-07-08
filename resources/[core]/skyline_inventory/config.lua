Config = {} -- do not edit 

-- Version / Important
Config.PlayerWeight = true -- only works if you are using SKYLINE 1.2 and above.

-- General
Config.DefaultOpenKey = "F2" -- default open key (users can change in their settings) | FiveM Keys
Config.DropTimeout = 120 -- change the amount of time that drops will stay on the ground (seconds)
Config.CloseOnUse = {"", "", ""} -- all items in this array will close the inventory when used
Config.ClickOutsideToClose = true -- when the user clicks outside of the inventory it will close
Config.MiddleClickToUse = true -- uses item when middle click is pressed over an item
Config.Blur = false -- blurs background
Config.SoundEffects = true -- toggle sound effects on/off

-- Discord
Config.Discord = false -- enables discord logs
Config.WebhookURL = "https://discord.com/api/webhooks/967061659912925205/z0B0_8dNJBWoSt_h6nkycIzSHqSMuue912J6dGAWLe13FaKDYflNf2ZU9LX0SkapMi0K" -- discord webhook url

-- Inventory
Config.Items = true -- toggle items on/off
Config.Weapons = true -- toggle weapon on/off
Config.Cash = true -- toggle cash on/off
Config.DirtyCash = 'black_money' -- toggle dirty cash on/off (put your black_money `id` here from SKYLINE or put `false` if you dont want dirty cash)


-- Only applies for Weapons and Cash if Config.PlayerWeight is enabled.
Config.Weights = {
    ["cash"] = 0,
    ["black_money"] = 0,
    ["WEAPON_PISTOL"] = 8
}

-- Plugins
Config.Player = true -- toggle player plugin on/off
Config.Glovebox = true -- toggle glovebox on/off
Config.Trunk = true -- toggle trunk plugin on/off
Config.Rob = false -- toggle rob plugin on/off

-- Rob
Config.HandsupKey = "h" -- default handsup key (users can change in their settings) | FiveM Keys
Config.RobTimeout = 3000 -- amount of time it takes for the Robbery to load (server loading wont be affected) (milliseconds)
Config.BlacklistedItems = {"money", "", ""} -- will not allow the robber to remove items that are put in this array

-- Glovebox 
Config.GloveboxWeight = 5000 -- weight of glovebox
Config.GloveboxTimeout = 1000 -- amount of time it takes for the Glovebox to load (server loading wont be affected) (milliseconds)
Config.GloveboxSave = true -- saves glovebox to database (owned_vehicles required in database)
Config.BlacklistedVehicleTypesGB = {13, 8} -- vehicle types that should not have a glovebox

-- Trunk
Config.TrunkKey = "K" -- default trunk open key (users can change in their settings) | FiveM Keys
Config.TrunkSave = true -- must have a owned_vehicles table in your database
Config.TrunkTimeout = 1000 -- amount of time it takes for the Trunk to load (server loading wont be affected) (milliseconds)
Config.BlacklistedVehicleTypes = {13, 8} -- Cycles and Motorcycles
Config.TrunkWeights = {
    [0] = 10000, --Compact
    [1] = 5000, --Sedan
    [2] = 15000, --SUV
    [3] = 5000, --Coupes
    [4] = 7500, --Muscle
    [5] = 2500, --Sports Classics
    [6] = 2500, --Sports
    [7] = 2500, --Super
    [8] = 0, --Motorcycles
    [9] = 10000, --Off-road
    [10] = 20000, --Industrial
    [11] = 5000, --Utility
    [12] = 55000, --Vans
    [13] = 0, --Cycles
    [14] = 300, --Boats
    [15] = 0, --Helicopters
    [16] = 0, --Planes
    [17] = 500, --Service
    [18] = 1000, --Emergency
    [19] = 500, --Military
    [20] = 25000, --Commercial
    [21] = 0 --Trains
}