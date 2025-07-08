fx_version "cerulean"
game "gta5"

client_script {
    'client/client.lua',
    'config.lua'
}

server_script {
    'server/server.lua',
    'config.lua'
}

ui_page "client/html/index.html"

files {
    'client/html/index.html',
    'client/html/*.js',
    'client/html/bootstrap.min.css'
}


