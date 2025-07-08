fx_version "cerulean"
game "gta5"

shared_script "config.lua"
server_script 'server/main.lua'

client_script 'client/main.lua'

ui_page 'html/scoreboard.html'

files {
	'html/scoreboard.html',
	'html/listener.js',
	'html/rescale.js'
}