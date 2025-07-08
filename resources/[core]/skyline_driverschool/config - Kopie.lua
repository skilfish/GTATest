Config = {}
Blips = {}
Lang = {}
Noti = {}
Vehicles = {}
TheoricalInstructor = {}
PracticeInstructor = {}
TheoricalUserPosition = {}

--############################ GENERAL CONFIGURATION #############################
Config.Mysql = "mysql-async" -- oxmysql, mysql-async or ghmattisql
Config.ESXTrigger = "skylineistback:getSharedObject"
Config.licenseAprice = 2500
Config.licenseBprice = 5500
Config.licenseCprice = 10000
Config.theoricalTotalQuestions = 9
Config.correctAnswersNeeded = 5
Config.licenseNameMoto = 'bike'
Config.licenseNameCar = 'drive'
Config.licenseNameTruck = 'truck'
Config.CheckPointsAmount = 9
Config.TTSLanguage = 'DE'
Config.MaxErrorsPractice = 5
Config.highwaySpeed = 120
Config.urbanSpeed = 60
Config.interUrbanSpeed = 90


--################################## VEHICLES #####################################
Vehicles.moto = 'double'
Vehicles.car = 'blista'
Vehicles.truck = 'phantom'
Vehicles.spawn = {
    x = 214.31,
    y = 388.7,
    z = 106.41,
    heading = 170.57,
}

--################################ INSTRUCTORS ####################################
PracticeInstructor.npc = 'csb_trafficwarden'
PracticeInstructor.x = 229.88
PracticeInstructor.y = 383.39
PracticeInstructor.z = 105.44
PracticeInstructor.heading = 74.91

TheoricalInstructor.npc = 'csb_reporter'
TheoricalInstructor.x = 228.47
TheoricalInstructor.y = 374.04
TheoricalInstructor.z = 105.11
TheoricalInstructor.heading = 157.45

TheoricalUserPosition.x = 228.21
TheoricalUserPosition.y = 370.75
TheoricalUserPosition.z = 105.91
TheoricalUserPosition.heading = 339.68

--############################### NOTIFICATIONS ###################################

function notifications(notitype, message, time)
    --Change this trigger for your notification system keeping the variables
    TriggerEvent('skyline_notify:Alert', message, time, notitype)
end

--Notifications types:
Noti.info = 'success'
Noti.check = 'long'
Noti.error = 'error'

--Notification time:
Noti.time = 3500

--################################### BLIPS #######################################
Blips.active = true
Blips.coord = {x = 232.09, y = 365.34, z = 106.05}
Blips.blip = 227
Blips.blipColor = 31
Blips.blipScale = 0.9
Blips.blipText = "Fahrschule"


--################################### MARKERS #####################################
Marker = {
    x = 231.56, 
    y = 369.53, 
    z = 106.11,
    mtype = 23,
    --RGB COLOR:
    r = 245,
    g = 14,
    b = 70
}


--################################ PRACTICE ROUTE #################################
Routes = {    
[1] = {
    x = 44.42,
    y = -159.91,
    z = 53.85,
    text = ""
},
[2] = {
    x = 645.39,
    y = -294.65,
    z = 42.29,
    text = ""
},
[3] = {
    x = 2427.21,
    y = 2889.86,
    z = 47.83,
    text = ""
},
[4] = {
    x = 1486.3,
    y = 2741.52,
    z = 36.38,
    text = ""
},
[5] = {
    x = 311.02,
    y = 2574.02,
    z = 42.65,
    text = ""
},
[6] = {
    x = 594.26,
    y = 2186.18,
    z = 68.44,
    text = ""
},
[7] = {
    x = -96.34,
    y = 1852.26,
    z = 197.63,
    text = ""
},
[8] = {
    x = 248.81,
    y = 346.91,
    z = 104.17,
    text = ""
},
[9] = {
    x = 209.67,
    y = 389.72,
    z = 105.56,
    text = ""
}
}

