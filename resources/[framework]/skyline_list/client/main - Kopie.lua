SKYLINE = nil
local soundOn = true

Citizen.CreateThread(function()

	while SKYLINE == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
		Citizen.Wait(0)
	end

	local MenuType    = 'list'
	local OpenedMenus = {}

	local openMenu = function(namespace, name, data)

		OpenedMenus[namespace .. '_' .. name] = true

		SendNUIMessage({
			action    = 'openMenu',
			namespace = namespace,
			name      = name,
			data      = data
		})

		SKYLINE.SetTimeout(200, function()
			SetNuiFocus(true, true)
		end)

	end

	local closeMenu = function(namespace, name)

		OpenedMenus[namespace .. '_' .. name] = nil
		local OpenedMenuCount = 0

		SendNUIMessage({
			action    = 'closeMenu',
			namespace = namespace,
			name      = name,
			data      = data
		})

		for k,v in pairs(OpenedMenus) do
			if v == true then
				OpenedMenuCount = OpenedMenuCount + 1
			end
		end

		if OpenedMenuCount == 0 then
			SetNuiFocus(false)
		end

	end

	SKYLINE.UI.Menu.RegisterType(MenuType, openMenu, closeMenu)

	RegisterNUICallback('menu_submit', function(data, cb)
		local menu = SKYLINE.UI.Menu.GetOpened(MenuType, data._namespace, data._name)

		if menu.submit ~= nil then
			menu.submit(data, menu)
			if soundOn == true then
			PlaySound(0, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1);
			end
		end

		cb('OK')
	end)

	RegisterNUICallback('menu_cancel', function(data, cb)
		local menu = SKYLINE.UI.Menu.GetOpened(MenuType, data._namespace, data._name)

		if menu.cancel ~= nil then
			menu.cancel(data, menu)
			if soundOn == true then
			PlaySound(0, "Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1);			
			end
		end

		cb('OK')
	end)

end)