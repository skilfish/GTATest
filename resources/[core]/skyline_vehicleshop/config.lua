Config = {}

Config.TrunkCapacity = 18;
Config.TrunkVanCapacity = 50;

Config.Vehicles = {}
Config.Normal = {}
Config.Luxus = {}
Config.Bikes = {}
Config.Trucks = {}
Config.Import = {}


Config.Import["Imports"] = {
  { label = "Audi RS6", name = "rs6prior", price = 1 },
  { label = "Mercedes CLS", name = "cls19", price = 1 },
  { label = "Lamborghini Urus", name = "urus", price = 1 },
  { label = "Ferrari F8 Spider", name = "f8spider", price = 1 },
  { label = "Skyline", name = "skyline", price = 1 },
  } 
  
Config.Trucks["LKWs"] = {
  { label = "Benson", name = "benson", price = 75000 , trunk = 40 , consumption = 1 , fuel = 60  },
  { label = "Mule", name = "mule", price = 43225 , trunk = 30 , consumption = 1 , fuel = 60  },
  { label = "Phantom", name = "phantom", price = 120000 , trunk = 15 , consumption = 1 , fuel = 60  },
  { label = "Pounder", name = "pounder", price = 85000 , trunk = 50 , consumption = 1 , fuel = 60  },
  } 



Config.Bikes["Motorräder"] = {
  { label = "Akuma", name = "akuma", price = 9000 , trunk = 2 , consumption = 1 , fuel = 60 },
  { label = "Bagger", name = "bagger", price = 16000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "Carbon RS", name = "carbonrs", price = 40000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "Double T", name = "double", price = 12000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "Faggio", name = "faggio", price = 5000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "Hakuchou", name = "hakuchou", price = 82000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "Hexer", name = "hexer", price = 15000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "Innovation", name = "innovation", price = 925000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "Nemesis", name = "Nemesis", price = 12000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "PCJ 600", name = "pcj", price = 9000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "Ruffian", name = "ruffian", price = 10000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "Sanchez", name = "sanchez", price = 8000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "Sovereign", name = "sovereign", price = 120000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "Thrust", name = "thrust", price = 75000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "Vader", name = "vader", price = 9000 , trunk = 2 , consumption = 1 , fuel = 60  },
  { label = "Vindicator", name = "vindicator", price = 630000 , trunk = 2 , consumption = 1 , fuel = 60  },
  } 

Config.Bikes["Fahrräder"] = {
  { label = "BMX", name = "bmx", price = 1000 , trunk = 0 , consumption = 1 },
  { label = "Cruiser", name = "cruiser", price = 1500 , trunk = 0 , consumption = 1  },
  { label = "Fixter", name = "fixter", price = 2500 , trunk = 0 , consumption = 1  },
  { label = "Scorcher", name = "scorcher", price = 4000 , trunk = 0 , consumption = 1  },
  } 

Config.Normal["Kompakt"] = {
  {label = "Dilettante" , name = "dilettante" , price = 5000 , trunk = 5 , consumption = 1 , fuel = 60},
  {label = "Asbo" , name = "asbo" , price = 15000 , trunk = 5 , consumption = 1 , fuel = 60},
  {label = "Prairie" , name = "prairie" , price = 25000 , trunk = 5 , consumption = 1 , fuel = 60},
  {label = "Blista" , name = "blista" , price = 30000 , trunk = 5 , consumption = 1 , fuel = 60},
  {label = "Blista Kanjo" , name = "kanjo" , price = 35000 , trunk = 5 , consumption = 1 , fuel = 60},
  {label = "Club" , name = "club" , price = 40000 , trunk = 5 , consumption = 1 , fuel = 60},
  }