--############################# THEORICAL QUESTIONS ###############################
Questions = {
    ['Warum kann Überholen auch auf übersichtlichen und geraden Fahrbahnen gefährlich sein?'] = {
        [1] = 'Weil der Überholweg kürzer ist als angenommen.',
        [2] = 'Weil der Gegenverkehr langsamer fährt als angenommen.',
        [3] = 'Weil der Gegenverkehr schneller fährt als angenommen.',
        ['correct'] = 3,
        ['index'] = 1
    },
    ['Wo ist das Überholen verboten?'] = {
        [1] = 'Wo die Verkehrslage klar ist.',
        [2] = 'In allen Einbahnstraßen.',
        [3] = 'Wo der Gegenverkehr behindert werden könnte.',
        ['correct'] = 3,
        ['index'] = 2
    },
    ['Warum kann die Fahrtüchtigkeit bereits durch geringe Mengen Alkohol beeinträchtigt werden?'] = {
        [1] = 'Weil sich das Sichtfeld der Augen verkleinert.',
        [2] = 'Weil sich das räumliche Sehen verbessert.',
        [3] = 'Weil sich die Reaktionszeit verkürzt.',
        ['correct'] = 1,
        ['index'] = 3
    },
    ['Welche Vorteile bietet ein Antiblockiersystem (ABS)?'] = {
        [1] = 'Selbst bei starkem Bremsen bleibt die Lenkfähigkeit nicht erhalten.',
        [2] = 'Kurven können wesentlich schneller durchfahren werden.',
        [3] = 'Beim Bremsen wird das Blockieren der Räder verhindert.',
        ['correct'] = 3,
        ['index'] = 4
    },
    ['Wann dürfen Sie Nebelschlussleuchten einschalten?'] = {
        [1] = 'Wenn durch Nebel die Sichtweite weniger als 50 m beträgt.',
        [2] = 'Wenn durch starken Regen die Sicht behindert wird.',
        [3] = 'Wenn durch Nebel die Sichtweite 100 m beträgt.',
        ['correct'] = 1,
        ['index'] = 5
    },
    ['Was müssen Sie beim Überqueren einer Vorfahrtstraße beachten?'] = {
        [1] = 'Döner essen.',
        [2] = 'In den Himmel gucken.',
        [3] = 'Ich beachte die Geschwindigkeit und Entfernung des Querverkehrs.',
        ['correct'] = 3,
        ['index'] = 6
    },
    ['Sie fahren bei Dunkelheit mit Fernlicht. Wann müssen Sie abblenden?'] = {
        [1] = 'Wenn ich eine Straße mit durchgehender, ausreichender Beleuchtung befahre.',
        [2] = 'Wenn ich vor einem Bahnübergang warten muss und andere nicht blende.',
        [3] = 'Wenn Fußgänger in gleicher Richtung vorausgehen.',
        ['correct'] = 1,
        ['index'] = 7
    },
    ['Welche Möglichkeit der Ladungssicherung gibt es in einem Pkw?'] = {
        [1] = 'Das Gepäcknetz',
        [2] = 'Den Fußraum',
        [3] = 'Den Kofferraum',
        ['correct'] = 1,
        ['index'] = 8
    },
    ['Sie befinden sich in einem Kreisverkehr. Was ist zu beachten?'] = {
        [1] = 'Im Kreisverkehr ist das Halten auf der Fahrbahn erlaubt.',
        [2] = 'Das Verlassen des Kreises muss durch Blinken angezeigt werden.',
        [3] = 'Eine Mittelinsel darf immer befahren/überfahren werden.',
        ['correct'] = 2,
        ['index'] = 9
    },

}

--############################# LANGUAGE ###############################

Lang.theoricalneeded = "Du musst vorher die Theorie machen!"
Lang.returnvehicule = "Steig wieder ins Auto! Sonst wird der Test beendet!"
Lang.testcanceled = "Der Test wurde beendet."
Lang.approved = "Du hast bestanden."
Lang.suspended = "Du bist durchgefallen, du kannst es gerne erneut probieren."
Lang.passed = "Du hast diesen Test schon gemacht."
Lang.enter = "Drücke ~r~E~w~ um die ~g~Fahrschule~w~ zu betreten"