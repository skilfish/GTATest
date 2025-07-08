fx_version 'adamant'
game 'gta5'

client_scripts {  'config.lua', 'client.lua', 'utils.lua'}


server_scripts { '@mysql-async/lib/MySQL.lua','server.lua'}
 

ui_page 'ui/ui.html'
files {
	'ui/ui.html',
	'ui/js/*.js',
	'ui/css/*.css',
	'ui/images/*.png',
	'ui/css/fonts/*.ttf',

}

exports {
	'GeneratePlate'
}