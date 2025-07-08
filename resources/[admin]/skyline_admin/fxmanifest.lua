version '1.0.0'
author 'Juckthaltnicht'
description 'Admin Script'

fx_version 'adamant'
game 'gta5'



server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server/main.lua'
}
client_scripts {
    'config.lua',
    'client/aduty.lua',
    'client/nametags.lua',
    'client/noclip.lua',
    'client/commands.lua',
    "client/ui.lua"
}

ui_page "html/ui.html"

files {
    "html/*"
}

