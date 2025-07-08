Services = {
    selected: {
        name: null,
        label: null,
        number: null,
    },
    loaded: false,
}

$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.app == "services" && v.task == "load") {
            Services.Load(v.html)
            print("Service | Load Html")
        }   
    });

});

Services.show = function() {
    $("#phone-homebar").show(500)
    $("#service").animate({
        "left": "0%"
    })
    $("#service-page").css({
        "display": "none",
        "margin-left": "-30vh",
    })
    Main.openapp = "services"
}

Services.Load = function(html) {
    if (Services.loaded == true) return

    $("#service-home").append(html)
    print("Service | Append")
    Services.loaded = true
}

$(document).on('click', '.phone-service-element', function() {
    var name = $(this).data("name")
    var number = $(this).data("number")
    var label = $(this).data("label")
    Services.selected.name = name
    Services.selected.number = number
    Services.selected.label = label
    $("#service-page").css({
        "display": "block",
        "z-index": "2",
    })
    $("#service-page").animate({
        "margin-left": "0vh",
    }, 400)


    if ( number == label ){
        if ($("#service-page-call").hasClass("purplecolor")) {
            $("#service-page-call").removeClass("purplecolor") 
            $("#service-page-call").addClass("redcolor") 
        } 
        number = label
    } else {
        if ($("#service-page-call").hasClass("redcolor")) $("#service-page-call").removeClass("redcolor") 
        if ($("#service-page-call").hasClass("purplecolor") == false) $("#service-page-call").addClass("purplecolor")         
    }

    $("#service-page-label").html(label)
    $("#service-page-number").html(number)

    // selectedid = source
    // selectednumber = number
});

$(document).on('click', '#service-return', function() {

    $("#service-page").animate({
        "margin-left": "-30vh",
    }, 400)
    setTimeout(function() {
        $("#service-page").css({
            "display": "none",
        })
    }, 400)
});

Services.Servicereturn = function() {
    $("#service-page").animate({
        "margin-left": "-30vh",
    }, 400)
    setTimeout(function() {
        $("#service-page").css({
            "display": "none",
        })
    }, 400)
}

$(document).on('click', '#service-page-call', function() {
    var number = Services.selected.number
    var label = Services.selected.label
    if (number != label) {
        Startcall(number, label)
        Services.Servicereturn();
    } else {
        Notify("nojobnumber", "error")
    }

});

$(document).on('click', '#service-page-message', function() {
    var number = Services.selected.name

    sendData("loadmessage", {
        number: number
    });
    Services.Servicereturn();
});

$(document).on('click', '#service-page-add', function() {
    var number = Services.selected.number

    currentpage = "#phone-app-contact-new"
    lastpage = "#service-page"

    $('#phone-app-contact-phonenumber').val(number)
    AppSlideIn(currentpage, lastpage)
});

$(document).on('click', '#service-page-sendlocation', function() {
    var number = Services.selected.name

    sendData("sendgps", {
        number: number
    });
    sendData("loadmessage", {
        number: number
    });
    Services.Servicereturn();
});