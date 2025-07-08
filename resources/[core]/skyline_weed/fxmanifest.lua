fx_version "cerulean"
game "gta5"

dependencies {'mysql-async'}

shared_scripts {
    'locale.lua',
    'locales/*.lua',
    'config.lua',
    'lib/octree.lua',
    'lib/growth.lua',
    'lib/cropstate.lua',
}
client_scripts {
    'lib/debug.lua',
    'cl_uteknark.lua',
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'sv_uteknark.lua',
}
