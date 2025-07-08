SKYLINE = nil
TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
local _baller4 = false
local _blista = false

AddEventHandler('skyline:playerLoaded', function(source)
  local xPlayer = SKYLINE.GetPlayerFromId(source) 
end)

RegisterServerEvent('autoverleihdufotze:genuggeld')
AddEventHandler('autoverleihdufotze:genuggeld', function()
    local _source = source
    local xPlayer = SKYLINE.GetPlayerFromId(source)
    local _meingeld = xPlayer.getMoney()

     if xPlayer ~= nil then 
        TriggerClientEvent('autoverleihdufotze:antwort', _source, _meingeld)
     end
 end)

 
 RegisterServerEvent('autoverleihdufotze:bezahlen')
 AddEventHandler('autoverleihdufotze:bezahlen', function(wieviel)
    local _source = source
    local xPlayer = SKYLINE.GetPlayerFromId(source)
     local _meingeld = xPlayer.getMoney()
         if xPlayer ~= nil then 
             xPlayer.removeMoney(wieviel)
         end
  end)



RegisterServerEvent('autoverleihdufotze:antwortrentabfragen')
AddEventHandler('autoverleihdufotze:antwortrentabfragen', function()
 	local _source = source
 	local xPlayer = SKYLINE.GetPlayerFromId(source)
    local _meingeld = xPlayer.getMoney()
     if xPlayer ~= nil then 
        TriggerClientEvent('autoverleihdufotze:antwortrent', _source, _baller4, _blista)
     end
 end)


  

RegisterServerEvent('autoverleihdufotze:rented')
AddEventHandler('autoverleihdufotze:rented', function(auto, status)
    if auto == "baller4" then
      _baller4 = status
      elseif auto == "BLISTA" then
        _blista = status
    end
end)