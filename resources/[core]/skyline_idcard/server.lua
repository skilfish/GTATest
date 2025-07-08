local SKYLINE = nil
-- SKYLINE
TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

-- Open ID card
RegisterServerEvent('idcardoderso:open')
AddEventHandler('idcardoderso:open', function(ID, targetID, type)
	local identifier = SKYLINE.GetPlayerFromId(ID).identifier
	local _source 	 = SKYLINE.GetPlayerFromId(targetID).source
	local show       = false
	
	
	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				if type ~= nil then
					for i=1, #licenses, 1 do
						if type == 'driver' then
							if licenses[i].type == 'drive' or licenses[i].type == 'drive_bike' or licenses[i].type == 'drive_truck' then
								show = true
							end
						elseif type =='weapon' then
							if licenses[i].type == 'weapon' then
								show = true
							end
						end
					end
				else
					show = true
				end

				if show then
					local array = {
						user = user,
						licenses = licenses
					}
					TriggerClientEvent('idcardoderso:open', _source, array, type)
				else
					TriggerClientEvent('skyline_notify:Alert', _source,  "BRIEFTASCHE" , "<b style=color:red;>Diese Lizenz hast du nicht!" , 3000 , "error")
				end
			end)
		end
	end)
end)
