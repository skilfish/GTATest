SKYLINE = nil

local base64MoneyIcon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFoAAABaCAMAAAAPdrEwAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAMAUExURQAAACmvPCmwPCuwPiywPi2wPy6xQC6xQS+yQTCxQTCyQTCyQjGyQzKyRDOzRTSzRTSzRjW0RjW0Rza0SDe0STi0STm1Sjq1Szq2Szu2TDy2TDy2TT22Tj63Tz+3UEC4UEG4UUG4UkK4U0O5VES5VEW6VUa6Vke6V0i7WEm7WUu8Wku8W0y8W028XE29XU++XlC9X1C+X1G+YFK+YVO/YlW/ZFXAZFfAZVfAZljBZlnBZ1rBaVvCaVvCalzDal7CbF/DbV/EbWHEbmLEb2LEcGTFcWfGdGjHdWrHd2vId2vIeGzIeW3JenHKfXLKfnPLf3TLgHXLgXXMgHXMgXbMgnjNg3nMhHrNhnrOhnzOiH7PiYLQjYPRjoTRjoTRj4XRkIXSkIfSkojSk4rUlYzUlo7VmJDWmpHWm5LXnJTXnZTXnpXYnpbYn5nZopzapJ3bpZ7bpp7bp6DcqKLcqqPcq6Tcq6TdrKberqjfr6jfsKnfsavgs6zgs6zgtK7hta/htrDit7LiuLLiubPjurTjurXju7bkvLbkvbnlv7rlwLrmwLzmwr3nw77nxMDnxcLox8PpyMTpycXpysXqysbqy8fqzMnrzcrrz8vsz8vs0Mzs0c3t0tHu1dHu1tPv19Tv2NXv2dXw2dbw2tfw29jw3Nnx3drx3t7z4d/z4uD04+H05OP15eP15uT15uT15+X16OX26Of26en36+r37Ov37er47Ov47ez47e347u347+758PD58fD68fD68vL69PT79fX79vb79/b89vb89/f8+Pj9+fn9+vr9+/v++/v+/Pz+/P3+/f3+/v7//wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALfZHJgAAAEAdFJOU////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////wBT9wclAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAAGHRFWHRTb2Z0d2FyZQBwYWludC5uZXQgNC4xLjb9TgnoAAAGdUlEQVRoQ7WZ93sURRiAFZO76O1eklt215OgBwqJgmgCRhAhRrAAiogBK4gBJEFEgWAEYiGIYEGp1kjXQECkiF0OWyjJ/k34zcy3db7Zu8fHe3/KTXnzPbPT56orRTEYAhMLUFgNKkeiGH8BNaV1KWSPVXveU9s3LW9pvhdoblm+afspTHZi5Wo1BnzpaOfcnFmWSBv29YBtpBNlZm5u59FLPDsmdJUaxQeXNugZw5IwMnrD0oO8iFKuUHNx/+bGZLWNMgm7Otm4uZ/LsVIEUs3F+Y5a3USNAlOv7cgr5ZSamQffyOnKgH1sPdfFi2PVILKaReEcmKwVIWbY2uQDvApW95HULIb+Ng0rFoXWxppcCjyqZuZjk4oNWWBrk44R7oiamXdkC3w9GTO7Q3aH1cy8OkWFnHtitstM4j/bqdWSO6Rm5nYdS4e5FbKQwxlMC6G3Q1bIHVQz8+IKLBphJLdydlRjWpiKxZAXdAfUPOak4gOO4FZOdxWmhbGTkbh9NTOvoVsDuGmAaxkdlZgWRV8Dub7bV0PyzhQWkqk5z7WMdjpqILUTslEXUEPQJ7Lq7pz9WXiBZ4iZUGBnTwTCdtVgvjgxpj+b3vTvTEteq5KbEy/6blcNVZapR3cmdc9Z4QV6Pnxzdr1GF9aWQQFUohqCPqQc3ZV17X3C6tP31kyL+Jy2dsgLW6jBPDgVc6OkR3XxCV/i9IqRRFedylxc6qk30L3DNF7ikz1Jft0oLOaT2hBSg/l8jmwOo24/amimYzkfOwfdlLtdNT1YjIaf0EFzgGhuNnB8teNcqCWDvs3vzSSLqC9Ze0F0EqaGoDeSQWt7UaHgXA0WDKFvFGEzNRS6mxot6VZhUNJNdm7zbsgSagj6UAKTQ5hnhEHJffRISIi+LdRLyNn9cTSoOExP3FZmiat2nIF66t9Xb0GFz8Df+AenVTEF2vUwAzM1BN1LfsTkcVS4bJs+fnRj84z3joqf+eFYUELvZWFzdSfZHjeeEwqXl6/myWaZ0bSVDf3uJP9NkOn01HPISXIMTJAB/hiB6WBPN+xxBpvxl4wxR6ihll8pSL1QupwLLhR22YL9ysVGrKRcfZJeAu4QSo+1yWA3rla2NGCeZGpoj13lmBJm1F/odDm+fv68phorU0l+miDlu6BFmLqbHDCWdhqVQQb/zPesW1inqxdoRqIb1SvSmBJG+wR1BF+/NkmLWUnTK1DdQq+i5gvoIbn85QPqtdRoQfU0TIgy4h/UKOi+gZ5DgGmonqIoob2CDhXHblE0ij2lgNo2YMcSy7fkhF2E2rIm/IoOFV/Q+78i1JkJheJ+jOzjnlr1GRk18swa4iC9t3U/o6LzCVLTP4dlVM14LBfC63yKIYOYeuMqcRoneZFqEW/IKAY6Q8xumla3YP2+PNnNt1Jqb6Arpifg5kXuHjNTaVi1s5/eJs0r+6gFUkxP6kkV2mKBs8UMZSYMdmAJcpxqTTGpqpcCEO1znCMTwlPFNbuF0uUs1UVwKYAWoRcwGDHsbNS/algwu+J1bvToI9TuAgZqetm1roPVk/FDazbhjaryr0SiSw/R1oFll94sWNnfsLrzS1eTkawyjKrE6HcwyeVtIix3s6Dc4ljzsTbnx74P1na83+uf8ZBn5cb0tjgsbHJjlvoMa8dxWT4XBDZmoCa3k7eH9yE0u4l9jr+dZN2P2ASnVorK8TwoVwxsglnYxNY9852oHMseogMEt+4QtnzgGDoTa8eRH4ulA4QOHCxs6ZhUBdNAIS7NIjp1+JgEaulwZzwsnXCjDDxPzB+Rwx1zS0fSoVZb/Mp4/lFqQxk5kjI1cZDWa179HTUEe8eRW9XoQZq5qeN/5fCFigWmd14VNRXLx3/et8lLC7N8XNtH0VP6mXfvV+z4iEsLFrbqqkXXho2Z8dynwgo8NdZK0SXpqxbmjrsgquhCsXrhgOYgL4h4k8Rca5VvFV7gTkySUVxrsbBjLuOGfMy1jCZFa6gv47hbeYU4ZA/XMmbRy13MFaJwqy4+Ez1cy3iSVsddfGLcdJvo33Ato5VcSeOva4WbvmQ2v+daxkrqfqXQJbNwk1fj9kOPuNwlZxdxNS7c5IW+MdRFMhd3oS/cpXmG4EOnRI8nAAt8sKsETz4AK1yahyqAy0vxvAaU7lEQcJ8yj9BPmUf+81MmR8iB//kBllOyZ2NOqR67XUAVABNjuXLlX2rCcoFjOcGoAAAAAElFTkSuQmCC'

