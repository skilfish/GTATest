fx_version "cerulean"
game "gta5"
version "1.0.0"

server_scripts {
  "@async/async.lua",
  "@mysql-async/lib/MySQL.lua",
  "config.lua",
  "server/main.lua"
}

client_scripts {
  "client/main.lua",
  "config.lua"
}

ui_page "html/index.html"

files {
  "html/index.html",
  "html/style.css", 
  "html/script.js",
  "html/img/*"
}