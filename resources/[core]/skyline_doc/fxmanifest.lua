fx_version "cerulean"
game "gta5"



client_scripts {
    'client.lua',
}



server_scripts {
    '@mysql-async/lib/MySQL.lua',
}

ui_page "html/index.html"
files {
    'html/index.html',
    'html/*.js',
    'html/*.css',
    'html/logo.png',
}