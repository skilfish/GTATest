window.addEventListener("DOMContentLoaded" , function() {
    $("body").hide();
});

window.addEventListener("message" , function(event) {
    var data = event.data; 

    var status = data.status; 
    var kills = data.plinks;
    var deaths = data.prechts; 
    var kd = data.bombe;

 

    if(kd.toString().length == 1) {
        $("#kd").text(kd);
        $("#kd").css("right" , "3.7%");
        $("#kd").css("top" , "15%");
    }else if(kd.toString().length == 4) {
        $("#kd").text(kd);
        $("#kd").css("right" , "1.8%");
        $("#kd").css("top" , "15%");
    }else if(kd.toString().length == 5) {
        $("#kd").text(kd);
        $("#kd").css("right" , "1.6%");
        $("#kd").css("top" , "15%");
    }else {
        $("#kd").text(kd);
        $("#kd").css("right" , "2.6%");
        $("#kd").css("top" , "14.9%");
    }



    
    if(kills.toString().length == 1) {
        $("#kills").text(kills);
        $("#kills").css("right" , "2.6%");
        $("#kills").css("top" , "6%");
        $("#kills").css("font-size" , "210%");
    }else if(kills.toString().length == 3) {
        $("#kills").text(kills);
        $("#kills").css("right" , "1.2%");
        $("#kills").css("top" , "6%");
        $("#kills").css("font-size" , "210%");
     }else if(kills.toString().length == 4) {
        $("#kills").text(kills);
        $("#kills").css("right" , "0.5%");
        $("#kills").css("top" , "6%");
        $("#kills").css("font-size" , "210%");
     }else if(kills.toString().length == 5) {
        $("#kills").text(kills);
        $("#kills").css("right" , "0.5%");
        $("#kills").css("top" , "6.2%");
        $("#kills").css("font-size" , "170%");
     }else if(kills.toString().length == 6) {
        $("#kills").text(kills);
        $("#kills").css("right" , "0.4%");
        $("#kills").css("top" , "6.4%");
        $("#kills").css("font-size" , "150%");
    }else {
        $("#kills").text(kills);
        $("#kills").css("right" , "1.8%");
        $("#kills").css("top" , "6%");
        $("#kills").css("font-size" , "210%");
    }

    if(deaths.toString().length == 1) {
        $("#deaths").text(deaths);
        $("#deaths").css("right" , "2.6%");
        $("#deaths").css("top" , "10.4%");
        $("#deaths").css("font-size" , "210%");
    }else if(deaths.toString().length == 3) {
        $("#deaths").text(deaths);
        $("#deaths").css("right" , "1.2%");
        $("#deaths").css("top" , "10.4%");
        $("#deaths").css("font-size" , "210%");
     }else if(deaths.toString().length == 4) {
        $("#deaths").text(deaths);
        $("#deaths").css("right" , "0.5%");
        $("#deaths").css("top" , "10.4%");
        $("#deaths").css("font-size" , "210%");
     }else if(deaths.toString().length == 5) {
        $("#deaths").text(deaths);
        $("#deaths").css("right" , "0.5%");
        $("#deaths").css("top" , "10.6%");
        $("#deaths").css("font-size" , "170%");
     }else if(deaths.toString().length == 6) {
        $("#deaths").text(deaths);
        $("#deaths").css("right" , "0.4%");
        $("#deaths").css("top" , "10.8%");
        $("#deaths").css("font-size" , "150%");
    }else {
        $("#deaths").text(deaths);
        $("#deaths").css("right" , "1.8%");
        $("#deaths").css("top" , "10.4%");
        $("#deaths").css("font-size" , "210%");
    }

    
    if(status) {
        $("body").show();
    }else {
        $("body").hide();
    }

});
