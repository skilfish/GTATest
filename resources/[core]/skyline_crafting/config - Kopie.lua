Config = {

BlipSprite = 464,
BlipColor = 48,
BlipText = 'Werkbank',

UseLimitSystem = false, -- Enable if your esx uses limit system

CraftingStopWithDistance = true, -- Crafting will stop when not near workbench

ExperiancePerCraft = 2, -- The amount of experiance added per craft (100 Experiance is 1 level)

HideWhenCantCraft = false, -- Instead of lowering the opacity it hides the item that is not craftable due to low level or wrong job

Categories = {


['medical'] = {
	Label = 'GEGENSTÄNDE',
	Image = 'bandage',
	Jobs = {}
},


['waffenteile'] = {
	Label = 'WAFFENTEILE',
	Image = 'waffenteile',
	Jobs = {}
},

['weapons'] = {
	Label = 'WAFFEN',
	Image = 'WEAPON_APPISTOL',
	Jobs = {}
}


},

PermanentItems = { -- Items that dont get removed when crafting
	['wrench'] = true
},

Recipes = { -- Enter Item name and then the speed value! The higher the value the more torque

['waffenteil'] = {
	Level = 1, -- From what level this item will be craftable
	Category = 'waffenteile', -- The category item will be put in
	isGun = false, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 2, -- The amount that will be crafted
	SuccessRate = 100, -- 100% you will recieve the item
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 120, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['iron'] = 65, -- item name and count, adding items that dont exist in database will crash the script
		['aluminum'] = 35, 
		['gold2'] = 5
	}
}, 

['waffenteil2'] = {
	Level = 5, -- From what level this item will be craftable
	Category = 'waffenteile', -- The category item will be put in
	isGun = false, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 2, -- The amount that will be crafted
	SuccessRate = 100, -- 100% you will recieve the item
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 180, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['iron'] = 100, -- item name and count, adding items that dont exist in database will crash the script
		['aluminum'] = 65, 
		['gold2'] = 15
	}
}, 

['waffenteil3'] = {
	Level = 10, -- From what level this item will be craftable
	Category = 'waffenteile', -- The category item will be put in
	isGun = false, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 2, -- The amount that will be crafted
	SuccessRate = 100, -- 100% you will recieve the item
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 220, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['iron'] = 150, -- item name and count, adding items that dont exist in database will crash the script
		['aluminum'] = 100, 
		['gold2'] = 30
	}
}, 

['medikit'] = {
	Level = 0, -- From what level this item will be craftable
	Category = 'medical', -- The category item will be put in
	isGun = false, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 1, -- The amount that will be crafted
	SuccessRate = 100, -- 100% you will recieve the item
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 40, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['schwamm'] = 1, -- item name and count, adding items that dont exist in database will crash the script
		['bottle'] = 2
	}
}, 

['repairkit'] = {
	Level = 0, -- From what level this item will be craftable
	Category = 'medical', -- The category item will be put in
	isGun = false, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 1, -- The amount that will be crafted
	SuccessRate = 100, -- 100% you will recieve the item
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 60, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['iron'] = 3, -- item name and count, adding items that dont exist in database will crash the script
		['aluminum'] = 2
	}
}, 

['munition'] = {
	Level = 1, -- From what level this item will be craftable
	Category = 'medical', -- The category item will be put in
	isGun = false, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 1, -- The amount that will be crafted
	SuccessRate = 80, -- 100% you will recieve the item
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 120, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['iron'] = 35, -- item name and count, adding items that dont exist in database will crash the script
		['aluminum'] = 20,
		['gunpowder'] = 15

	}
}, 

['WEAPON_PISTOL'] = {
	Level = 1, -- From what level this item will be craftable
	Category = 'weapons', -- The category item will be put in
	isGun = true, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 1, -- The amount that will be crafted
	SuccessRate = 100, --  100% you will recieve the item
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 60 * 4, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['waffenteil'] = 15, -- item name and count, adding items that dont exist in database will crash the script
	}
}, 

