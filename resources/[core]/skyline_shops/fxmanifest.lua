fx_version 'cerulean'
game 'gta5'

description 'Skyline Shops'

version '1.0.0'


server_scripts {
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua'
  }
  
  client_scripts {
    'client/main.lua'
  }
  
  ui_page 'html/ui.html'
  files {
    'html/ui.html',
    'html/ui.css', 
    'html/ui.js',
    'html/*.png',
    'html/img/*.png',
  
    'html/items/*.png'
  }