Citizen.CreateThread(function()
	while SKYLINE == nil do
		TriggerEvent('skylineistback:getSharedObject', function(obj) SKYLINE = obj end)
		Citizen.Wait(0)
	end

	while SKYLINE.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	SKYLINE.PlayerData = SKYLINE.GetPlayerData()

	RefreshBussHUD()
end)

RegisterNetEvent('skyline:setJob')
AddEventHandler('skyline:setJob', function(job)
	SKYLINE.PlayerData.job = job
	RefreshBussHUD()
end)

function RefreshBussHUD()
	DisableSocietyMoneyHUDElement()

	if SKYLINE.PlayerData.job.grade_name == 'boss' then
		EnableSocietyMoneyHUDElement()

		SKYLINE.TriggerServerCallback('jobsundso:getSocietyMoney', function(money)
			UpdateSocietyMoneyHUDElement(money)
		end, SKYLINE.PlayerData.job.name)
	end
end

RegisterNetEvent('accountoderso:setMoney')
AddEventHandler('accountoderso:setMoney', function(society, money)
	if SKYLINE.PlayerData.job and SKYLINE.PlayerData.job.grade_name == 'boss' and 'society_' .. SKYLINE.PlayerData.job.name == society then
		UpdateSocietyMoneyHUDElement(money)
	end
end)

function EnableSocietyMoneyHUDElement()
	local societyMoneyHUDElementTpl = '<div><img src="' .. base64MoneyIcon .. '" style="width:20px; height:20px; vertical-align:middle;">&nbsp;{{money}}</div>'

	if SKYLINE.GetConfig().EnableHud then
		SKYLINE.UI.HUD.RegisterElement('society_money', 3, 0, societyMoneyHUDElementTpl, {
			money = 0
		})
	end

	TriggerEvent('jobsundso:toggleSocietyHud', true)
