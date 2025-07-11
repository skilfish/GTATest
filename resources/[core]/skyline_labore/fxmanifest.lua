fx_version "cerulean"
game "gta5"

dependency 'meta_libs'

client_scripts {
  'colors-rgb.lua',
  'langs/main.lua',
  'langs/en.lua',
  'config.lua',
  'utils.lua',
  'code.lua',
  'client/main.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'langs/main.lua',
  'langs/en.lua',
  'config.lua',
  'utils.lua',
  'code.lua',
  'server/main.lua',
}
