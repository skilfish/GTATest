SKYLINE                = nil
local InService    = {}
local MaxInService = {}

TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)

function GetInServiceCount(name)
	local count = 0

	for k,v in pairs(InService[name]) do
		if v == true then
			count = count + 1
		end
	end

	return count
end

AddEventHandler('serviceistcool:activateService', function(name, max)
	InService[name]    = {}
	MaxInService[name] = max
end)

RegisterServerEvent('serviceistcool:disableService')
AddEventHandler('serviceistcool:disableService', function(name)
	InService[name][source] = nil
end)

RegisterServerEvent('serviceistcool:notifyAllInService')
AddEventHandler('serviceistcool:notifyAllInService', function(notification, name)
	for k,v in pairs(InService[name]) do
		if v == true then

			local xPlayer = SKYLINE.GetPlayerFromId(source)
			local a =  xPlayer.getName()
		
			TriggerClientEvent('serviceistcool:notifyAllInService', k, source , notification , a)
			 

		end
	end
end)

SKYLINE.RegisterServerCallback('serviceistcool:enableService', function(source, cb, name)
	local inServiceCount = GetInServiceCount(name)

	if inServiceCount >= MaxInService[name] then
		cb(false, MaxInService[name], inServiceCount)
	else
		InService[name][source] = true
		cb(true, MaxInService[name], inServiceCount)
	end
end)

SKYLINE.RegisterServerCallback('serviceistcool:isInService', function(source, cb, name)
	local isInService = false

	if InService[name] ~= nil then
		if InService[name][source] then
			isInService = true
		end
	end

	cb(isInService)
end)

SKYLINE.RegisterServerCallback('serviceistcool:isPlayerInService', function(source, cb, name, target)
	local isPlayerInService = false
	local targetXPlayer = SKYLINE.GetPlayerFromId(target)

	if InService[name][targetXPlayer.source] then
		isPlayerInService = true
	end

	cb(isPlayerInService)
end)

SKYLINE.RegisterServerCallback('serviceistcool:getInServiceList', function(source, cb, name)
	cb(InService[name])
end)

AddEventHandler('playerDropped', function()
	local _source = source
		
	for k,v in pairs(InService) do
		if v[_source] == true then
			v[_source] = nil
		end
	end
end)
