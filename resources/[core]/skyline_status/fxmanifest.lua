fx_version "cerulean"
game "gta5"

description 'Skyline Status'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua',
	'server/items.lua'
}

client_scripts {
	'config.lua',
	'client/classes/status.lua',
	'client/main.lua',
	'client/items.lua'
}

