Config = {}


Config.Mining = {
    ChanceToGetItem = 60, -- if math.random(0, 100) <= ChanceToGetItem then give item
    Items = {
    	'aluminum_ore', 'aluminum_ore', 'aluminum_ore', 'aluminum_ore', 'aluminum_ore',
    	'iron_ore', 'iron_ore', 'iron_ore', 'iron_ore',
        "gunpowder", "gunpowder",
    	'gold_ore'
    },
    Objects = {
        ['pickaxe'] = 'prop_tool_pickaxe',
    },

    MiningPositions = {
        {coords = vector3(2992.77, 2750.64, 42.78), heading = 209.29},
        {coords = vector3(2983.03, 2750.90, 41.02), heading = 214.08},
        {coords = vector3(2976.74, 2740.94, 42.63), heading = 246.21},
        {coords = vector3(3003.53, 2762.80, 42.37), heading = 262.86},
        {coords = vector3(3004.56, 2773.01, 42.03), heading = 273.75},
        {coords = vector3(2934.81, 2762.60, 43.14), heading = 105.77},
        {coords = vector3(2928.96, 2759.09, 44.09), heading = 121.55},
        {coords = vector3(2911.58, 2779.23, 44.33), heading = 113.32},
        {coords = vector3(2907.41, 2788.16, 45.40), heading = 102.02},
        {coords = vector3(2913.32, 2796.60, 43.27), heading = 77.61 },
        {coords = vector3(2946.08, 2726.14, 47.69), heading = 120.14},
        {coords = vector3(2935.08, 2742.24, 44.19), heading = 118.27}
    }
    
}
