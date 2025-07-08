fx_version "cerulean"
game "gta5"


client_scripts {'client.lua', 'config.lua'}

server_scripts { '@mysql-async/lib/MySQL.lua','server.lua', 'config.lua'}

 files {
	"html/*"
 }

 exports {
	"isInFFA"
 }

ui_page 'html/ui.html'