Photos = {}

RegisterServerEvent("photos:sendToDiscord")
AddEventHandler("photos:sendToDiscord", function(source, imageurl)
    if source and imageurl then
        Photos.sendToDiscord (source, imageurl)
    else
        dprint("sendToDiscord | Missing Arguments")
    end
end)

Photos.sendToDiscord = function(source, imageurl)
    local source = source
	local DiscordWebHook = Discord.Images.Webhook

    local name = UserData[source].rpname
    local message = _U("picturefrom", name)
    local embeds = {
        {
            ["title"]=name,
            ["type"]="rich",
            ["color"] =Discord.Images.Color,
            ["image"] = {
                ["url"] = imageurl,
            },
            ["footer"]=  {
                ["text"]= message,
            },
        }
    }
   if message == nil or message == '' then return FALSE end
    
   PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = Discord.Images.Name,avatar_url = Discord.Images.AvatarURL, embeds = embeds}), { ['Content-Type'] = 'application/json' })
 end
 