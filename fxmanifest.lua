fx_version 'cerulean'
game 'gta5'

author 'Dein Name'
description 'ESX Framework Resource'
version '1.0.0'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

dependencies {
    'es_extended'
}