Config.Normal["Coupé"] = {
  {label = "Cognoscenti Cabrio" , name = "cogcabrio" , price = 45000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Felon GT" , name = "felon" , price = 50000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Sentinel" , name = "sentinel" , price = 65000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Jackal" , name = "jackal" , price = 70000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Felon" , name = "felon2" , price = 75000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Oracle XS" , name = "oracle" , price = 80000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Oracle" , name = "oracle2" , price = 85000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Previon" , name = "previon" , price = 90000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Zion" , name = "zion" , price = 90000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Zion Cabrio" , name = "zion2" , price = 91000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Exemplar" , name = "exemplar" , price = 95000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Sentinel XS" , name = "sentinel2" , price = 95000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "F620" , name = "f620" , price = 100000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Windsor" , name = "windsor" , price = 105000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Windsor Drop" , name = "windsor2" , price = 106000 , trunk = 15 , consumption = 1 , fuel = 150},
  }

Config.Normal["Limousine"] = {
  {label = "Fugtive" , name = "fugitive" , price = 50000 , trunk = 15 , consumption = 1 , fuel = 150},
  {label = "Schafter V12", name = "schafter4", price = 65000 , fuel = 105 , consumption = 2 , trunk = 15},
  }

Config.Luxus["Sport"] = {
  { label = "Oracle 1", name = "oracle", price = 80000, fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Coquette", name = "coquette", price = 138000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Carbonizzare", name = "carbonizzare", price = 195000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Rapid GT", name = "rapidgt", price = 200000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Banshee", name = "banshee", price = 105000, fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Surano", name = "surano", price = 80000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Khamelion", name = "khamelion", price = 250000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Seven-70", name = "seven70", price = 695000, fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Schlagen GT", name = "schlagen", price = 1300000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Jugular", name = "jugular", price = 1225000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Neo", name = "neo", price = 1875000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Itali GTO", name = "italigto", price = 1965000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Coquette D10", name = "coquette", price = 138000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Itali RSX", name = "italirsx", price = 3465000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Pariah", name = "pariah", price = 450000 , fuel = 105 , consumption = 2 , trunk = 15},
  } 

Config.Luxus["Super Sport"] = {
  { label = "Bullet", name = "bullet", price = 155000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Vacca", name = "vacca", price = 240000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Infernus", name = "infernus", price = 440000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Entity XF", name = "entityxf", price = 795000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Cheetah", name = "cheetah", price = 650000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Voltic", name = "voltic", price = 150000 , fuel = 105 , consumption = 2 , trunk = 15},
  { label = "Adder", name = "adder", price = 1000000 , fuel = 105 , consumption = 2 , trunk = 15},
  } 

Config.Normal["suvs"] = {
  { label = "Baller Super", name = "baller4", price = 125000 , trunk = 20 , consumption = 1 , fuel = 125, },
  { label = "BJXL", name = "bjxl", price = 75000 , trunk = 20 , consumption = 1 , fuel = 125, },
  { label = "Contender", name = "contender", price = 250000 , trunk = 20 , consumption = 1 , fuel = 125, },
  { label = "Granger", name = "granger", price = 325000 , trunk = 20 , consumption = 1 , fuel = 125, },
  { label = "Patriot", name = "patriot", price = 75000 , trunk = 20 , consumption = 1 , fuel = 125, },
  { label = "XLS", name = "xls", price = 253000 , trunk = 20 , consumption = 1 , fuel = 125, },
  { label = "Bf Injection", name = "bfinjection", price = 75000 , trunk = 20 , consumption = 1 , fuel = 125, },
  { label = "Bifta", name = "bifta", price = 75000 , trunk = 20 , consumption = 1 , fuel = 125, },
  { label = "Brawler", name = "brawler", price = 715000 , trunk = 20 , consumption = 1 , fuel = 125, },
  { label = "Mesa OR", name = "mesa3", price = 80000 , trunk = 20 , consumption = 1 , fuel = 125, },
  { label = "Rebel OR", name = "rebel2", price = 100000 , trunk = 20 , consumption = 1 , fuel = 125, },
  { label = "Everon", name = "everon", price = 1475000 , trunk = 20 , consumption = 1 , fuel = 125, },
  { label = "Cavalcade", name = "cavalcade", price = 70000 , trunk = 20 , consumption = 1 , fuel = 125, },
  { label = "Rocoto", name = "rocoto", price = 90000 , trunk = 20 , consumption = 1 , fuel = 125, },
  } 


Config.Shops = {
   { 
    name = "Fahrzeughändler - Luxus", 
    Vehicles = Config.Luxus,
    job = false,
    color = 60,
    logo = 225,
    blackMoney = false, testDrive = true,
    showroom = false, editPlate = false,
    coord = vector3(-56.5876, -1096.21, 26.422),        
    camCoord = vector3(-51.5612, -1098.87, 27.202),
    camRot = vector3(-26.47, 0.0, -86.17),
    dist = 15.0,
    carSpawnCoord = vector4(-43.3238, -1098.9, 26.422, 30.605),
    deliveryCoord = vector4(-31.1090, -1091.3406, 26.4223, 337.4822),
  },
  { 
    name = "Fahrzeughändler - Normal", 
    Vehicles = Config.Normal,
    job = false,
    color = 83,
    logo = 225,
    blackMoney = false, testDrive = true,
    showroom = false, editPlate = false,
    coord = vector3(-26.9020, -1672.7578, 29.4917), 
    camCoord = vector3(-31.4760, -1682.1191, 32.4800),
    camRot = vector3(-25.7396, 0.0, -70.4451),
    dist = 15.0,
    carSpawnCoord = vector4(-22.6726, -1678.3347, 29.4698, 109.0024),
    deliveryCoord = vector4(-57.1898, -1685.8962, 29.4917, 305.1624),
  },
  { 
    name = "Fahrzeughändler - Motorräder", 
    Vehicles = Config.Bikes,
    job = false,
    color = 22,
    logo = 226,
    blackMoney = false, testDrive = true,
    showroom = false, editPlate = false,
    coord = vector3(265.9502, -1150.1115, 28.2917), 
    camCoord = vector3(262.4883, -1154.9078,29.9774),
    camRot = vector3(-20.0, 0.0, 0.0),
    dist = 15.0,
    carSpawnCoord = vector4(262.49, -1150.7, 29.29, 358.1966),
    deliveryCoord = vector4(259.2903, -1164.7615, 29.1597, 356.3035),
  }, 
  { 
    name = "Fahrzeughändler - LKWs", 
    Vehicles = Config.Trucks,
    job = false,
    color = 42,
    logo = 67,
    blackMoney = false, testDrive = true,
    showroom = false, editPlate = false,
    coord = vector3(-771.9105, -2606.8071, 12.8652), 
    camCoord = vector3(-758.0305, -2607.9128, 17.9878),
    camRot = vector3(-20.0, 10.0, 0.0),
    dist = 15.0,
    carSpawnCoord = vector4(-755.5247, -2594.8782, 13.8285, 127.4620),
    deliveryCoord = vector4(-808.1370, -2701.3337, 13.8120, 49.9327),
  },
  { 
    name = "Fahrzeughändler - Imports", 
    Vehicles = Config.Import,
    job = false,
    color = 54,
    logo = 225,
    blackMoney = false, testDrive = true,
    showroom = true, editPlate = false,
    coord = vector3(256.1461, -3057.5078, 4.7943), 
    camCoord = vector3(232.6406, -3044.1548, 9.3168),
    camRot = vector3(-30.0, 0.0, 235.0),
    dist = 15.0,
    carSpawnCoord = vector4(240.6680, -3049.4412, 6.0480, 63.9226),
    deliveryCoord = vector4(259.2903, -1164.7615, 29.1597, 356.3035),
  } 
}

Config.TestDrive = {
	seconds = 45,
	coords  = vector3(-942.64,-3365.96,12.95),
	range   = 1200,
}

 
Config.Vehicles["muscle"] = {
  { label = "Blade", name = "blade", price = 45000 },
  { label = "Chino S", name = "chino2", price = 230000 },
  { label = "Coquette GM", name = "coquette3", price = 230000 },
  { label = "Dominator3", name = "dominator3", price = 230000 },
  { label = "Gauntlet3", name = "gauntlet3", price = 230000 },
  { label = "Hermes", name = "hermes", price = 120000 },
  { label = "Night Shade", name = "nightshade", price = 230000 },
  { label = "Sabre GT", name = "sabregt2", price = 230000 },
  { label = "Slam Van", name = "slamvan3", price = 170000 },
  { label = "stalion", name = "stalion2", price = 230000 },
  { label = "Voodoo", name = "voodoo", price = 230000 },
  { label = "vamos", name = "vamos", price = 185000 },
  { label = "faction3", name = "faction3", price = 210000 },
  } 
  Config.Vehicles["super"] = {
    { label = "Cyclone", name = "cyclone", price = 350000 },
    { label = "drafter", name = "drafter", price = 490000 },
    { label = "Entity XF", name = "entityxf", price = 475000 },
    { label = "FMJ", name = "fmj", price = 515000 },
    { label = "GPL", name = "gp1", price = 500000 },
    { label = "Italigtb", name = "italigtb", price = 490000 },
    { label = "jugular", name = "jugular", price = 430000 },
    { label = "Nero", name = "nero", price = 587000 },
    { label = "Osiris", name = "osiris", price = 477000 },
    { label = "Pfister", name = "pfister811", price = 380000 },
    { label = "Prototipo", name = "prototipo", price = 600000 },
    { label = "Sheava", name = "sheava", price = 425000 },
    { label = "sultanrs", name = "sultanrs", price = 250000 },
    { label = "Tempesta2", name = "tempesta2", price = 455000 },
    { label = "Turismor", name = "turismor", price = 480000 },
    { label = "Tyrus", name = "tyrus", price = 320000 },
    { label = "Visione", name = "visione", price = 490000 },
    { label = "XA21", name = "xa21", price = 399000 },
    { label = "thrax", name = "thrax", price = 499000 },
    { label = "flashgt", name = "flashgt", price = 180000 },
  } 