end

function DisableSocietyMoneyHUDElement()
	if SKYLINE.GetConfig().EnableHud then
		SKYLINE.UI.HUD.RemoveElement('society_money')
	end

	TriggerEvent('jobsundso:toggleSocietyHud', false)
end

function UpdateSocietyMoneyHUDElement(money)
	if SKYLINE.GetConfig().EnableHud then
		SKYLINE.UI.HUD.UpdateElement('society_money', {
			money = SKYLINE.Math.GroupDigits(money)
		})
	end

	TriggerEvent('jobsundso:setSocietyMoney', money)
end

function OpenBossMenu(society, close, options)
	options = options or {}
	local elements = {}

	SKYLINE.TriggerServerCallback('jobsundso:isBoss', function(isBoss)
		if isBoss then
			local defaultOptions = {
				withdraw = true,
				deposit = true,
				wash = false,
				employees = true,
				grades = true
			}

			for k,v in pairs(defaultOptions) do
				if options[k] == nil then
					options[k] = v
				end
			end

			if options.withdraw then
				table.insert(elements, {label = "Geld abheben", value = 'withdraw_society_money'})
			end

			if options.deposit then
				table.insert(elements, {label = "Geld einzahlen", value = 'deposit_money'})
			end

			if options.wash then
				table.insert(elements, {label = "Geld waschen", value = 'wash_money'})
			end

			if options.employees then
				table.insert(elements, {label = "Mitarbeiterliste", value = 'manage_employees'})
			end

			if options.grades then
				table.insert(elements, {label = "Gehalt verwalten", value = 'manage_grades'})
			end

			SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'boss_actions_' .. society, {
				title    = "Firma Verwalten",
				align    = 'top-left',
				elements = elements
			}, function(data, menu)
				if data.current.value == 'withdraw_society_money' then
					SKYLINE.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. society, {
						title = "Menge"
					}, function(data2, menu2)
						local amount = tonumber(data2.value)

						if amount == nil then
							TriggerEvent("SKYLINE_notify", 1 , "Bank" , "<b style=color:red;>Ungültige Menge!")
						else
							menu2.close()
							TriggerServerEvent('jobsundso:withdrawMoney', society, amount)
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				elseif data.current.value == 'deposit_money' then
					SKYLINE.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. society, {
						title = "Menge"
					}, function(data2, menu2)
						local amount = tonumber(data2.value)

						if amount == nil then
							TriggerEvent("SKYLINE_notify", 1 , "Bank" , "<b style=color:red;>Ungültige Menge!")
						else
							menu2.close()
							TriggerServerEvent('jobsundso:depositMoney', society, amount)
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				elseif data.current.value == 'wash_money' then
					SKYLINE.UI.Menu.Open('dialog', GetCurrentResourceName(), 'wash_money_amount_' .. society, {
						title =  "Menge"
					}, function(data2, menu2)
						local amount = tonumber(data2.value)

						if amount == nil then
							TriggerEvent("SKYLINE_notify", 1 , "Bank" , "<b style=color:red;>Ungültige Menge!")
						else
							menu2.close()
							TriggerServerEvent('jobsundso:washMoney', society, amount)
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				elseif data.current.value == 'manage_employees' then
					OpenManageEmployeesMenu(society)
				elseif data.current.value == 'manage_grades' then
					OpenManageGradesMenu(society)
				end
			end, function(data, menu)
				if close then
					close(data, menu)
				end
			end)
		end
	end, society)
end

function OpenManageEmployeesMenu(society)
	SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_employees_' .. society, {
		title    = "Mitarbeiter Verwalten",
		align    = 'top-left',
		elements = {
			{label = "Mitarbeiterliste", value = 'employee_list'},
			{label = "Mitarbeiter Einstellen", value = 'recruit'}
	}}, function(data, menu)
		if data.current.value == 'employee_list' then
			OpenEmployeeList(society)
		elseif data.current.value == 'recruit' then
			OpenRecruitMenu(society)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenEmployeeList(society)  
    Citizen.Wait(200)
	SKYLINE.TriggerServerCallback('jobsundso:getEmployees', function(employees)

		local elements = {
			head = {"Mitarbeiter", "Rang", "Aktionen"},
			rows = {}
		}

		for i=1, #employees, 1 do
			local gradeLabel = (employees[i].job.grade_label == '' and employees[i].job.label or employees[i].job.grade_label)

			table.insert(elements.rows, {
				data = employees[i],
				cols = {
					employees[i].name,
					gradeLabel,
					'{{' .. "Befördern" .. '|promote}} {{' .. "Feuern" .. '|fire}}'
				}
			})
		end

		SKYLINE.UI.Menu.Open('list', GetCurrentResourceName(), 'employee_list_' .. society, elements, function(data, menu)
			local employee = data.data

			if data.value == 'promote' then
				menu.close()
				OpenPromoteMenu(society, employee)
			elseif data.value == 'fire' then
				TriggerEvent("SKYLINE_notify", 1 , "Mitarbeiter" , "Du hast <b style=color:green;>" .. employee.name .. "<b> gefeuert.")
				SKYLINE.TriggerServerCallback('jobsundso:setJob', function()
					OpenEmployeeList(society)
				end, employee.identifier, 'unemployed', 0, 'fire')
			end
		end, function(data, menu)
			menu.close()
			OpenManageEmployeesMenu(society)
		end)
	end, society)
