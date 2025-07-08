local SKYLINE = nil
local stage = 1
local micmuted = false
local lastMoney = 0
local isReady = false
local voice = {default = 6.0, shout = 15.0, whisper = 2.0, current = 0} 
local isShow = false 
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

Citizen.CreateThread(function()
    while true do 

        if isShow and exports["skyline_ffa"]:isInFFA() then 
            isShow = false 
            SendNUIMessage({action = "hideH"})

        end 

        if not isShow and not exports["skyline_ffa"]:isInFFA() then 
            isShow = true 
            SendNUIMessage({action = "showH"})
        end 


        Citizen.Wait(1000)
    end 
end)


function getVoiceLevel()
	local a = exports["saltychat"]:GetVoiceRange()

	if a == 3.5 then
		return 1
	elseif a == 8.0 then 
		return 2 
	elseif a == 15.0 then 
		return 3
	elseif a == 32.00 then
	   return 4 
	end 
end 

local voicelevel = 0
Citizen.CreateThread(function()
	while SKYLINE == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
		Citizen.Wait(0)
	end

	TriggerEvent('skyline:setMoneyDisplay', 0.0)
	SKYLINE.UI.HUD.SetDisplay(0.0)
	
	Citizen.Wait(2000)

	SKYLINE.TriggerServerCallback("skyline_money_hud:loadMoney", function(a , b) 
		SendNUIMessage({action = "setBlackMoney", black = b})
		SendNUIMessage({action = "setMoney", money = a})
	end)

	SendNUIMessage({action = "setVoiceLevel", level = getVoiceLevel()});

end)

  
AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end

	Citizen.Wait(2000)

	SendNUIMessage({action = "muted"})

end)
  
  

RegisterNetEvent('skyline:playerLoaded')
AddEventHandler('skyline:playerLoaded', function(xPlayer) 
	local data = xPlayer
	local accounts = data.accounts
	SendNUIMessage({action = "setVoiceLevel", level = getVoiceLevel()});

	for k, v in pairs(accounts) do
		local account = v

		Citizen.CreateThread(function()
			if account.name == "black_money" then
				if account.money > 0 then
				SendNUIMessage({action = "setBlackMoney", black = account.money})
				else
				SendNUIMessage({action = "setBlackMoney", black = 0})
				end
			end

			if SKYLINE.GetPlayerData().money ~= nil then
				SendNUIMessage({action = "setMoney", money = SKYLINE.GetPlayerData().money})
			end

		
			SendNUIMessage({action = "muted"})

		end)
	end
end)

AddEventHandler("onClientMapStart", function()
	NetworkSetTalkerProximity(voice.default)
end)




RegisterNetEvent('skyline:setAccountMoney')
AddEventHandler('skyline:setAccountMoney', function(account)
	
	if account.name == "money" then
		SendNUIMessage({action = "setMoney", money = account.money})
	end
	
	if account.name == "black_money" then
		if account.money > 0 then
			SendNUIMessage({action = "setBlackMoney", black = account.money})
		else
			SendNUIMessage({action = "setBlackMoney", black = 0})
			SendNUIMessage({action = "hideBlackMoney"})
	    end
	end
end)


RegisterNetEvent('SaltyChat_TalkStateChanged')
AddEventHandler('SaltyChat_TalkStateChanged', function(SaltyisTalking)
end)

RegisterNetEvent('SaltyChat_MicEnabledChanged')
AddEventHandler('SaltyChat_MicEnabledChanged', function(SaltyisMicrophoneEnabled)

	if SaltyisMicrophoneEnabled == true then
		SendNUIMessage({action = "nomuted"})
	else 
  	  	SendNUIMessage({action = "muted"})
	end

end)

RegisterNetEvent('SaltyChat_MicStateChanged')
AddEventHandler('SaltyChat_MicStateChanged', function(SaltyisMicrophoneMuted)

	if SaltyisMicrophoneMuted == true then
  	    SendNUIMessage({action = "muted"})
	else
	    SendNUIMessage({action = "nomuted"})
				
	end
	
end)


RegisterNetEvent('skyline:activateMoney')
AddEventHandler('skyline:activateMoney', function(e)
	SendNUIMessage({action = "setMoney", money = e})
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)

		local data = exports.saltychat:GetRadioChannel(true)

			if  data == nil or data == '' then
				SendNUIMessage({action = "hide"})
			else
				SendNUIMessage({action = "show"})
			end
	  end
  end)


  
 local markerType = 1 
 local markerColorR = 0 
 local markerColorG = 171
 local markerColorB = 245 
 local markerAlpha = 0.4 

 local afterBurn = 2000
 
 local isDrawing = false 
 local curProx = 0.0 
 
 RegisterNetEvent('SaltyChat_VoiceRangeChanged')
 AddEventHandler('SaltyChat_VoiceRangeChanged', function(range)
	 local a = -1;
 
	 if range == 3.5 then 
		 a = 1 
	 elseif range == 8.0 then 
		 a = 2
	elseif range == 15.0 then  
		 a = 3
	else 
		a = 4
	end 
	 
	SendNUIMessage({action = "setVoiceLevel", level = a});
 end)
 
 RegisterNetEvent('SaltyChat_VoiceRangeChanged')
 AddEventHandler('SaltyChat_VoiceRangeChanged', function(range)
 
	 TriggerEvent("skyline_notify:Alert", "SYSTEM" , "Neue Sprachreichweite ist: <b style=color:yellow>" .. range .. " Meter</b>" , 2000  , "long")
	
	 isDrawing = true
	 curProx = tonumber(range)
 
	 CreateThread(function() 
	  drawMarker()
	 end)
	 Wait(afterBurn)
 
	
	 isDrawing = false
 
 end)
 
 function drawMarker()
	 
	 
	 while isDrawing do
 
		 
	
		 local posPlayer = GetEntityCoords(PlayerPedId())
 
	  
		 DrawMarker(markerType, posPlayer.x, posPlayer.y, posPlayer.z - 0.4, 0, 0, 0, 0, 0,0, curProx * 2, curProx * 2, 0.8001, markerColorR, markerColorG, markerColorB, markerAlpha, 0, 0, 0)
 
		 Wait(1)
 
	 end
 
 end
 