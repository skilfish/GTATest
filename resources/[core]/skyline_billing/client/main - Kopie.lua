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

SKYLINE          = nil
local isDead = false

Citizen.CreateThread(function()
	while SKYLINE == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
		Citizen.Wait(0)
	end
end)

function ShowBillsMenu()

	SKYLINE.TriggerServerCallback('rechnungundso:getBills', function(bills)
		SKYLINE.UI.Menu.CloseAll()
		local elements = {}

		for i=1, #bills, 1 do
			table.insert(elements, {
				label  = ('%s - <span style="color:red;">%s</span>'):format(bills[i].label, SKYLINE.Math.GroupDigits(bills[i].amount) .. "$"),
				billID = bills[i].id
			})
		end

		SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
		{
			title    = "Rechnungen",
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			SKYLINE.TriggerServerCallback('rechnungundso:payBill', function()
				ShowBillsMenu()
			end, data.current.billID)
		end, function(data, menu)
			menu.close()
		end)
	end)

end

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, Keys['F7']) and not isDead and not SKYLINE.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'billing') then
			ShowBillsMenu()
		end
	end
end)

AddEventHandler('skyline:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)
