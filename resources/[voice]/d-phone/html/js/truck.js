var truck = {
    firsttime : false,
    lasttabopen: "#truck-home",
    tabopen: "#truck-home",
    home: {},
    trucks: {},
    info: {},
    history: {},
    activ: {},
}   

$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.app == "truck" && v.task == "activeicon") {
            $("#truckicon").show(0)
        } else if (v.app == "truck" && v.task == "hideicon") {
            $("#truckicon").hide(0)
        } 

        if (v.app == "truck" && v.task == "home:load") {
            truck.home.load(v.earnings, v.level, v.xp, v.progressbarwidth, v.rpname, v.earningsl, v.levell, v.xpl)
        } 

        if (v.app == "truck" && v.task == "trucks:load") {
            truck.trucks.load(v.html)
        } 

        if (v.app == "truck" && v.task == "info:load") {
            truck.info.load(v.html)
        } 
    
        if (v.app == "truck" && v.task == "history:load") {
            truck.history.load(v.html)
            print("load histroy")
        } else if (v.app == "truck" && v.task == "history:add") {
            truck.history.add(v.html)
        } 
    
        if (v.app == "truck" && v.task == "activ:show") {
            truck.activ.show(v.truck, v.route, v.packages, v.earnings, v.routel, v.packagesl, v.earningsl)
        } else if (v.app == "truck" && v.task == "activ:abort") {
            truck.activ.abort()
        } 

    })



});

truck.show = function() {
    $("#phone-homebar").show(500)
    $("#truck").animate({
        "left": "0%"
    })
    Main.openapp = "truck"
}

truck.open = function(newopen) {
    if (newopen == truck.tabopen) return
    
    setTimeout(function(){
        $(truck.tabopen).animate({
            "margin-left": "100%"
        })
        $(newopen).css({
            "margin-left": "0%",
            "margin-right": "100%"
        })
        setTimeout(function(){
            $(newopen).animate({
                "margin-right": "0%"
            }, 500)
            
        }, 10)
        truck.lasttabopen = truck.tabopen 
        truck.tabopen = newopen
    }, 10)

   
}

// home
$(document).on('click', '#truck-home-start', function() {
    truck.open("#truck-route-select")
});

truck.home.load = function (earnings, level, xp, progressbarwidth, rpname, earningsl, levell, xpl) {
    $("#truck-home-earnings").html(earnings)
    $("#truck-home-level").html(level)
    $("#truck-home-xp").html(xp)
    $("#truck-home-earningsl").html(earningsl)
    $("#truck-home-levell").html(levell)
    $("#truck-home-xpl").html(xpl)
    $("#truck-home-rpname").html(rpname)
    $("#truck-home-innerprogressbar").css("width", progressbarwidth + "%")
    
}

$(document).on('click', '#truck-home-info', function() {
    truck.open("#truck-info")
});

$(document).on('click', '#truck-home-history', function() {
    truck.open("#truck-history")
});

// route
$(document).on('click', '#truck-route-select-return', function() {
    truck.open("#truck-home")
});

$(document).on('click', '.truck-route', function() {
    var route = $(this).data('route')
    
    sendData("truck:loadroute", {
        route: route
    })
});


// truck
$(document).on('click', '#truck-select-return', function() {
    truck.open("#truck-route-select")
})

truck.trucks.load = function(html) {
    $('.truck-elements').html("")
    $(".truck-elements").html(html)

    truck.open("#truck-select")
}

$(document).on('click', '.truck-select-element', function() {
    var truck = $(this).data("truck")
    var route = $(this).data("route")
    var packages = $(this).data("packages")
    var earnings = $(this).data("earnings")

    sendData("truck:startjob", {
        truck: truck,
        route: route,
        packages: packages,
        earnings: earnings,
    })


})
// Info
$(document).on('click', '#truck-info-return', function() {
    truck.open("#truck-home")
});

truck.info.load = function(html) {
    $('.info-elements').html("")
    $(".info-elements").html(html)
}

// history
$(document).on('click', '#truck-history-return', function() {
    truck.open("#truck-home")
});

truck.history.load = function(html) {
    $('.history-elements').html("")
    $(".history-elements").html(html)
    print("history loaded")
}

truck.history.add = function(html) {
    $(".history-elements").prepend(html)
}

// activ
truck.activ.show = function (truck_, route, packages, earnings, routel, packagesl, earningsl) {
    $("#truck-activ-routel").html(routel)
    $("#truck-activ-route").html(route)
    $("#truck-activ-packagesl").html(packagesl)
    $("#truck-activ-packages").html(packages)
    $("#truck-activ-earningsl").html(earningsl)
    $("#truck-activ-earnings").html(earnings)
    
    truck.open("#truck-activ")
}

$(document).on('click', '#truck-activ-waypoint-truck', function() {
    sendData("truck:setwaypoint:truck")
});


$(document).on('click', '#truck-activ-waypoint-goal', function() {
    sendData("truck:setwaypoint:goal")
});

$(document).on('click', '#truck-activ-abort', function() {
    sendData("truck:abort")
});

truck.activ.abort = function() {
    print("test")
    truck.open("#truck-home")
}