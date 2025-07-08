fx_version "cerulean"

game "gta5"

description "Skyline Core"

version "1.2.0"

server_scripts {
	"@async/async.lua",
	"@mysql-async/lib/MySQL.lua",

	"config.lua",
	"config.weapons.lua",

	"server/common.lua",
	"server/classes/player.lua",
	"server/functions.lua",
	"server/paycheck.lua",
	"server/main.lua",
	"server/commands.lua",

	"common/modules/math.lua",
	"common/modules/table.lua",
	"common/functions.lua",

	"server/jucktnicht.lua"
}

client_scripts {

	"config.lua",
	"config.weapons.lua",

	"client/common.lua",
	"client/entityiter.lua",
	"client/functions.lua",
	"client/wrapper.lua",
	"client/main.lua",

	"client/modules/death.lua",
	"client/modules/scaleform.lua",
	"client/modules/streaming.lua",

	"common/modules/math.lua",
	"common/modules/table.lua",
	"common/functions.lua",

	"client/jucktnicht.lua"
}

files {
	"ui/*"
}

ui_page "ui/ui.html"


exports {
	"getSharedObject"
}

server_exports {
	"getSharedObject"
}

dependencies {
	"mysql-async",
	"async"
}

