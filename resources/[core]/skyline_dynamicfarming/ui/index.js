var currentO = ""

document.addEventListener("DOMContentLoaded", function(event) {
    $("#container").hide();
    $("#counter_text").hide();
});

window.addEventListener('message', function(e) {    
    var event = e.data


    if (event.action == "fish") {
        currentO = "fish"
        $("#container").fadeIn(300);
        $("#label_1").html("Möchtest du <b style=color:red;>Fisch</b> verkaufen?");
        $("#label_2").html("Ein Sicherrer Verkauf, denn der Kurs hat kaum Schwankungen. ");
        $("#label_3").html("Verkaufe zu einem guten Kurs, gute Kurse sind mit grünen Zahlen makiert.");


        $(".icongegen_Class").attr("src" , "img/fish.png")

        if(event.price > 1 && event.price < 5) {
            $("#endprodukt").html("<span style=color:red;>" + event.price + "$");
        }else if(event.price > 4 && event.price < 8) {
            $("#endprodukt").html("<span style=color:yellow;>" + event.price + "$");
        }else {
            $("#endprodukt").html("<span style=color:green;>" + event.price + "$");
        }
    };

    if (event.action == "weed") {
        currentO = "weed"
        $("#container").fadeIn(300);
        $("#label_1").html("Möchtest du <b style=color:aqua;>Weed</b> verkaufen?");
        $("#label_2").html("Ein Sicherrer Verkauf, denn der Kurs hat kaum Schwankungen. ");
        $("#label_3").html("Verkaufe zu einem guten Kurs, gute Kurse sind mit grünen Zahlen makiert.");


        $(".icongegen_Class").attr("src" , "img/weed.png")

        if(event.price > 1 && event.price < 1000) {
            $("#endprodukt").html("<span style=color:red;>" + event.price + "$");
        }else if(event.price > 1000 && event.price < 1500) {
            $("#endprodukt").html("<span style=color:yellow;>" + event.price + "$");
        }else {
            $("#endprodukt").html("<span style=color:green;>" + event.price + "$");
        }
    };

    if (event.action == "koks") {
        currentO = "koks"
        $("#container").fadeIn(300);
        $("#label_1").html("Möchtest du <b style=color:aqua;>Koks</b> verkaufen?");
        $("#label_2").html("Ein risikoreicher Verkauf, denn der Kurs hat veiele Schwankungen. ");
        $("#label_3").html("Verkaufe zu einem guten Kurs, gute Kurse sind mit grünen Zahlen makiert.");


        $(".icongegen_Class").attr("src" , "img/koks.png")

        if(event.price > 3000 && event.price < 6000) {
            $("#endprodukt").html("<span style=color:red;>" + event.price + "$");
        }else if(event.price > 6000 && event.price < 8000) {
            $("#endprodukt").html("<span style=color:yellow;>" + event.price + "$");
        }else {
            $("#endprodukt").html("<span style=color:green;>" + event.price + "$");
        }
    };

    if (event.action == "pf") {
        currentO = "pf"
        $("#container").fadeIn(300);
        $("#label_1").html("Möchtest du <b style=color:aqua;>Pfandflaschen</b> verkaufen?");
        $("#label_2").html("Ein Sicherrer Verkauf, denn der Kurs hat kaum Schwankungen. ");
        $("#label_3").html("Verkaufe zu einem guten Kurs, gute Kurse sind mit grünen Zahlen makiert.");


        $(".icongegen_Class").attr("src" , "img/pf.png")

        if(event.price > 1 && event.price < 30) {
            $("#endprodukt").html("<span style=color:red;>" + event.price + "$");
        }else if(event.price > 30 && event.price < 50) {
            $("#endprodukt").html("<span style=color:yellow;>" + event.price + "$");
        }else {
            $("#endprodukt").html("<span style=color:green;>" + event.price + "$");
        }
    };

    if (event.action == "tabak") {
        currentO = "tabak"
        $("#container").fadeIn(300);
        $("#label_1").html("Möchtest du <b style=color:aqua;>Kippen</b> verkaufen?");
        $("#label_2").html("Ein Sicherrer Verkauf, denn der Kurs hat kaum Schwankungen. ");
        $("#label_3").html("Verkaufe zu einem guten Kurs, gute Kurse sind mit grünen Zahlen makiert.");


        $(".icongegen_Class").attr("src" , "img/tabak.png")

        if(event.price > 50 && event.price < 70) {
            $("#endprodukt").html("<span style=color:red;>" + event.price + "$");
        }else if(event.price > 70 && event.price < 80) {
            $("#endprodukt").html("<span style=color:yellow;>" + event.price + "$");
        }else {
            $("#endprodukt").html("<span style=color:green;>" + event.price + "$");
        }
    };

    if (event.action == "meth") {
        currentO = "meth"
        $("#container").fadeIn(300);
        $("#label_1").html("Möchtest du <b style=color:aqua;>Meth</b> verkaufen?");
        $("#label_2").html("Ein Sicherrer Verkauf, denn der Kurs hat kaum Schwankungen. ");
        $("#label_3").html("Verkaufe zu einem guten Kurs, gute Kurse sind mit grünen Zahlen makiert.");


        $(".icongegen_Class").attr("src" , "img/meth.png")

        if(event.price > 4000 && event.price < 5000) {
            $("#endprodukt").html("<span style=color:red;>" + event.price + "$");
        }else if(event.price > 5000 && event.price < 6000) {
            $("#endprodukt").html("<span style=color:yellow;>" + event.price + "$");
        }else {
            $("#endprodukt").html("<span style=color:green;>" + event.price + "$");
        }
    };


  

    if(event.action == "hideText") {
        $("#counter_text").hide();
    };

    if(event.action == "updateText") {
        $("#counter_text").html("");
        $("#counter_text").show();
        $("#counter_text").html(event.text);
    };
});

$(document).keyup(function (e) {
    if (e.key === "Escape") {
        $("#container").fadeOut(300);
        $.post('https://skyline_dynamicfarming/close');
    }
});


function buy() {
    switch(currentO) {
        case"meth":
        $("#container").fadeOut(300);
        $.post('https://skyline_dynamicfarming/meth');
        break;
        case"tabak":
        $("#container").fadeOut(300);
        $.post('https://skyline_dynamicfarming/tabak');
        break;
        case"koks":
        $("#container").fadeOut(300);
        $.post('https://skyline_dynamicfarming/koks');
        break;
        case"weed":
        $("#container").fadeOut(300);
        $.post('https://skyline_dynamicfarming/weed');
        break;
        case"pf":
        $("#container").fadeOut(300);
        $.post('https://skyline_dynamicfarming/pf');
        break;
    };
}