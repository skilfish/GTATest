document.addEventListener('DOMContentLoaded' , function () {
    $("#container").hide();
});


window.addEventListener('message' , function(event) {
    var data = event.data;

    if(data.display == true) {
        $("#container").fadeIn(100);
    }

    if(data.display == false) {
        $("#container").fadeOut(100);
    }
});

