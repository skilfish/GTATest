Config = {}

Config.AllLogs = true											-- Enable/Disable All Logs Channel
Config.postal = true  											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.username = "SKYLINE | Logs" 							-- Bot Username
Config.avatar = "https://cdn.discordapp.com/attachments/932234080681066528/989080476511768636/SRP_final.png"				-- Bot Avatar
Config.communtiyName = "Skyline"					-- Icon top of the Embed
Config.communtiyLogo = "https://cdn.discordapp.com/attachments/932234080681066528/989080476511768636/SRP_final.png"		-- Icon top of the Embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs
Config.weaponLogDelay = 1000		-- delay to wait after someone fired a weapon to check again in ms (put to 0 to disable) Best to keep this at atleast 1000

Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam ID in the logs
Config.steamURL = true				-- set to false to disable Steam URL in the logs
Config.discordID = true				-- set to false to disable Discord ID in the logs


-- Change color of the default embeds here
-- It used Decimal color codes witch you can get and convert here: https://jokedevil.com/colorPicker
Config.joinColor = "3863105" 		-- Player Connecting
Config.leaveColor = "15874618"		-- Player Disconnected
Config.chatColor = "10592673"		-- Chat Message
Config.shootingColor = "10373"		-- Shooting a weapon
Config.deathColor = "000000"		-- Player Died
Config.resourceColor = "15461951"	-- Resource Stopped/Started



Config.webhooks = {
	all = "",
	chat = "",
	joins = "https://discord.com/api/webhooks/989080865730621470/TTuJyRJtkF1TxnNthY9gBnFgcnP3zCx_uG5OjdOOwqNF7p3-IQoTwJ-8VmNuy7i_Yfbf",
	leaving = "https://discord.com/api/webhooks/989080980839084084/XmEevhvVZMdyWORBO6_WvJr1936EUgFs3q8P-4LeROFNmtepsZDFCXufGU1Y9STRoWiv",
	deaths = "https://discord.com/api/webhooks/989081163475861525/xZ_ggNjSn4nAaqUgNT1I2JV9RrHNU2LVZfyTmLQTWn5wv7JKzRQ4hrFUQtTed8gSZc1h",
	shooting = "https://discord.com/api/webhooks/989081232618954752/kDm8PsZSVYT1--ufnVB6g3c-tgyRrTgU-qGqGE4j8dCldmtb9wJvsmsISBFfdnCr1L59",
	resources = "",

  -- How you add more logs is explained on https://docs.jokedevil.com/JD_logs
  }


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "1.1.0"
