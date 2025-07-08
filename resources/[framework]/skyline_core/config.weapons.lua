Config.DefaultWeaponTints = {
	[0] = "Normale-Farbe",
	[1] = "Grün",
	[2] = "Gold",
	[3] = "Pink",
	[4] = "Armee",
	[5] = "L.S.P.D",
	[6] = "Orange",
	[7] = "Platin"
}

Config.Weapons = {
	{
		name = 'WEAPON_PISTOL',
		label = "FN-502",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_PISTOL_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_PISTOL_CLIP_02')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_PI_SUPP_02')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_COMBATPISTOL',
		label = "Glock17",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_APPISTOL',
		label = "AP-Pistole",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_APPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_APPISTOL_CLIP_02')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_PISTOL50',
		label = "Desert Eagle",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_PISTOL50_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_PISTOL50_CLIP_02')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_SNSPISTOL',
		label = "Billig-Knarre",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_02')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_HEAVYPISTOL',
		label = "Schwere-Pistole",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_VINTAGEPISTOL',
		label = "Vintage-Pistole",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_02')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_PI_SUPP')}
		}
	},

	{
		name = 'WEAPON_MACHINEPISTOL',
		label = "Maschinen-Pistole",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_02')},
			{name = 'clip_drum', label ="Trommel-Magazin", hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_03')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_PI_SUPP')}
		}
	},

	{name = 'WEAPON_REVOLVER', label = "Revolver", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "Muntion", hash = GetHashKey('AMMO_PISTOL')}},
	{name = 'WEAPON_MARKSMANPISTOL', label = "Marksman-Pistole", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "Muntion", hash = GetHashKey('AMMO_PISTOL')}},
	{name = 'WEAPON_DOUBLEACTION', label = "Double-Action-Revolver", components = {}, ammo = {label = "Muntion", hash = GetHashKey('AMMO_PISTOL')}},

	{
		name = 'WEAPON_SMG',
		label = "MP5",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_SMG_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_SMG_CLIP_02')},
			{name = 'clip_drum', label ="Trommel-Magazin", hash = GetHashKey('COMPONENT_SMG_CLIP_03')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO_02')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_SMG_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ASSAULTSMG',
		label = "AK-47",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_MICROSMG',
		label = "MP7",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_MICROSMG_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_MICROSMG_CLIP_02')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_MINISMG',
		label = "Mini-SMG",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_MINISMG_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_MINISMG_CLIP_02')}
		}
	},

	{
		name = 'WEAPON_COMBATPDW',
		label = "Kampf-PDW",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_02')},
			{name = 'clip_drum', label ="Trommel-Magazin", hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_03')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'grip', label = "Griff", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')}
		}
	},

	{
		name = 'WEAPON_PUMPSHOTGUN',
		label = "Pump-Shot-Gun",
		ammo = {label = "Schrot-Munition", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_SR_SUPP')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_SAWNOFFSHOTGUN',
		label = "Abgesägte-Schrotflinte",
		ammo = {label = "Schrot-Munition", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ASSAULTSHOTGUN',
		label = "Assault-Shotgun",
		ammo = {label = "Schrot-Munition", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_02')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = "Griff", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{
		name = 'WEAPON_BULLPUPSHOTGUN',
		label = "Bull-Up-Shotgun",
		ammo = {label = "Schrot-Munition", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = "Griff", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{
		name = 'WEAPON_HEAVYSHOTGUN',
		label = "Schwere-Schrotflinte",
		ammo = {label = "Schrot-Munition", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_02')},
			{name = 'clip_drum', label ="Trommel-Magazin", hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_03')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = "Griff", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{name = 'WEAPON_DBSHOTGUN', label = "", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "Schrot-Munition", hash = GetHashKey('AMMO_SHOTGUN')}},
	{name = 'WEAPON_AUTOSHOTGUN', label = "Auto-ShotGun", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "Schrot-Munition", hash = GetHashKey('AMMO_SHOTGUN')}},
	{name = 'WEAPON_MUSKET', label = "Muskete", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "Muntion", hash = GetHashKey('AMMO_SHOTGUN')}},

	{
		name = 'WEAPON_ASSAULTRIFLE',
		label = "AK-47",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02')},
			{name = 'clip_drum', label ="Trommel-Magazin", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = "Griff", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_CARBINERIFLE',
		label = "M4A1",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02')},
			{name = 'clip_box', label = "Box-Magazin", hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_03')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = "Griff", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ADVANCEDRIFLE',
		label = "AR-15",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_SPECIALCARBINE',
		label = "Spezi",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02')},
			{name = 'clip_drum', label ="Trommel-Magazin", hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_03')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = "Griff", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_BULLPUPRIFLE',
		label = "Bull-Up-Rifle",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = "Griff", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_BULLPUPRIFLE_VARMOD_LOW')}
		}
	},

	{
		name = 'WEAPON_COMPACTRIFLE',
		label = "Kompakt-AK",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_02')},
			{name = 'clip_drum', label ="Trommel-Magazin", hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_03')}
		}
	},

	{
		name = 'WEAPON_MG',
		label = "MG",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_MG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_MG_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_MG_CLIP_02')},
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL_02')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_MG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_COMBATMG',
		label = "Kampf-MG",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_MG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_COMBATMG_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_COMBATMG_CLIP_02')},
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'grip', label = "Griff", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_COMBATMG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_GUSENBERG',
		label = "Gusenberg",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_MG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_02')},
		}
	},

	{
		name = 'WEAPON_SNIPERRIFLE',
		label = "Scharfschützen-Gewehr",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_SNIPER')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE')},
			{name = 'scope_advanced', label ="Erweitertes-Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_MAX')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_SNIPERRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_HEAVYSNIPER',
		label = "Schwere-Sniper",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_SNIPER')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE')},
			{name = 'scope_advanced', label ="Erweitertes-Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_MAX')}
		}
	},

	{
		name = 'WEAPON_MARKSMANRIFLE',
		label = "Marksman-Gewehr",
		ammo = {label = "Muntion", hash = GetHashKey('AMMO_SNIPER')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label ="Normales-Magazin", hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "Erweitertes-Magazin", hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_02')},
			{name = 'flashlight', label = "Taschenlampen-Aufsatz", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "Visir", hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM')},
			{name = 'suppressor', label = "Schalldämpfer", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = "Griff", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "Luxus-Designe", hash = GetHashKey('COMPONENT_MARKSMANRIFLE_VARMOD_LUXE')}
		}
	},

	{name = 'WEAPON_MINIGUN', label = "Minigun", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "Muntion", hash = GetHashKey('AMMO_MINIGUN')}},
	{name = 'WEAPON_RAILGUN', label = "Railgun", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "Muntion", hash = GetHashKey('AMMO_RAILGUN')}},
	{name = 'WEAPON_STUNGUN', label = "Tazer", tints = Config.DefaultWeaponTints, components = {}},
	{name = 'WEAPON_RPG', label = "RPG", tints = Config.DefaultWeaponTints, components = {}, ammo = {label ="Raketen", hash = GetHashKey('AMMO_RPG')}},
	{name = 'WEAPON_HOMINGLAUNCHER', label = "???", tints = Config.DefaultWeaponTints, components = {}, ammo = {label ="Raketen", hash = GetHashKey('AMMO_HOMINGLAUNCHER')}},
	{name = 'WEAPON_GRENADELAUNCHER', label = "Granat-Werfer", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "Granaten", hash = GetHashKey('AMMO_GRENADELAUNCHER')}},
	{name = 'WEAPON_COMPACTLAUNCHER', label = "???", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "Granaten", hash = GetHashKey('AMMO_GRENADELAUNCHER')}},
	{name = 'WEAPON_FLAREGUN', label = "Leuchtpistole", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "Leuchtfackeln", hash = GetHashKey('AMMO_FLAREGUN')}},
	{name = 'WEAPON_FIREEXTINGUISHER', label ="Feuerlöscher", components = {}, ammo = {label ="Strom", hash = GetHashKey('AMMO_FIREEXTINGUISHER')}},
	{name = 'WEAPON_PETROLCAN', label = "Benzin-Kanister", components = {}, ammo = {label = "Benzin", hash = GetHashKey('AMMO_PETROLCAN')}},
	{name = 'WEAPON_FIREWORK', label = "Feuerwerk", components = {}, ammo = {label = "Raketen", hash = GetHashKey('AMMO_FIREWORK')}},
	{name = 'WEAPON_FLASHLIGHT', label = "Taschenlampe", components = {}},
	{name = 'GADGET_PARACHUTE', label = "Fallschrim", components = {}},
	{name = 'WEAPON_KNUCKLE', label = "Schlagring", components = {}},
	{name = 'WEAPON_HATCHET', label = "Axt", components = {}},
	{name = 'WEAPON_MACHETE', label = "Machhete", components = {}},
	{name = 'WEAPON_SWITCHBLADE', label = "Springmesser", components = {}},
	{name = 'WEAPON_BOTTLE', label ="Flasche", components = {}},
	{name = 'WEAPON_DAGGER', label = "Dolch", components = {}},
	{name = 'WEAPON_POOLCUE', label = "Stock", components = {}},
	{name = 'WEAPON_WRENCH', label = "Schraubenschlüssel", components = {}},
	{name = 'WEAPON_BATTLEAXE', label = "Kampf-Axt", components = {}},
	{name = 'WEAPON_KNIFE', label = "Messer", components = {}},
	{name = 'WEAPON_NIGHTSTICK', label = "Schlagstock", components = {}},
	{name = 'WEAPON_HAMMER', label = "Hammer", components = {}},
	{name = 'WEAPON_BAT', label = "Schläger", components = {}},
	{name = 'WEAPON_GOLFCLUB', label = "Golfschläger", components = {}},
	{name = 'WEAPON_CROWBAR', label = "Brecheisen", components = {}},

	{name = 'WEAPON_GRENADE', label = "Granata", components = {}, ammo = {label = "Granaten", hash = GetHashKey('AMMO_GRENADE')}},
	{name = 'WEAPON_SMOKEGRENADE', label = "Rauch-Granate", components = {}, ammo = {label ="Rauchbomben", hash = GetHashKey('AMMO_SMOKEGRENADE')}},
	{name = 'WEAPON_STICKYBOMB', label = "C4", components = {}, ammo = {label = "C4", hash = GetHashKey('AMMO_STICKYBOMB')}},
	{name = 'WEAPON_PIPEBOMB', label = "Polnischer-Böller", components = {}, ammo = {label = "???", hash = GetHashKey('AMMO_PIPEBOMB')}},
	{name = 'WEAPON_BZGAS', label = "BZ-Gas", components = {}, ammo = {label ="BzGas", hash = GetHashKey('AMMO_BZGAS')}},
	{name = 'WEAPON_MOLOTOV', label = "Moletov", components = {}, ammo = {label = "???", hash = GetHashKey('AMMO_MOLOTOV')}},
	{name = 'WEAPON_PROXMINE', label = "???", components = {}, ammo = {label = "???", hash = GetHashKey('AMMO_PROXMINE')}},
	{name = 'WEAPON_SNOWBALL', label = "Schneeball", components = {}, ammo = {label = "???", hash = GetHashKey('AMMO_SNOWBALL')}},
	{name = 'WEAPON_BALL', label = "Ball", components = {}, ammo = {label = "???", hash = GetHashKey('AMMO_BALL')}},
	{name = 'WEAPON_FLARE', label = "Leuchtfackel", components = {}, ammo = {label = "???", hash = GetHashKey('AMMO_FLARE')}}
}
