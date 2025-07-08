fx_version "cerulean"

game "gta5"

description "Skyline Juwelen"

version "2.0.0"

client_scripts {
	"config.lua",
	"client/cl.lua"
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
	"config.lua",
	"server/sv.lua"
}