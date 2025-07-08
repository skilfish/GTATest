fx_version "cerulean"
game "gta5"
server_script "rt_server.lua"
client_script "rt_client.lua"

server_exports
({
	"SetClientRender",
	"IsClientRendering"
})

