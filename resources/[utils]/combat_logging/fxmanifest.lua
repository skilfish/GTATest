fx_version 'cerulean'
game 'gta5'

description 'Combat Logging Module with Webhook Support'
author 'ChatGPT'
version '1.0.0'

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
