
Config = {}

-- set at least one to false, otherwise both menus will clash
--   and don't forget to comment the menu in the fxmanifest.lua if you don't use it!
--   Setting both to true does not work!
-- setting both to false results in no menu being usable at all
-- you can then just include the exports in your own menu if you have one
Config.useContextMenu = false
Config.useNativeUI = true

-- set to nil if you don't want to use the command
Config.lockCommand = nil
-- set to nil if you don't want to use the button (default 73, X)
Config.lockKey = 182

-- set to nil if you don't want to use the command
Config.keyMenuCommand = "key"
-- set to nil if you don't want to use the button (default 311, K)
Config.keyMenuKey = 166

-- maximum distance (in meters) between the player and ContextMenu interaction point
Config.maxDistance = 5.0

-- number of items in a menu where vehicles should be separated into categories (only ContextMenu)
Config.subCategoryThreshhold = 10

-- you can define more keymakers by just adding additional entries
Config.Keymakers = {
	{
		-- ped model (yes, the ` symbols are correct)
		model = `s_m_m_autoshop_01`,
		-- position and heading vector4(x, y, z, heading)
		pos = vector4(170.33, -1799.13, 28.32, 313.0)
	},
}

-- if the vehicle owner should be able to give away his vehicle
Config.enableGiveAwayMasterKey = true

-- define costs for creating a new key and exchanging locks
Config.Costs = {
	newKey			= 500,
	exchangeLocks	= 5000
}

-- define job vehicles like this (this acts as a key for those vehicles)
--   models in ``
--   either exact plates or just a string that should be in the vehicles plate
--     e.g. "LSPD" will let a police officer lock/unlock any vehicle with the plate "LSPD1337" or "13LSPD37"
Config.JobVehicles = {
-- examples:
	--["police"] = {
	--	models = {
	--		`police`,
	--		`policeb`,
	--		`pbus`
	--	},
	--	plates = {
	--		"LSPD",
	--		"POL"
	--	}
	--},
	--["mechanic"] = {
	--	models = {
	--		`flatbed`
	--	},
	--	plates = {
	--		"MECH"
	--	}
	--},
}

-- this list allows specific vehicle models to be excluded from their keys being given away
Config.modelBlacklist = {
	--`bison`,
}

Config.Strings = {
	keymaker		= "Schlüsselhersteller",

	helpText		= "Drücke ~INPUT_CONTEXT~ um mit dem Schlüsselmacher zu sprechen.",

	lockNotif		= "Fahrzeug gesperrt",
	unlockNotif		= "Fahrzeug entriegelt",

	createSuccess	= "Erstellt einen neuen Schlüssel für %s.",
	createNoMoney	= "Du hast nicht genug Geld, um einen neuen Schlüssel zu bezahlen!",
	createFailed	= "Fehler beim Erstellen des neuen Schlüssels für %s!",

	giveSuccess		= "Schlüssel %s der nächsten Person gegeben.",
	giveSuccessPly	= "Schlüssel %s von der nächsten Person erhalten.",
	giveFailed		= "Geben des Schlüssels %s an die nächste Person ist fehlgeschlagen!",

	giveMasterSuccess		= "Hauptschlüssel %s der nächsten Person gegeben.",
	giveMasterSuccessPly	= "Hauptschlüssel %s  von der nächsten Person erhalten.",
	giveMasterFailed		= "Das Übergeben des Hauptschlüssels %s an die nächste Person ist fehlgeschlagen!",

	removeSuccess	= "Einer der Schlüssel %s wurde aus der Tasche entfernt.",
	removeNoMoney	= "Du hast nicht genug Geld, um neue Schlösser zu bezahlen!",
	removeFailed	= "Entfernen des Schlüssels %s fehlgeschlagen!",

	deleteKeys		= "Schloss ausgetauscht und alle Schlüssel für %s ungültig gemacht.",

	-- NativeUI
	NUI = {
		-- keymaker menu
		keymakerMenuTitle	= "Schlüsselhersteller",
		keymakerMenuSub		= "~b~Erstellen und verwalten deine Schlüssel!",

		-- create key
		createKeyTitle		= "Erstelle neue Schlüssel (500$)",
		createKeyDesc		= "Erstelle einen neuen Schlüssel für eines deiner Fahrzeuge (500$)",
		createVehicleKey	= "Erstelle einen Schlüssel für %s mit dem Kennzeichen %s.",

		-- invalidate Key
		invalKeyTitle		= "Fahrzeugschlösser tauschen (5000$)",
		invalKeyDesc		= "Tausche  die Schlösser an Ihren Fahrzeugen aus und mache alle Schlüssel dafür ungültig.",
		invalVehicleKey		= "Tausche die Schlösser von Ihrem %s mit dem Kennzeichen aus %s.",

		-- key Inventory
		keyInventoryTitle	= "Schlüsselinventar",
		keyInventorySub		= "~b~Verwalten deine Schlüssel!",

		-- master keys
		masterKeysTitle		= "Hauptschlüssel",
		masterKeysDesc		= "Zeigt eine Liste aller im Besitz befindlichen Hauptschlüssel an.",
		giveMasterKeyTitle	= "Hauptschlüssel geben",
		giveMasterKeyDesc	= "Geben dieses Fahrzeug und seinen Hauptschlüssel an die nächste Person weiter.",

		-- additional keys
		keysTitle			= "Zusätzliche Schlüssel",
		keysDesc			= "Zeigt eine Liste aller Zusatztasten.",
		giveKeyTitle		= "Schlüssel geben",
		giveKeyDesc			= "Gebe diesen Schlüssel der nächsten Person.",
		removeKeyTitle		= "Schlüssel entfernen",
		removeKeyDesc		= "Entferne einen dieser Fahrzeugschlüssel aus deiner Tasche.",
	},

	-- ContextMenu
	CM = {
		-- keymaker menu
		createKeyTitle		= "Erstellen Sie neue Schlüssel",
		invalKeyTitle		= "Fahrzeugschlösser tauschen",

		-- key inventory
		masterKeysTitle		= "Hauptschlüssel",
		keysTitle			= "Zusätzliche Schlüssel",

		-- other player
		giveKey				= "Schlüssel geben",
		giveMasterKey		= "Meister geben",
		safetyConfirm		= "Bist du sicher?",
		safetyConfirmYes	= "Ja, Überführungsfahrzeug"
	}
}

Config.VehicleClasses = {
	"Compacts",
	"Sedans",
	"SUVs",
	"Coupes",
	"Muscle",
	"Sports Classics",
	"Sports",
	"Super",
	"Motorcycles",
	"Off-Road",
	"Industrial",
	"Utility",
	"Vans",
	"Cycles",
	"Boats",
	"Helicopters",
	"Planes",
	"Service",
	"Emergency",
	"Military",
	"Commercial",
	"Trains"
}
