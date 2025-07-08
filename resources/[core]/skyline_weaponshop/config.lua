Config = {

	BlipSprite = 110, -- Blip sprite type (https://docs.fivem.net/docs/game-references/blips/)
	BlipColor = 5, --  Blip color id (https://docs.fivem.net/docs/game-references/blips/)
	WeaponShopCoords = {vector3(22.4877, -1106.8114, 29.7970)},
	BlackMarketCoords = {vector3(-1166.9, -3051.5, 14)},

	WeaponDataSaveInterval = 10, -- Time in seconds when weapon and armor data is saved


	licenses = {},


	GunShops = {
		WeaponShop = { -- If any category is removed it will grey out. Each category can have as many items as wanted
			ShopName = "WAFFENLADEN",
				["pistols"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_pistol"] = {label = "FN-502", price = 35000}
				},

				["rifles"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_assaultrifle"] = {label = "ASSAULT RIFLE", price = 10000}, -- Item id and price
					["weapon_carbinerifle"] = {label = "CARBINE RIFLE", price = 10000}, -- Item id and price
					["weapon_advancedrifle"] = {label = "ADVANCED RIFLE", price = 10000}, -- Item id and price
					["weapon_specialcarbine"] = {label = "SPECIAL CARBINE", price = 10000}, -- Item id and price
					["weapon_bullpuprifle"] = {label = "BULLPUP RIFLE", price = 10000}, -- Item id and price
					["weapon_compactrifle"] = {label = "COMPACT RIFLE", price = 10000}, -- Item id and price
				},

				["snipers"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_sniperrifle"] = {label = "SNIPER RIFLE", price = 10000}, -- Item id and price
					["weapon_heavysniper"] = {label = "HEAVY SNIPER", price = 10000}, -- Item id and price
					["weapon_marksmanrifle"] = {label = "MARKSMAN RIFLE", price = 10000}, -- Item id and price
				},

				["smgs"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_smg"] = {label = "SMG", price = 10000}, -- Item id and price
					["weapon_microsmg"] = {label = "MICRO SMG", price = 10000}, -- Item id and price
					["weapon_assaultsmg"] = {label = "ASSAULT SMG", price = 10000}, -- Item id and price
					["weapon_combatpdw"] = {label = "COMBAT PDW", price = 10000}, -- Item id and price
					["weapon_machinepistol"] = {label = "MACHINE PISTOL", price = 10000}, -- Item id and price
					["weapon_minismg"] = {label = "MINI SMG", price = 10000}, -- Item id and price
				},

				["lmgs"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_mg"] = {label = "MACHINE GUN", price = 10000}, -- Item id and price
					["weapon_combatmg"] = {label = "COMBAT MACHINE GUN", price = 10000}, -- Item id and price
					["weapon_gusenberg"] = {label = "GUSENBERG SWEEPER", price = 10000}, -- Item id and price
				},

				["shotguns"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_pumpshotgun"] = {label = "PUMP SHOTGUN", price = 10000}, -- Item id and price
					["weapon_sawnoffshotgun"] = {label = "SAWED-OFF SHOTGUN", price = 10000}, -- Item id and price
					["weapon_assaultshotgun"] = {label = "ASSAULT SHOTGUN", price = 10000}, -- Item id and price
					["weapon_bullpupshotgun"] = {label = "BULLPUP SHOTGUN", price = 10000}, -- Item id and price
					["weapon_heavyshotgun"] = {label = "HEAVY SHOTGUN", price = 10000}, -- Item id and price
					["weapon_dbshotgun"] = {label = "DOUBLE BARREL SHOTGUN", price = 10000}, -- Item id and price
					["weapon_autoshotgun"] = {label = "SWEEPER SHOTGUN", price = 10000}, -- Item id and price

				},

				["ammo"] = { -- each ammo category already gives ammo to all of the same category guns for example "AMMO_PISTOL" gives ammo to ALL pistols and "AMMO_SMG" gives ammo to ALL smgs. So you don't need to add a specific weapon. 
					["MUNITION"] = {label = "Munition", amount = 1, price = 1000}


				},


				["armor"] = {
					["20"] = {label = "LEICHTE WESTE", percentage = "20", price = 1500}, -- Item id and price
					["50"] = {label = "NORMALE WESTE", percentage = "50", price = 3000}, -- Item id and price
					["100"] = {label = "SCHWERE WESTE", percentage = "1000", price = 5000}, -- Item id and price
				},


				["attachments"] = {},


				["melee"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_knife"] = {label = "MESSER", price = 50000}, -- Item id and price
					["weapon_bat"] = {label = "BASEBALLSCHLÄGER", price = 5000}


				},
		},

		BlackMarket = { -- If any category is removed it will grey out. Each category can have as many items as wanted
			ShopName = "BLACK MARKET",
				["pistols"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_pistol"] = {label = "PISTOL", price = 10000}, -- Item id and price
					["weapon_appistol"] = {label = "AP PISTOL", price = 10000}, -- Item id and price
					["weapon_combatpistol"] = {label = "COMBAT PISTOL", price = 10000}, -- Item id and price
					["weapon_stungun"] = {label = "STUN GUN", price = 10000}, -- Item id and price
					["weapon_pistol50"] = {label = "PISTOL 50", price = 10000}, -- Item id and price
					["weapon_snspistol"] = {label = "SNS PISTOL", price = 10000}, -- Item id and price
					["weapon_heavypistol"] = {label = "HEAVY PISTOL", price = 10000}, -- Item id and price
					["weapon_vintagepistol"] = {label = "VINTAGE PISTOL", price = 10000}, -- Item id and price
					["weapon_marksmanpistol"] = {label = "MARKSMAN PISTOL", price = 10000}, -- Item id and price
					["weapon_doubleaction"] = {label = "ACTION REVOLVER", price = 10000}, -- Item id and price
					["weapon_revolver"] = {label = "REVOLVER", price = 10000}, -- Item id and price
				},

				["rifles"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_assaultrifle"] = {label = "ASSAULT RIFLE", price = 10000}, -- Item id and price
					["weapon_carbinerifle"] = {label = "CARBINE RIFLE", price = 10000}, -- Item id and price
					["weapon_advancedrifle"] = {label = "ADVANCED RIFLE", price = 10000}, -- Item id and price
					["weapon_specialcarbine"] = {label = "SPECIAL CARBINE", price = 10000}, -- Item id and price
					["weapon_bullpuprifle"] = {label = "BULLPUP RIFLE", price = 10000}, -- Item id and price
					["weapon_compactrifle"] = {label = "COMPACT RIFLE", price = 10000}, -- Item id and price
				},

				["snipers"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_sniperrifle"] = {label = "SNIPER RIFLE", price = 10000}, -- Item id and price
					["weapon_heavysniper"] = {label = "HEAVY SNIPER", price = 10000}, -- Item id and price
					["weapon_marksmanrifle"] = {label = "MARKSMAN RIFLE", price = 10000}, -- Item id and price
				},

				["smgs"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_smg"] = {label = "SMG", price = 10000}, -- Item id and price
					["weapon_microsmg"] = {label = "MICRO SMG", price = 10000}, -- Item id and price
					["weapon_assaultsmg"] = {label = "ASSAULT SMG", price = 10000}, -- Item id and price
					["weapon_combatpdw"] = {label = "COMBAT PDW", price = 10000}, -- Item id and price
					["weapon_machinepistol"] = {label = "MACHINE PISTOL", price = 10000}, -- Item id and price
					["weapon_minismg"] = {label = "MINI SMG", price = 10000}, -- Item id and price
				},

				["lmgs"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_mg"] = {label = "MACHINE GUN", price = 10000}, -- Item id and price
					["weapon_combatmg"] = {label = "COMBAT MACHINE GUN", price = 10000}, -- Item id and price
					["weapon_gusenberg"] = {label = "GUSENBERG SWEEPER", price = 10000}, -- Item id and price
				},

				["shotguns"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_pumpshotgun"] = {label = "PUMP SHOTGUN", price = 10000}, -- Item id and price
					["weapon_sawnoffshotgun"] = {label = "SAWED-OFF SHOTGUN", price = 10000}, -- Item id and price
					["weapon_assaultshotgun"] = {label = "ASSAULT SHOTGUN", price = 10000}, -- Item id and price
					["weapon_bullpupshotgun"] = {label = "BULLPUP SHOTGUN", price = 10000}, -- Item id and price
					["weapon_heavyshotgun"] = {label = "HEAVY SHOTGUN", price = 10000}, -- Item id and price
					["weapon_dbshotgun"] = {label = "DOUBLE BARREL SHOTGUN", price = 10000}, -- Item id and price
					["weapon_autoshotgun"] = {label = "SWEEPER SHOTGUN", price = 10000}, -- Item id and price

				},

				["ammo"] = { -- each ammo category already gives ammo to all of the same category guns for example "AMMO_PISTOL" gives ammo to ALL pistols and "AMMO_SMG" gives ammo to ALL smgs. So you don't need to add a specific weapon. 
					["AMMO_PISTOL"] = {label = "PISTOL", amount = 12, price = 1000}, -- Item id and price
					["AMMO_SMG"] = {label = "SMG", amount = 30, price = 10000}, -- Item id and price
					["AMMO_RIFLE"] = {label = "RIFLE", amount = 30, price = 1000}, -- Item id and price
					["AMMO_SNIPER"] = {label = "SNIPER", amount = 10, price = 1000}, -- Item id and price
					["AMMO_SHOTGUN"] = {label = "SHOTGUN", amount = 8, price = 1000}, -- Item id and price
					["AMMO_MG"] = {label = "MG", amount = 100, price = 1000}, -- Item id and price

				},

				["explosives"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_grenade"] = {label = "GRENADE", price = 10000}, -- Item id and price
					["weapon_smokegrenade"] = {label = "SMOKE GRENADE", price = 10000}, -- Item id and price
					["weapon_stickybomb"] = {label = "STICKY BOMB", price = 10000}, -- Item id and price
					["weapon_molotov"] = {label = "MOLOTOV", price = 10000}, -- Item id and price
					["weapon_flare"] = {label = "FLARE", price = 10000}, -- Item id and price
					["weapon_proxmine"] = {label = "PROXIMITY MINE", price = 10000}, -- Item id and price
					["weapon_pipebomb"] = {label = "PIPE BOMB", price = 10000}, -- Item id and price

				},

				["armor"] = {
					["15"] = {label = "SUPER LIGHT", percentage = "15", price = 100}, -- Item id and price 
					["40"] = {label = "LIGHT", percentage = "40", price = 500}, -- Item id and price
					["60"] = {label = "STANDARD", percentage = "60", price = 600}, -- Item id and price
					["80"] = {label = "HEAVY", percentage = "80", price = 700}, -- Item id and price
					["100"] = {label = "SUPER HEAVY", percentage = "100", price = 800}, -- Item id and price
				},


				["attachments"] = { --https://wiki.rage.mp/index.php?title=Weapons_Components Attachments ID
					["flashlight"] =  {label = "FLASHLIGHT", price = 3000},
					["suppressor"] = {label = "SUPPRESSOR", price = 5000},
					["clip_default"] = {label = "DEFAULT-CLIP", price = 1000},		
					["clip_extended"] = {label = "EXTENDED-CLIP", price = 8000},
					["grip"] = {label = "GRIP", price = 10000},
					["scope"] = {label = "SCOPE", price = 7000},
					["scope_advanced"] = {label = "ADVANCED-SCOPE", price = 1000},																	
				},


				["melee"] = { --https://wiki.rage.mp/index.php?title=Weapons Weapons ID
					["weapon_knife"] = {label = "KNIFE", price = 100}, -- Item id and price
					["weapon_knuckle"] = {label = "BRASS KNUCKLES", price = 100}, -- Item id and price
					["weapon_bat"] = {label = "BAT", price = 100}, -- Item id and price
					["weapon_crowbar"] = {label = "CROWBAR", price = 100}, -- Item id and price
					["weapon_flashlight"] = {label = "FLASHLIGHT", price = 100}, -- Item id and price
					["weapon_machete"] = {label = "MACHETE", price = 100}, -- Item id and price
					["weapon_nightstick"] = {label = "NIGHT STICK", price = 100}, -- Item id and price
					["weapon_wrench"] = {label = "WRENCH", price = 100}, -- Item id and price
					["weapon_golfclub"] = {label = "GOLF CLUB", price = 100}, -- Item id and price


				},
		},

	},


	Text = {
		['hologram'] = '[~o~E~w~] Waffenladen',
		['blackmarkethologram'] = '[~o~E~w~] Black Market',

		['missingmoney'] = 'You do not have enough ~g~money~w~!',
		['successful'] = 'Your purchase was ~b~successful~w~!',

		['hasweapon'] = 'You already have this ~b~weapon~w~!',
		['nothasweapon'] = 'You do not have a ~b~weapon!',
		
		['maxammo'] = 'You already have maximum amount of ~b~ammo!',
		['maxexplosive'] = 'You already have maximum amount of ~b~explosive!',

		['notsupport'] = 'This ~b~weapon~w~ does not support this ~b~attachment~w~!',
		['hasattach'] = 'You already have this ~b~attachment~w~ equipped!',
		
		['fullarmor'] = 'You already have ~b~100~w~%',
		['15'] = '~b~15~w~% armor have been applied!',
		['40'] = '~b~40~w~% armor have been applied!',
		['60'] = '~b~60~w~% armor have been applied!',
		['80'] = '~b~80~w~% armor have been applied!',
		['100'] = '~b~100~w~% armor have been applied!',


		['alreadyhave'] = 'You already have this ~b~license~w~!'
	},



}

	-- Only change if you know what are you doing!
function SendTextMessage(msg)

	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)

	--EXAMPLE USED IN VIDEO
	--exports['mythic_notify']:DoHudText('error', msg)

end

