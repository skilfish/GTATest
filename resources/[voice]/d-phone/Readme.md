<IMPORTANT>
Join my Discord and read the messages in the #verify-your-payment channel
You received your transactionid in the email of tebex.

Discord Link  > https://discord.gg/tngc5yN6mf

<INSTALLATION>
1. Drag it in your resource folder 
2. add this in your server.cfg
 start d-phone
3. insert the sql.sql in your database
4. Replace this to <esx_ambulancejob> > <client> > <main.lua>

Search for SendDistressSignal() and replace it with this

```lua
function SendDistressSignal()
	TriggerEvent("d-phone:client:message:senddispatch", "Unconscious person", "ambulance")
	TriggerEvent("d-notification", "Service Message sended", 5000,  "success")
end
```

Pay attention that you really replace "yourambulancejoblabel" in the function

5. GO in your Database and set the jobs which you want to have an businessapp

if hasapp = 1 then the job will have the app.
If onlyboss = 1 and hasapp = 1 then only the boss will have the app
if handyservice = 1 then it will be shown in the service app
if number = 1 then the service doenst have a own number. Simple change it to the number you want


If you want to replace a locale you need to change it in the config but also in the html > js > locales.js
There are some locales in the js > locales folder

6. If you dont have an item called "phone", create one in your database

7. Open server > suser.lua and remove the 
--[[

]]

From the correct Version.
e.g. if youre using ESX 1.2 change this
```lua
-- ESX 1.2
--[[
ESX.RegisterCommand('sca', 'user', function(xPlayer, args, showError)
    TriggerClientEvent("d-phone:client:acceptsharecontact", xPlayer.source)
  end)
  
  ESX.RegisterCommand('scd', 'user', function(xPlayer, args, showError)
    TriggerClientEvent("d-phone:client:declinesharecontact", xPlayer.source)
  end)
  ]]
  ```
  to
```lua
ESX.RegisterCommand('sca', 'user', function(xPlayer, args, showError)
    TriggerClientEvent("d-phone:client:acceptsharecontact", xPlayer.source)
  end)
  
  ESX.RegisterCommand('scd', 'user', function(xPlayer, args, showError)
    TriggerClientEvent("d-phone:client:declinesharecontact", xPlayer.source)
  end)
  ```

  8. Make sure to install screenshot basic
  https://github.com/citizenfx/screenshot-basic

<Support>
If there are any bugs then report these on my Discord > https://discord.gg/tngc5yN6mf

 <RIGHTS>
 You are not allowed to sell this script. 
 CREATOR: deun.xyz


 <DOCS>

  <ShowPhone Event>

  Client
  ```lua
    TriggerEvent("d-phone:client:openphone")
  ```

  Server
  ```lua
    TriggerClientEvent("d-phone:client:openphone", source)
  ```
  
  <ClosePhone Event>

  Client
  ```lua
    TriggerEvent("d-phone:client:close")
  ```

  Server
  ```lua
    TriggerClientEvent("d-phone:client:close", source)
  ```

 <LoadUserData Event>

  Client
  ```lua
    TriggerServerEvent("d-phone:server:loaduserdata", GetPlayerServerId(PlayerId()))
  ```

  Server
  ```lua
    TriggerEvent("d-phone:server:loaduserdata", source)
  ```

 <Notification Event>

  Client
  ```lua
    TriggerEvent("d-notification", stringtext, intlength, stringtheme)
  ```

  Server
  ```lua
    TriggerClientEvent("d-notification", source, stringtext, intlength, stringtheme)
  ```
  

  <ChangeNumber Event>

  Client
  ```lua
    TriggerEvent("d-phone:client:changenumber", stringnumber)
  ```

  Server
  ```lua
    TriggerClientEvent("d-phone:client:changenumber", source, stringnumber)
  ```


  <AddContact Event>

  Client
  ```lua
    TriggerEvent("d-phone:client:addcontact", stringname, stringnumber)
  ```

  Server
  ```lua
    TriggerClientEvent("d-phone:client:addcontact", source, stringname, stringnumber)
  ```

   <Dispatch Event>

  Client
  ```lua
        local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local position = {x = coords.x, y = coords.y, z = coords.z}

TriggerEvent("d-phone:client:message:senddispatch",,message, numberorjoblabel, 0, 1, position, "1")
  ```

  Server
  ```lua
    TriggerClientEvent("d-phone:client:message:senddispatch", source,message, numberorjoblabel, 0, 1, position, "1")
  ```


   <AnonymDispatch Event>

  Client
  ```lua
        local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local position = {x = coords.x, y = coords.y, z = coords.z}

    TriggerServerEvent("d-phone:server:sendanonymservicemessage", source, message, receiver, 1, position, 0)
  ```

  Server
  ```lua
    local position = {x = 100, y = 100, z = 100}

    TriggerEvent("d-phone:server:sendanonymservicemessage", source, message, receiver, 1, position, 0)
  ```

  <SetJobNumber Event>

  Client
  ```lua
    local source = GetPlayerServerId(PlayerId())
    TriggerServerEvent("business:setjobnumber", source, jobname)
  ```

  Server
  ```lua

    TriggerEvent("business:setjobnumber", source, jobname)
  ```

  <SendMessage Event>
  Server
  ```lua

    TriggerEvent('messages:chat:sendmessage', source, message, sender, receiver, image, gps, contactname)
  ```



function SendDistressSignal()
	TriggerEvent("d-phone:client:message:senddispatch", "Bewusstlose Person", "ambulance")
	TriggerEvent("d-notification", "Dispatch wurde gesendet", 5000,  "success")
end

