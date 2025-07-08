fx_version "cerulean"
game "gta5"

description 'Skyline Utils'

version '1.0.0'

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"server/server.lua"
}

client_scripts {
	"client/client.lua",
	"client/maskequip.lua"
}

