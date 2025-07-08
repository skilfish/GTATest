Config = {}

Config.Accounts = {
	bank = "Bank",
	black_money = "Schwarzgeld",
	money = "Bargeld"
}

Config.StartingAccountMoney = {bank = 50000 , money = 1000}

Config.EnableSocietyPayouts = false -- pay from the society account that the player is employed at? Requirement: esx_society
Config.EnableHud            = false -- enable the default hud? Display current job and accounts (black, bank & cash)
Config.MaxWeight            = 25000   -- the max inventory weight without backpack
Config.PaycheckInterval     = 25 * 60000 -- how often to recieve pay checks in milliseconds
Config.EnableDebug          = false
