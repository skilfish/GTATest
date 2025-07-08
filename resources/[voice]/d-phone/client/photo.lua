phone = false
phoneId = 0
messagemode = false
groupchatmode = false
teamchatmessagemode = false
local phoneanimation = false

RegisterNetEvent('camera:phone')
AddEventHandler('camera:phone', function()		
	CreateMobilePhone(phoneId)
	CellCamActivate(true, true)
	phone = true
	SetNuiFocusKeepInput(true)
end)

frontCam = false

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

-- RemoveLoadingPrompt()

TakePhoto = N_0xa67c35c56eb1bd9d
WasPhotoTaken = N_0x0d6ca79eeebd8ca3
SavePhoto = N_0x3dec726c25a11bac
ClearPhoto = N_0xd801cc02177fa3f1

helpText = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

local hideui = false
Citizen.CreateThread(function()
DestroyMobilePhone()
	while true do
		Citizen.Wait(0)
		--if phoneanimation == true then
				if IsControlJustPressed(0, 27) and phone == true then -- SELFIE MODE
					frontCam = not frontCam
					CellFrontCamActivate(frontCam)
				end
				
				if phone == true and hideui == false then
					AddTextEntry(GetCurrentResourceName(), _U("cameracontrol"))
					DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
				end

				if IsControlJustPressed(0, 177) and phone == true then -- CLOSE PHONE
					DestroyMobilePhone()
					phone = false
					
					CellCamActivate(false, false)
					DoPhoneAnimation('cellphone_text_in')
					newPhoneProp()
					TriggerServerEvent("d-phone:server:getphonedata", GetPlayerServerId(PlayerId()))
					phoneanimation = false
					DisplayRadar(true)
					if messagemode == true then
						messagemode = false
					elseif teamchatmessagemode == true then
						teamchatmessagemode = false
					elseif groupchatmode == true then
						groupchatmode = false
					end
				end
				
				if IsControlJustPressed(0, 176) and phone == true and hideui == false then -- TAKE.. PIC
					hideui = true

					Wait(100)
					local enter = Discord
					CheckTableLoop(enter, "Discord")
					if Discord.Images.AllImageWebhook ~= "" then
						dprint(Discord.Images.AllImageWebhook)
						exports["screenshot-basic"]:requestScreenshotUpload(Discord.Images.AllImageWebhook, 'files[]', function(data2)
							local response = json.decode(data)
							local response2 = json.decode(data2)
							dprint(data2)
							local imageurl = response2.attachments[1].proxy_url

							if messagemode == true then
								Messages.Chat.TakePhoto(response2.attachments[1].proxy_url)
							elseif teamchatmessagemode == true then
								Business.functions.TeamChat.TakePhoto(response2.attachments[1].proxy_url)
							elseif groupchatmode == true then
								TriggerServerEvent("groupchat:settings:change", UserData.source, Groupchat.openchat.groupname, "image", imageurl )
							elseif Discord.Images.Webhook ~= nil then
								TriggerServerEvent("photos:sendToDiscord", UserData.source, imageurl)
							end
						end)
						SendNotify(_U("tookphoto"), 5000, "photo")
						
					end
					Wait(100)
					if messagemode == true or teamchatmessagemode == true or groupchatmode == true then
						DestroyMobilePhone()
						phone = false
						CellCamActivate(false, false)
						DoPhoneAnimation('cellphone_text_in')
						newPhoneProp()
						TriggerServerEvent("d-phone:server:getphonedata", GetPlayerServerId(PlayerId()))
						phoneanimation = false

						DisplayRadar(true)

						-- if messagemode == true then
						-- 	messagemode = false
						-- elseif teamchatmessagemode == true then
						-- 	teamchatmessagemode = false
						-- elseif groupchatmode == true then
						-- 	groupchatmode = false
						-- end
					end
					hideui = false
				end
					
				if phone == true then
					HideHudComponentThisFrame(7)
					HideHudComponentThisFrame(8)
					HideHudComponentThisFrame(9)
					HideHudComponentThisFrame(6)
					HideHudComponentThisFrame(19)
					HideHudAndRadarThisFrame()
					DisplayRadar(false)
				end
					
				-- ren = GetMobilePhoneRenderId()
				-- SetTextRenderId(ren)
				
				-- Everything rendered inside here will appear on your phone.
				
				-- SetTextRenderId(1) -- NOTE: 1 is default
			end
	--end
end)