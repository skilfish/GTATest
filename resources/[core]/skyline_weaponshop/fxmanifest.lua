
fx_version 'adamant'

game 'gta5'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/index.css',
	'html/index.js',
	'html/jquery-3.4.1.min.js',
	'html/src/*.jpg',
    'html/src/*.png',
    'html/src/attachments/*.png',
    'html/src/loadout/*.png',
    'html/src/pistols/*.png',
    'html/src/rifles/*.png',
    'html/src/snipers/*.png',
    'html/src/smgs/*.png',
    'html/src/lmgs/*.png',
    'html/src/shotguns/*.png',
    'html/src/Explosives/*.png',
    'html/src/Melee/*.png',
    'html/src/Armor/*.png',
    'html/src/Ammo/*.png',
    'html/fonts/@.ttf'
}

client_scripts{
    'config.lua',
    'client/main.lua',
}

server_scripts{
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/main.lua',
}

