--================================================================================================--
--==                                VARIABLES - DO NOT EDIT                                     ==--
--================================================================================================--
SKYLINE                         = nil
inMenu                      = true
local atbank = false
local bankMenu = true

local keys = {
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

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

--================================================================================================
--==                                THREADING - DO NOT EDIT                                     ==
--================================================================================================

--===============================================
--==           Base SKYLINE Threading              ==
--===============================================
Citizen.CreateThread(function()
	while SKYLINE == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

	
		if nearBank() or nearATM() then
				isInMarker  = true
				currentZone = k


				
			
					if IsControlJustPressed(1, keys[Config.Keys.Open]) then
						openUI()
						TriggerServerEvent('banksystemoderso:balance')
						local ped = GetPlayerPed(-1)
					end

				
			
		end
	

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerEvent('ali_banksystemoderso:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('ali_banksystemoderso:hasExitedMarker', lastZone)
		end
	end
end)

AddEventHandler('ali_banksystemoderso:hasEnteredMarker', function(zone)

	SKYLINE.UI.Menu.CloseAll()
	

		CurrentAction     = zone
		TriggerEvent('notifications', "#0ac27f", "BANK", "Drücke E um auf die Bank zuzugreifen")
	
end)




--===============================================
--==             Core Threading                ==
--===============================================



--===============================================
--==             Map Blips	                   ==
--===============================================

--BANK
Citizen.CreateThread(function()
	if Config.ShowBlips then
	  for k,v in ipairs(Config.Bank)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite (blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 32)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Bank")
		EndTextCommandSetBlipName(blip)
	  end
	end
end)

--ATM
Citizen.CreateThread(function()
	if Config.ShowBlips and Config.OnlyBank == false then
	  for k,v in ipairs(Config.ATM)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite (blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.5)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Bankautomat")
		EndTextCommandSetBlipName(blip)
	  end
	end
end)


--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance)
	local id = PlayerId()

	SKYLINE.TriggerServerCallback("banksystemoderso:getName", function(name) 
		SendNUIMessage({
			type = "balanceHUD",
			balance = balance,
			player = name
		})
	end)
	

	
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('banksystemoderso:deposit', tonumber(data.amount))
	TriggerServerEvent('banksystemoderso:balance')
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('banksystemoderso:withdraw', tonumber(data.amountw))
	TriggerServerEvent('banksystemoderso:balance')
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('banksystemoderso:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('banksystemoderso:transfer', data.to, data.amountt)
	TriggerServerEvent('banksystemoderso:balance')
end)

--===============================================
--==         Result   Event                    ==
--===============================================
RegisterNetEvent('banksystemoderso:result')
AddEventHandler('banksystemoderso:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)


--===============================================
--==         SKYLINE Invest Event                  ==
--===============================================
RegisterNUICallback('SKYLINE_invest', function()
	if(inMenu) then

		inMenu = false
		SetNuiFocus(false, false)
		SendNUIMessage({type = 'closeAll'})
		exports.SKYLINE_invest:openUI()
	end
end)

--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	closeUI()
end)

AddEventHandler('onResourceStop', function (resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	closeUI()
end)

AddEventHandler('onResourceStart', function (resourceName)
	if(GetCurrentResourceName() ~= resourceName) then
		return
	end
	closeUI()
end)


--===============================================
--==            Capture Bank Distance          ==
--===============================================
function nearBank()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Bank) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 3 then
			SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um die ~y~Bank ~w~zu nutzen")

			return true
		end
	end
end

function nearATM()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.ATM) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 1 then
			SKYLINE.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den ~y~ATM ~w~zu nutzen")
			return true
		end
	end
end

function closeUI()
	inMenu = false
	SetNuiFocus(false, false)
	if Config.Animation.Active then 
		playAnim('mp_common', 'givetake1_a', Config.Animation.Time)
		Citizen.Wait(Config.Animation.Time)
	end
	SendNUIMessage({type = 'closeAll'})
end

function openUI()
	if Config.Animation.Active then 
		playAnim('mp_common', 'givetake1_a', Config.Animation.Time)
		Citizen.Wait(Config.Animation.Time)
	end
	inMenu = true
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openGeneral'})
	TriggerServerEvent('banksystemoderso:balance')
end


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
