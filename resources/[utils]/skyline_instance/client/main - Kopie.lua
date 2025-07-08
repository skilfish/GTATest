local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local Instance                = {}
local InstanceInvite          = nil
local InstancedPlayers        = {}
local RegisteredInstanceTypes = {}
local InsideInstance          = false
ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function GetInstance()
	return Instance
end

function CreateInstance(type, data)
	TriggerServerEvent('instanceistgay:create', type, data)
end

function CloseInstance()
	Instance = {}
	TriggerServerEvent('instanceistgay:close')
	InsideInstance = false
end

function EnterInstance(instance)
	InsideInstance = true
	TriggerServerEvent('instanceistgay:enter', instance.host)

	if RegisteredInstanceTypes[instance.type].enter ~= nil then
		RegisteredInstanceTypes[instance.type].enter(instance)
	end
end

function LeaveInstance()
	if Instance.host ~= nil then

		if #Instance.players > 1 then
			TriggerEvent("skyline_notify:Alert", "GEBÄUDE" , "Du hast das Gebäude verlassen." , 2000 , "error")
		end

		if RegisteredInstanceTypes[Instance.type].exit ~= nil then
			RegisteredInstanceTypes[Instance.type].exit(Instance)
		end

		TriggerServerEvent('instanceistgay:leave', Instance.host)
	end

	InsideInstance = false
end

function InviteToInstance(type, player, data)
	TriggerServerEvent('instanceistgay:invite', Instance.host, type, player, data)
end

function RegisterInstanceType(type, enter, exit)
	RegisteredInstanceTypes[type] = {
		enter = enter,
		exit  = exit
	}
end

AddEventHandler('instanceistgay:get', function(cb)
	cb(GetInstance())
end)

AddEventHandler('instanceistgay:create', function(type, data)
	CreateInstance(type, data)
end)

AddEventHandler('instanceistgay:close', function()
	CloseInstance()
end)

AddEventHandler('instanceistgay:enter', function(instance)
	EnterInstance(instance)
end)

AddEventHandler('instanceistgay:leave', function()
	LeaveInstance()
end)

AddEventHandler('instanceistgay:invite', function(type, player, data)
	InviteToInstance(type, player, data)
end)

AddEventHandler('instanceistgay:registerType', function(name, enter, exit)
	RegisterInstanceType(name, enter, exit)
end)

RegisterNetEvent('instanceistgay:onInstancedPlayersData')
AddEventHandler('instanceistgay:onInstancedPlayersData', function(instancedPlayers)
	InstancedPlayers = instancedPlayers
end)

RegisterNetEvent('instanceistgay:onCreate')
AddEventHandler('instanceistgay:onCreate', function(instance)
	Instance = {}
end)

RegisterNetEvent('instanceistgay:onEnter')
AddEventHandler('instanceistgay:onEnter', function(instance)
	Instance = instance
end)

RegisterNetEvent('instanceistgay:onLeave')
AddEventHandler('instanceistgay:onClose', function(instance)
	Instance = {}
end)

RegisterNetEvent('instanceistgay:onClose')
AddEventHandler('instanceistgay:onClose', function(instance)
	Instance = {}
end)

RegisterNetEvent('instanceistgay:onPlayerEntered')
AddEventHandler('instanceistgay:onPlayerEntered', function(instance, player)
	Instance = instance
	local playerName = GetPlayerName(GetPlayerFromServerId(player))

	ESX.ShowNotification(_('entered_into', playerName))
end)

RegisterNetEvent('instanceistgay:onPlayerLeft')
AddEventHandler('instanceistgay:onPlayerLeft', function(instance, player)
	Instance = instance
	local playerName = GetPlayerName(GetPlayerFromServerId(player))

	TriggerEvent("skyline_notify:Alert", "GEBÄUDE" , playerName .. " hat das Gebäude verlassen." , 2500 , "error")
end)

RegisterNetEvent('instanceistgay:onInvite')
AddEventHandler('instanceistgay:onInvite', function(instance, type, data)
	InstanceInvite = {
		type = type,
		host = instance,
		data = data
	}

	Citizen.CreateThread(function()
		Citizen.Wait(10000)

		if InstanceInvite ~= nil then
			TriggerEvent("skyline_notify:Alert", "GEBÄUDE" , "Die Einladung ist abgelaufen!" , 2500 , "error")
			InstanceInvite = nil
		end
	end)
end)

RegisterInstanceType('default')

-- Input invites
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if InstanceInvite ~= nil then
			ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um das Gebäude zu betreten")
		else
			Citizen.Wait(500)
		end

	end
end)

-- Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if InstanceInvite ~= nil and IsControlJustReleased(0, Keys['E']) then
			local playerPed = PlayerPedId()

			EnterInstance(InstanceInvite)
			TriggerEvent("skyline_notify:Alert", "GEBÄUDE" , "Gebäude betreten." , 2000 , "success")
			InstanceInvite = nil

		elseif InstanceInvite == nil then
			Citizen.Wait(500)
		end

	end

end)

-- Instance players
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if Instance.host ~= nil then

			local playerPed = PlayerPedId()

			for i=0, Config.MaxPlayers, 1 do

				local found = false
				for j=1, #Instance.players, 1 do
					instancePlayer = GetPlayerFromServerId(Instance.players[j])

					if i == instancePlayer then
						found = true
					end
				end

				if not found then
					local otherPlayerPed = GetPlayerPed(i)

					SetEntityLocallyInvisible(otherPlayerPed)
					SetEntityVisible(otherPlayerPed, false, 0)
					SetEntityNoCollisionEntity(playerPed, otherPlayerPed, true)
				end

			end

		else

			local playerPed = PlayerPedId()

			for i=0, Config.MaxPlayers, 1 do

				local found = false
				for j=1, #InstancedPlayers, 1 do
					instancePlayer = GetPlayerFromServerId(InstancedPlayers[j])

					if i == instancePlayer then
						found = true
					end
				end

				if found then
					local otherPlayerPed = GetPlayerPed(i)

					SetEntityLocallyInvisible(otherPlayerPed)
					SetEntityVisible(otherPlayerPed, true, 0)
					SetEntityNoCollisionEntity(playerPed, otherPlayerPed, true)
				end

			end

		end

	end
end)

Citizen.CreateThread(function()
	TriggerEvent('instanceistgay:loaded')
end)

-- Fix vehicles randomly spawning nearby the player inside an instance
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0) -- must be run every frame
		
		if InsideInstance then
			SetVehicleDensityMultiplierThisFrame(0.0)
			SetParkedVehicleDensityMultiplierThisFrame(0.0)

			local pos = GetEntityCoords(PlayerPedId())
			RemoveVehiclesFromGeneratorsInArea(pos.x - 900.0, pos.y - 900.0, pos.z - 900.0, pos.x + 900.0, pos.y + 900.0, pos.z + 900.0)
		else
			Citizen.Wait(500)
		end
	end
end)