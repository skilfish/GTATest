var battery = {
    
}

$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.app == "battery" && v.task == "update") {
            battery.update(v.width)
        } else if (v.app == "battery" && v.task == "shutdown") {
            battery.shutdown()
        } else if (v.app == "battery" && v.task == "start") {
            battery.start()
        } 



    
    })

});

battery.update = function(width) {
    $(".battery-level").animate({
        width: width + "%",
    }, 500);

    if ($(".battery-level").hasClass("empty")) $(".battery-level").removeClass("empty") 
    if ($(".battery-level").hasClass("warn")) $(".battery-level").removeClass("warn") 

    if (width > 30) {
    } else if ( width > 15 ) {
        $(".battery-level").addClass("warn") 
    } else {
        $(".battery-level").addClass("empty") 
    }
}

battery.shutdown = function() {
    $(".phone-blackscreen").show(500)
}

battery.start = function() {
    Startloadingscreen(500)
}