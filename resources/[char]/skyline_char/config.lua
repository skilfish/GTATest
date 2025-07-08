-- Friseur
ConfigBS = {}

ConfigBS.Price = 50

ConfigBS.DrawDistance = 100.0
ConfigBS.MarkerSize   = {x = 1.5, y = 1.5, z = 1.0}
ConfigBS.MarkerColor  = {r = 0, g = 0, b = 255}
ConfigBS.MarkerType   = 1

ConfigBS.Zones = {}

ConfigBS.Shops = {
  {x = -814.308,  y = -183.823,  z = 36.568},
  {x = 136.826,   y = -1708.373, z = 28.291},
  {x = -1282.604, y = -1116.757, z = 5.990},
  {x = 1931.513,  y = 3729.671,  z = 31.844},
  {x = 1212.840,  y = -472.921,  z = 62.208},
  {x = -32.885,   y = -152.319,  z = 56.076},
  {x = -278.077,  y = 6228.463,  z = 30.695},
}

for i=1, #ConfigBS.Shops, 1 do

	ConfigBS.Zones['Shop_' .. i] = {
	 	Pos   = ConfigBS.Shops[i],
	 	Size  = ConfigBS.MarkerSize,
	 	Color = ConfigBS.MarkerColor,
	 	Type  = ConfigBS.MarkerType
  }

end
-- Friseur

-- Kleidungsladen
Config = {}


Config.Price = 85

Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 1.5, y = 1.5, z = 1.0}
Config.MarkerColor  = {r = 0, g = 0, b = 255}
Config.MarkerType   = 1

Config.Zones = {}

Config.Shops = {
  {x=72.254,    y=-1399.102, z=28.376},
  {x=-703.776,  y=-152.258,  z=36.415},
  {x=-167.863,  y=-298.969,  z=38.733},
  {x=428.694,   y=-800.106,  z=28.491},
  {x=-829.413,  y=-1073.710, z=10.328},
  {x=-1447.797, y=-242.461,  z=48.820},
  {x=11.632,    y=6514.224,  z=30.877},
  {x=123.646,   y=-219.440,  z=53.557},
  {x=1696.291,  y=4829.312,  z=41.063},
  {x=618.093,   y=2759.629,  z=41.088},
  {x=1190.550,  y=2713.441,  z=37.222},
  {x=-1193.429, y=-772.262,  z=16.324},
  {x=-3172.496, y=1048.133,  z=19.863},
  {x=-1108.441, y=2708.923,  z=18.107},
  {x = -1045.41 , y = -2826.83 , z = 27.29}

}

for i=1, #Config.Shops, 1 do

	Config.Zones['Shop_' .. i] = {
	 	Pos   = Config.Shops[i],
	 	Size  = Config.MarkerSize,
	 	Color = Config.MarkerColor,
	 	Type  = Config.MarkerType
  }

end
-- Kleidungsladen
