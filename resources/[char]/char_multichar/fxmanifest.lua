fx_version 'cerulean'
game 'gta5'

description 'Multicharakter mit modernem UI & Whitelist'
author 'ChatGPT'

shared_script 'config.lua'
client_script 'client.lua'
server_script 'server.lua'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

ui_page 'html/index.html'

dependency 'oxmysql'
