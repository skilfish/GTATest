fx_version      'adamant'
game            'gta5'
description     'D-Phone from Deun Services'
version         '0.75 Beta 3'
ui_page         'html/main.html'

lua54 'yes'

server_script {
  "@mysql-async/lib/MySQL.lua",
  'locale.lua',
  'locales/en.lua',
  'locales/de.lua',
  "config/config.lua",
  "config/ipconfig.lua",

  "server/apps/*.lua",
  "server/classes/*.lua",
  "server/*.lua",

  -- Shared
  "shared/functions.lua",
  "shared/apps/*.lua",
}

client_script {
  'locale.lua',
  'locales/en.lua',
  'locales/de.lua',
  "config/config.lua",
  "config/ipconfig.lua",
  "client/*.lua",
  "client/apps/*.lua",

  -- Shared
  "shared/functions.lua",
  "shared/apps/*.lua",
}


files {
    'html/main.html',
    'html/js/*.js',
    'html/js/locales/*.js',
    'html/img/*.png',
      'html/img/broker/*.png',
    'html/css/*.css',
    'html/sound/*.ogg',
    'html/sound/DoodleJump/*.ogg',
    'html/fonts/font-1.ttf',
    'html/fonts/HalveticaNeue-Medium.ttf',
    'html/fonts/KeepCalm-Medium.ttf',
    'html/fonts/Azonix.otf',
    'html/fonts/keepcalm.otf',
    'html/fonts/*.woff',
    'html/fonts/*.ttf',
    'html/fonts/Roboto/*.ttf',
}

escrow_ignore {
  "config/config.lua",
  "config/newconfigstuff.lua",
  "server/suser.lua",
  "server/serverconfig.lua",
  "server/apps/sphoto.lua",
  "client/cuser.lua",
  "client/animation.lua",
  "client/photo.lua",
  'locales/en.lua',
  'locales/de.lua',
}
dependency '/assetpacks'