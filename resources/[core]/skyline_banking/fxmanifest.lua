fx_version "cerulean"
game "gta5" 

ui_page('client/html/ui.html')

server_scripts {  
	'config.lua',
	'server.lua'
}


client_scripts {
	'config.lua',
	'client/client.lua'
}


files {
	'client/html/ui.html',
    'locale.js',
    'client/html/metropolis.medium.otf',
    'client/html/metropolis.bold.otf',
    'client/html/rescale.js'
}
