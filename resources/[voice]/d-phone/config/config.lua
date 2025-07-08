Keys = {
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

Config                            = {}


-- General
Config.Locale             = 'de'

Config.ESX12 = false

Config.Currency = "$"

Config.Debug = false


Config.Apps = {
    ["services"] = {
        enabled = true,
    },
    ["business"] = {
        enabled = true,
    },
    ["radio"] = {
        enabled = true,
    },
    ["camera"] = {
        enabled = true,
    },
    ["groupchat"] = {
        enabled = true,
    },
    ["twitter"] = {
        enabled = true,
    },
    ["bank"] = {
        enabled = true,
    },
    ["advertisement"] = {
        enabled = true,
    },
    ["calculator"] = {
        enabled = true,
    },
    ["djump"] = {
        enabled = true,
    },
}

-- Other Products ( disable if you dont use this )
-- https://store.deun.xyz/package/4912924
Config.Dmarket = false

-- New Product which will be released soon
Config.Bitcoin = false

-- WARNING DONT DISABLE THIS IF YOU DONT EXACTLY KNOW WHAT YOU'RE DOING
Config.AutomaticPhoneStart = true
Config.AutomaticStartingTime = 5000

Config.LoadingScreen = false

Config.NeedItem = true

-- If this is enabled you can walk while having your phone open
Config.Walking = true

Config.actioncooldown = 2000

-- If enabled then the phone will be still displayed while you're on a call
Config.EnableCallDisplay = true
Config.EnableAlwaysDisplay = false


-- Phone open command
Config.Command = false
Config.CommandText = "phone"


Config.DisplayInGameTime = false

Config.CustomNotification = false

Config.Notification = {
    ["info"] = {
        icon = "fa-solid fa-circle-info",
        label = _U("Information"),
        class = "info",
        enabled = true,
    },
    ["error"] = {
        icon = "fa-solid fa-circle-xmark",
        label = _U("Error"),
        class = "error",
        enabled = true,
    },
    ["warning"] = {
        icon = "fa-solid fa-triangle-exclamation",
        label = _U("Warning"),
        class = "warning",
        enabled = true,
    },
    ["success"] = {
        icon = "fa-solid fa-circle-check",
        label = _U("Success"),
        class = "success",
        enabled = true,
    },
    ["frqradio"] = {
        icon = "fa-solid fa-microphone-lines",
        label = _U("Radio"),
        class = "frqradio",
        enabled = true,
    },
    ["messages"] = {
        icon = "fa-solid fa-message",
        label = _U("Messages"),
        class = "frqradio",
        enabled = true,
    },
    ["business"] = {
        icon = "fa-solid fa-briefcase",
        label = _U("Business"),
        class = "frqradio",
        enabled = true,
    },
    ["photo"] = {
        icon = "fa-solid fa-camera",
        label = _U("Camera"),
        class = "info",
        enabled = true,
    },
    ["battery"] = {
        icon = "fa-solid fa-battery-full",
        label = _U("Battery"),
        class = "success",
        enabled = true,
    },
    ["broker"] = {
        icon = "fa-solid fa-arrow-trend-up",
        label = _U("Broker"),
        class = "broker",
        enabled = true,
    },
    ["groupchat"] = {
        icon = "fa solid fa-user-group",
        label = _U("Groupchat"),
        class = "groupchat",
        enabled = true,
    },
}

-- Exports Config
Config.MumbleVoipFolderName = "mumble-voip"
Config.PMAVOICEFolderName = "pma-voice"
Config.SaltychatFolderName = 'saltychat'


-- Voice Chat [only 1 can be true]
Config.TokoVoip = false
-- Requires OneSync enabled and at least the 15$ patreon subscribtion
Config.PMAVoice = false
Config.MumbleVoip = false
Config.SaltyChat = true

-- Constant Radio ( just if you have SaltyChat )
Config.ConstantRadio = true

-- Wallpaper
Config.backgroundurl = "https://cdn.discordapp.com/attachments/932234080681066528/986306688128811038/wallpaper.png"
Config.darkbackgroundurl = "https://cdn.discordapp.com/attachments/932234080681066528/986306688128811038/wallpaper.png"

Config.Wallpapers = {
    {
        name = "Whitemode",
        url = "https://cdn.discordapp.com/attachments/932234080681066528/986306688128811038/wallpaper.png"
    },
    {
        name = "Darkmode",
        url = "https://cdn.discordapp.com/attachments/932234080681066528/986306688128811038/wallpaper.png"
    },
}

-- Case
-- Standard Case
Config.Case = "./img/model1.png"
Config.Model = "iphone"

Config.Cases = {
    {
        src = "./img/model1.png",
        model = "iphone",
        name = "IPhone",
    },
    {
        src = "./img/model2.png",
        model = "samsung",
        name = "Samsung",
    },
}

-- Standard Ringtone
Config.Ringtone =  "./sound/ring.ogg"

Config.Ringtones = {
    {
        name = "Standard iPhone",
        url = "./sound/ring.ogg"
    },
}

-- Notification colors
Config.IncommingCallColor = "#2ca79b"

-- Call app
-- https://docs.fivem.net/docs/game-references/controls/
Config.Openkey = 288
Config.AcceptCall = 20
Config.EndCall = 73

-- If you dont want to use an second key then simple set it to nil
Config.SecondKey = 21

--[[
Phone Numer
Nummer will be like [prefix-number]
The number will be randomly generated between the lower and higher number
]] 


Config.Prefix = true
-- Ignore this if Prefix = false
Config.numBaseSpace = ""

Config.LowerPrefix = 100
Config.HigherPrefix = 999

Config.LowerNumber = 1000
Config.HigherNumber = 9999

Config.hourplus = 0
Config.hourplusnew = 2

-- Radio
-- These Jobs have access to the blocked channels 
    -- The animation source code is aswell in the animation.lua
Config.Broadcastkey = 137 -- Caps Lock
Config.RadioAnimation = true
Config.NeedRadioItem = nil

Config.Radio = {
    increaseamount = 1,
    decreaseamount = -1,
    secondkey = "LEFTSHIFT",
    increasehotkey = "G",
    decreasehotkey = "H"
}

Config.Access = {
    {
        frequenz = 1,
        job = "police",
        joblabel = "LSPD"
    },
    {
        frequenz = 1,
        job = "ambulance",
        joblabel = "Ambulance"
    },

    {
        frequenz = 2,
        job = "police",
        joblabel = "LSPD"
    },
    {
        frequenz = 3,
        job = "ambulance",
        joblabel = "Ambulance"
    },
    {
        frequenz = 4,
        job = "ambulance",
        joblabel = "Ambulance"
    },
    {
        frequenz = 422,
        job = "ambulance",
        joblabel = "Ambulance"
    },
}

Config.Whitelistnumbers = {
    "911",
    "912"
}

-- Businesapp
Config.EnablePlayerManagement = true

Config.Bosspermissions = {
    ["police"] = {
        ["boss"] = {
            ["recruit"] = true,
            ["changerank"] = true,
            ["fire"] = true,
            ["moneymanagement"] = true,
            ["depositmoney"] = true,
            ["withdrawmoney"] = true,
            ["setmotd"] = true,
            ["setjobnumber"] = true,
        },
        ["officer"] = {
            ["recruit"] = false,
            ["changerank"] = false,
            ["fire"] = false,
            ["moneymanagement"] = false,
            ["depositmoney"] = false,
            ["withdrawmoney"] = false,
            ["setmotd"] = false,
            ["setjobnumber"] = true,
        },
    },
    ["ambulance"] = {
        ["boss"] = {
            ["recruit"] = true,
            ["changerank"] = true,
            ["fire"] = true,
            ["moneymanagement"] = true,
            ["depositmoney"] = true,
            ["withdrawmoney"] = true,
            ["setmotd"] = true,
            ["setjobnumber"] = true,
        },
    },
    ["standard"] = {
        ["standard"] = {
            ["recruit"] = false,
            ["changerank"] = false,
            ["fire"] = false,
            ["moneymanagement"] = false,
            ["depositmoney"] = false,
            ["withdrawmoney"] = false,
            ["setmotd"] = false,
            ["setjobnumber"] = true,
        },
    },
}

Config.Battery = {
    -- Looses battery every x minutes
    -- true / false
    Enable = false,
    BatteryLooseMinutes = math.random(1, 3),
    BatteryLooseAmount = math.random(1, 3),
    PowerBankChargingTime = math.random(5, 10),
    PowerBankMinutes = math.random(1, 2),
    PowerBankAmount = math.random(8, 13),
}


Config.Messages = {
    DeleteMessages = true,
    MessageLimit = 200
}

-- Waiting Times
-- If you're server is slow, make this higher
Config.FirstTimeSQL = 500
Config.MysqlWaitingTime = 500
Config.UserDataWaitingTime = 500
Config.RecentMessagesWait = 100
Config.RecentBusinessMessagesWait = 100
Config.BusinessAppWaitingTime = 1000
Config.setjobwaitingtime = 5000

-- ESX Events DONT TOUCH THIS IF YOU DONT EXACTLY KNOW WHAT THESE DOES
Config.esxgetSharedObjectevent = 'skylineistback:getSharedObject'
Config.esxprefix = "skyline:"
Config.esxprefix2 = "esx_"

Config.Antispam = 5000

-- Database Table
Config.oxmysql = false
Config.JobsTable = "jobs"
Config.UsersTable = "users"

-- Ignore this, so leave it on false
Config.okokbanking = false

