ESX = nil

if Config.UseESX then
	TriggerEvent('skylineistback:getSharedObject', function(obj) ESX = obj end)

	RegisterServerEvent('bezahlenandertankedufotze')
	AddEventHandler('bezahlenandertankedufotze', function(price)
		local xPlayer = ESX.GetPlayerFromId(source)
		local amount = ESX.Math.Round(price)

		if price > 0 then
			xPlayer.removeMoney(amount)
		end
	end)

	ESX.RegisterServerCallback("fuel:getCash", function(playerId , cb)
		local xPlayer = ESX.GetPlayerFromId(playerId)
		cb(xPlayer.getMoney())
	 end)

	RegisterNetEvent("fuel:giveJerryCan")
	 AddEventHandler("fuel:giveJerryCan", function()
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.addWeapon('weapon_petrolcan', 4500)
	 end)	

	 RegisterNetEvent("fuel:fuelJerryCan")
	 AddEventHandler("fuel:fuelJerryCan", function()
		local xPlayer = ESX.GetPlayerFromId(source)

		for k,v in ipairs(xPlayer.getLoadout()) do
			if v.name == "weapon_petrolcan" then 
				xPlayer.removeWeaponAmmo('WEAPON_PETROLCAN', v.ammo)
				xPlayer.addWeaponAmmo('WEAPON_PETROLCAN', 4500)
				break
			end 
			
		end


	 end)	
end
