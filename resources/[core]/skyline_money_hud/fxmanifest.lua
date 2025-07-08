fx_version 'cerulean'
game 'gta5'

description 'Skyline Money Hud'

version '1.0.0'

ui_page "html/html.html"
files {
	"html/html.html",
	"html/*.js",
	"html/*.svg",
	"html/*.ttf",
	"html/*.png",
	"html/*.css"
}

server_scripts {
	'server/main.lua'
}

client_scripts {
	'client/main.lua'
}