['WEAPON_PISTOL50'] = {
	Level = 1, -- From what level this item will be craftable
	Category = 'weapons', -- The category item will be put in
	isGun = true, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 1, -- The amount that will be crafted
	SuccessRate = 100, --  100% you will recieve the item
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 60 * 6, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['waffenteil'] = 25, -- item name and count, adding items that dont exist in database will crash the script
		['waffenteil2'] = 5, -- item name and count, adding items that dont exist in database will crash the script

	}
},

['WEAPON_SMG'] = {
	Level = 1, -- From what level this item will be craftable
	Category = 'weapons', -- The category item will be put in
	isGun = true, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 1, -- The amount that will be crafted
	SuccessRate = 100, --  100% you will recieve the item
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 60 * 7, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['waffenteil'] = 25, -- item name and count, adding items that dont exist in database will crash the script
		['waffenteil2'] = 15, -- item name and count, adding items that dont exist in database will crash the script
		['waffenteil3'] = 10, -- item name and count, adding items that dont exist in database will crash the script

	}
}, 

['WEAPON_GUSENBERG'] = {
	Level = 1, -- From what level this item will be craftable
	Category = 'weapons', -- The category item will be put in
	isGun = true, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 1, -- The amount that will be crafted
	SuccessRate = 100, --  100% you will recieve the item
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 60 * 9, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['waffenteil'] = 35, -- item name and count, adding items that dont exist in database will crash the script
		['waffenteil2'] = 20, -- item name and count, adding items that dont exist in database will crash the script
		['waffenteil3'] = 15, -- item name and count, adding items that dont exist in database will crash the script

	}
}, 

['WEAPON_ADVANCEDRIFLE'] = {
	Level = 1, -- From what level this item will be craftable
	Category = 'weapons', -- The category item will be put in
	isGun = true, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 1, -- The amount that will be crafted
	SuccessRate = 100, --  100% you will recieve the item
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 60 * 10, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['waffenteil'] = 40, -- item name and count, adding items that dont exist in database will crash the script
		['waffenteil2'] = 25, -- item name and count, adding items that dont exist in database will crash the script
		['waffenteil3'] = 25, -- item name and count, adding items that dont exist in database will crash the script

	}
}, 

['WEAPON_KNIFE'] = {
	Level = 1, -- From what level this item will be craftable
	Category = 'weapons', -- The category item will be put in
	isGun = true, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 1, -- The amount that will be crafted
	SuccessRate = 100, --  100% you will recieve the item
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 60 * 1, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['waffenteil'] = 7, -- item name and count, adding items that dont exist in database will crash the script

	}
},



},

Workbenches = { -- Every workbench location, leave {} for jobs if you want everybody to access

		{coords = vector3(101.26113891602,6615.810546875,33.58126831054), jobs = {}, blip = true, recipes = {"munition" , "repairkit" , "medikit"}, radius = 4.0 },
		{coords = vector3(1188.7753, 2641.3069, 39.4019), jobs = {}, blip = false, recipes = {}, radius = 4.0 }


},
 

Text = {

    ['not_enough_ingredients'] = 'Du hast nicht alle Materialien!',
    ['you_cant_hold_item'] = 'Deine Taschen sind voll!',
    ['item_crafted'] = 'Gegenstand erfolgreich gebaut!',
    ['wrong_job'] = 'You cant open this workbench',
    ['workbench_hologram'] = '[~b~E~w~] WERKBANK',
    ['wrong_usage'] = 'Wrong usage of command',
    ['inv_limit_exceed'] = 'Inventory limit exceeded! Clean up before you lose more',
    ['crafting_failed'] = 'You failed to craft the item!'

}

}



function SendTextMessage(msg)
		TriggerEvent("skyline_notify:Alert", "WERKBANK" , msg , 3000 , "info") 
end

