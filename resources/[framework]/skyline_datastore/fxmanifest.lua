fx_version "cerulean"
game "gta5"

description 'Skyline Data Store'

version '1.0.2'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
	'server/classes/datastore.lua',
}