end

function OpenRecruitMenu(society)
    local closestPlayer, closestPlayerDistance = SKYLINE.Game.GetClosestPlayer()

    local elements = {}

    if closestPlayer == -1 or closestPlayerDistance > 10.0 then
         elements = {label = "Keiner in der Nähe!" , value = "error"}
    else
        SKYLINE.TriggerServerCallback("jobsundso:fetchPlayer", function(license , name1 ) 

            SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_' .. society, {
                title    = "Einstellen",
                align    = 'top-left',
                elements =  {{label = name1, value = GetPlayerServerId(closestPlayer), name = name1, identifier = license}}
            }, function(data, menu)
                SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_confirm_' .. society, {
                    title    = "Möchtest du " .. data.current.name .. " einstellen?",
                    align    = 'top-left',
                    elements = {
                        {label = "<b style=color:red;>Nein", value = 'no'},
                        {label = "<b style=color:green;>Ja", value = 'yes'}
                }}, function(data2, menu2)
                    menu2.close()
    
                    if data2.current.value == 'yes' then
                        TriggerEvent("SKYLINE_notify", "Mitarbeiter" , "Du hast <b style=color:green;>" .. data.current.name .. "<b> eingestellt." , 3000 , "success")
    
                        SKYLINE.TriggerServerCallback('jobsundso:setJob', function()
                            OpenRecruitMenu(society)
                        end, data.current.identifier, society, 0, 'hire')
                    end
                end, function(data2, menu2)
                    menu2.close()
                end)
            end, function(data, menu)
                menu.close()
            end)

        end, GetPlayerServerId(closestPlayer))
    end

	

		
end

function OpenPromoteMenu(society, employee)
	SKYLINE.TriggerServerCallback('jobsundso:getJob', function(job)
		local elements = {}

		for i=1, #job.grades, 1 do
			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)

			table.insert(elements, {
				label = gradeLabel,
				value = job.grades[i].grade,
				selected = (employee.job.grade == job.grades[i].grade)
			})
		end

		SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'promote_employee_' .. society, {
			title    = "Mitarbeiter " .. employee.name .. " befördern",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()
			TriggerEvent("SKYLINE_notify", 1 , "Mitarbeiter" , "Du hast <b style=color:green;> " .. employee.name .. "<b> auf den Rang: <b style=color:yellow;>" .. data.current.label .. "<b> gesetzt")


			SKYLINE.TriggerServerCallback('jobsundso:setJob', function()
				OpenEmployeeList(society)
			end, employee.identifier, society, data.current.value, 'promote')
		end, function(data, menu)
			menu.close()
			OpenEmployeeList(society)
		end)
	end, society)
end

function OpenManageGradesMenu(society)
	SKYLINE.TriggerServerCallback('jobsundso:getJob', function(job)
		local elements = {}

		for i=1, #job.grades, 1 do
			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)

			table.insert(elements, {
				label = "",
				value = job.grades[i].grade
			})
		end

		SKYLINE.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_' .. society, {
			title    = "Gehalt verwalten",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			SKYLINE.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_grades_amount_' .. society, {
				title = "Gehalt Menge"
			}, function(data2, menu2)

				local amount = tonumber(data2.value)

				if amount == nil then
					TriggerEvent("SKYLINE_notify", 1 , "Bank" , "<b style=color:red;>Ungültige Menge!")
				else
					menu2.close()

					SKYLINE.TriggerServerCallback('jobsundso:setJobSalary', function()
						OpenManageGradesMenu(society)
					end, society, data.current.value, amount)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, society)
end

AddEventHandler('jobsundso:openBossMenu', function(society, close, options)
	OpenBossMenu(society, close, options)
end)
