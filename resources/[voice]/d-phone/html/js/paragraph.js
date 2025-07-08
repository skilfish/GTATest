paragraph = {}

$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.app == "paragraph" && v.task == "load") {
            paragraph.Load(v.headline, v.html)
            
            if (v.showback == true) {
                console.log("showback")
                $("#paragraph-back").show(500)
            } else {
                $("#paragraph-back").hide(500)
            }
        } 

    
    })



});

paragraph.show = function() {
    ShowHomebar()
    $("#paragraph").css({
        "z-index": "2"
    })
    $("#paragraph").animate({
        "left": "0%"
    })

    Main.openapp = "paragraph"

}

paragraph.Load = function(headline, html) {
    $("#paragraph-headline").html(headline)
    $("#paragraph-home-container").html(html)
    $("#paragraphicon").show(0)
    paragraph.animate()
}

paragraph.animate = function() {
    $("#paragraph-home-container").css({
        "width": "0%",
    })
    $("#paragraph-home-container").animate({
        "width": "100%",
    })
}

$(document).on('click', '.paragraph-element', function() {
    var id = $(this).data("id")

    sendData("paragraph:loadnew",{
       id: id
    })
});

$(document).on('click', '#paragraph-back', function() {
    sendData("paragraph:back")
});