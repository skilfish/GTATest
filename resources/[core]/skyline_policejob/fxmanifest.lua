fx_version "cerulean"
game "gta5"

shared_script "config.lua"

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/server.lua"
} 

client_scripts {
    "client/client.lua"
}
