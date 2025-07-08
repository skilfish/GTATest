// Footer
var business = {
    firsttime : false,
    lasttabopen: "#business-home",
    tabopen: "#business-home",
    message: {
        addedimage: null,
    },
    teamchat: {},
    dispatch: {},
    recruit: {
        id: null
    }
}

$(document).keyup(function(data) {
    if (data.which == 13) {
        if (business.tabopen == "#business-home-teamchat" && Main.openapp == "business") {
            var message = $("#business-teamchat-input").val();
            var image = messages.chat.addedimages 
        
            var okay = CheckStringLength(message)

            if (okay == false) return
        
            sendData("business:teamchat:sendmessage",{
                message: message,
                image: image
            })
            $("#business-teamchat-input").val("")
            messages.ClearImages()
        } else if (business.tabopen == "#business-home-dispatch" && Main.openapp == "business") {
            var message = $("#business-dispatch-input").val();
            var image = messages.chat.addedimages 
            var okay = CheckStringLength(message)

            if (okay == false) return
        
            sendData("business:dispatch:sendmessage",{
                message: message,
                image: image
            })
            $("#business-dispatch-input").val("");
            messages.ClearImages()
        }
    }
});

$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.app == "business" && v.task == "loadhome") {
           $("#business-home-headline").html(v.label)
            business.LoadHome(v.html, v.motd)
        }   else if (v.app == "business" && v.task == "loadfilter") {
            business.LoadFilter(v.html)
        } else if (v.app == "business" && v.task == "kickfromapp") {
            business.KickFromApp()
        } else if (v.app == "business" && v.task == "teamchat:load") {
            business.teamchat.Load(v.html)
        } else if (v.app == "business" && v.task == "teamchat:refresh") {
            business.teamchat.Refresh(v.html)
        } else if (v.app == "business" && v.task == "teamchat:addmessage") {
            business.teamchat.AddMessage(v.html, v.me)
        } else if (v.app == "business" && v.task == "teamchat:takephoto") {
            business.message.addedimage = v.url
            business.teamchat.AddPhotoNew()
        } 

        if (v.app == "business" && v.task == "dispatch:loadoverview") {
             business.dispatch.Load(v.html)
         } else if (v.app == "business" && v.task == "dispatch:reloadoverview") {
            business.dispatch.ReLoad(v.html)
        } else if (v.app == "business" && v.task == "dispatch:loadchat") {
            business.dispatch.LoadDispatch(v.html, v.accepted)
        } else if (v.app == "business" && v.task == "dispatch:addmessage") {
            business.dispatch.AddMessage(v.html, v.me)
        } else if (v.app == "messages" && v.task == "dispatch:kickfromchat") {
            business.dispatch.KickFromChat()
        } 

        // Settings
       if (v.app == "business" && v.task == "setmotd") {
            $("#business-home-motd").html(v.motd)
        }   else if (v.app == "business" && v.task == "updatejobmoney") {
            $("#business-mm-accountsaldo").html(v.amount + "$")
        } 

        // Permission
        if (v.app == "business" && v.task == "settask:recruit") {
            if (v.check == false ) $("#business-home-member-add").hide(0)
            if (v.check == true ) $("#business-home-member-add").show(0)
        }   else if (v.app == "business" && v.task == "settask:changerank") {
            if (v.check == false ) $("#business-member-managerank").hide(0)
            if (v.check == true ) $("#business-member-managerank").show(0)
        }  else if (v.app == "business" && v.task == "settask:fire") {
            if (v.check == false ) $("#business-member-fire").hide(0)
            if (v.check == true ) $("#business-member-fire").show(0)
        } else if (v.app == "business" && v.task == "settask:moneymanagement") {
            if (v.check == false ) $("#business-settings-mm").hide(0)
            if (v.check == true ) $("#business-settings-mm").show(0)
        } else if (v.app == "business" && v.task == "settask:depositmoney") {
            if (v.check == false ) $("#business-mm-deposit").hide(0)
            if (v.check == true ) $("#business-mm-deposit").show(0)
        } else if (v.app == "business" && v.task == "settask:withdrawmoney") {
            if (v.check == false ) $("#business-mm-withdraw").hide(0)
            if (v.check == true ) $("#business-mm-withdraw").show(0)
        } else if (v.app == "business" && v.task == "settask:setmotd") {
            if (v.check == false ) $("#business-settings-motd").hide(0)
            if (v.check == true ) $("#business-settings-motd").show(0)
        } else if (v.app == "business" && v.task == "settask:setjobnumber") {
            if (v.check == false ) $("#business-settings-setjobnumber").hide(0)
            if (v.check == true ) $("#business-settings-setjobnumber").show(0)
        } 
    });

  
});


// Home
business.show = function() {
    ShowHomebar()
    $("#business").animate({
        "left": "0%"
    })
    if (business.firsttime == false) {
        sendData("business:loadhome")
    }
    Main.openapp = "business"
}

business.hide = function() {
    $("#phone-homebar").hide(500)
}

business.KickFromApp = function() {
    if (Main.openapp != "business") return

    $("#phone-homebar").hide(500)
    $("#business").animate({
        "left": "100%"
    })

    $("#business-member-add").animate({
        "margin-left": "-30vh",
    }, 400)
    setTimeout(function() {
        $("#business-member-add").css({
            "display": "none",
        })
    }, 400)
    Home()

    Main.openapp = null
}

business.LoadHome = function(html, motd) {
    $("#business-home-motd").html(motd)
    $(".phone-business-member-rank").html("");
    $(".phone-business-member-rank").append(html)
    BottomSlideDown('#business-settings-input-area', 500, -70);
}

business.LoadFilter = function(html) {
    $("#business-home-filter-content").html("");
    $("#business-home-filter-content").append(html)
}



business.LoadLocales = function(lc) {

}


$(document).on('click', '#footer-business-teamchat', function() {
    // $("#business").fadeOut(1000)

    businessfooteropen("#business-home-teamchat")
    $(".business-team-content-chat > .business-message").css({
        "white-space": "nowrap",
        "overflow": "hidden"
    })
    $(".business-team-content-chat > .business-message-me").css({
        "white-space": "nowrap",
        "overflow": "hidden"
    })
    setTimeout(function(){
        $(".business-team-content-chat > .business-message").css({
            "white-space": "normal"
        })
        $(".business-team-content-chat > .business-message-me").css({
            "white-space": "normal"
        })
    }, 250)
    $('#business-teamchat-chat-content').animate({scrollTop: 9999});
});

$(document).on('click', '#footer-business-home', function() {
    businessfooteropen("#business-home")

     
    $("#footer-business-teamchat").removeClass("purplecolor")
    $("#footer-business-dispatch-overview").removeClass("purplecolor")
    $("#footer-business-settings").removeClass("purplecolor")
    $(this).addClass("purplecolor")
});


$(document).on('click', '#footer-business-dispatch-overview', function() {
    businessfooteropen("#business-dispatch-overview")

    $("#footer-business-home").removeClass("purplecolor")
    $("#footer-business-teamchat").removeClass("purplecolor")
    $("#footer-business-dispatch-overview").removeClass("purplecolor")
    $("#footer-business-settings").removeClass("purplecolor")
    $(this).addClass("purplecolor")
});

$(document).on('click', '#business-home-member-filter', function() {
    businessfooteropen("#business-home-filter")
});

$(document).on('click', '#business-home-filter-return', function() {
    businessfooteropen("#business-home")

    $("#footer-business-home").removeClass("purplecolor")
    $("#footer-business-teamchat").removeClass("purplecolor")
    $("#footer-business-dispatch-overview").removeClass("purplecolor")
    $("#footer-business-settings").removeClass("purplecolor")
    $(this).addClass("purplecolor")
});

$(document).on('click', '#footer-business-settings', function() {
    businessfooteropen("#business-settings")

    $("#footer-business-home").removeClass("purplecolor")
    $("#footer-business-teamchat").removeClass("purplecolor")
    $("#footer-business-dispatch-overview").removeClass("purplecolor")
    $("#footer-business-settings").removeClass("purplecolor")
    $(this).addClass("purplecolor")
});

function businessfooteropen(newopen) {
    if (newopen == business.tabopen) return
 
    setTimeout(function(){
        $(business.tabopen).animate({
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
        business.lasttabopen = business.tabopen 
        business.tabopen = newopen
    }, 10)

   
}

// Header
$(document).on('click', '#business-teamchat-return', function() {
    // $("#business").fadeOut(1000)
    businessfooteropen(business.lasttabopen)
});

// setInterval("myFunction()", 100);


// Teamchat
$(document).on('click', '#business-teamchat-add', function() {
    BottomSlideUp('#messages-inputarea', 500, 5);
    $(".censorlayer").fadeIn(500)
    $("#business-chat-delete").hide(0)
    Main.openapp = "business-teamchat"
});

$(document).on('click', '#business-teamchat-selection-cancel', function() {
    BottomSlideDown('#business-teamchat-selection-inputarea', 500, -70);
    $(".censorlayer").fadeOut(500)
});

$(document).on('click', '#business-teamchat-selection-inputarea-image', function() {
    BottomSlideUp('#business-teamchat-inputimageurl-area', 500, 5);
    $("#business-teamchat-selection-inputarea").fadeOut(500)
});

$(document).on('click', '#business-teamchat-urlinput-cancel', function() {
    BottomSlideDown('#business-teamchat-inputimageurl-area', 500, -70);
    $("#business-teamchat-selection-inputarea").fadeIn(0)

    $("#business-teamchat-urlinput").val("")
    business.teamchat.RemoveImageNew()
    business.teamchat.RemovePhotoNew()
    business.message.addedimage = null
});

$(document).on('click', '#business-teamchat-urlinput-back', function() {
    BottomSlideDown('#business-teamchat-inputimageurl-area', 500, -70);
    $("#business-teamchat-selection-inputarea").fadeIn(0)
});

$(document).on('click', '#business-teamchat-urlinput-submit', function() {
    BottomSlideDown('#business-teamchat-inputimageurl-area', 500, -70);
    $(".censorlayer").fadeOut(500)

    var url = $("#business-teamchat-urlinput").val()

    var okay = CheckStringLength(url)

    if (okay == false) return

    var pngcheck = CheckIfPng(url)

    if (pngcheck == false) return

    business.message.addedimage = url
    business.teamchat.AddImageNew()
    // $("#business-teamchat-selection-inputarea").fadeIn(0
});

$(document).on('click', '#business-teamchat-selection-inputarea-photo', function() {
    // BottomSlideUp('#messages-inputimageurl-area', 500, 5);
    // $("#messages-inputarea").fadeOut(500)

    sendData("business:teamchat:takephoto")
});

business.teamchat.AddPhotoNew = function() {
    if ($("#business-teamchat-selection-inputarea-image").hasClass("new")) {
        $("#business-teamchat-selection-inputarea-image").removeClass("new")
    }
    if ($("#business-teamchat-selection-inputarea-photo").hasClass("new") == false) {
        $("#business-teamchat-selection-inputarea-photo").addClass("new")
    }
   
}

business.teamchat.RemovePhotoNew = function() {
    if ($("#business-teamchat-selection-inputarea-photo").hasClass("new")) {
        $("#business-teamchat-selection-inputarea-photo").removeClass("new")
    }
}

business.teamchat.AddImageNew = function() {
    if ($("#business-teamchat-selection-inputarea-photo").hasClass("new")) {
        $("#business-teamchat-selection-inputarea-photo").removeClass("new")
    }

    if ($("#business-teamchat-selection-inputarea-image").hasClass("new") == false) {
        $("##business-teamchat-selection-inputarea-image").addClass("new")
    }
}


business.teamchat.Load = function(html) {
    // $("#business-teamchat-chat-content").detach();
    $("#business-teamchat-chat-content").html("");
    $("#business-teamchat-chat-content").append(html);
    $('#business-teamchat-chat-content').animate({scrollTop: 9999});
}

business.teamchat.Refresh = function(html) {
    $("#business-teamchat-chat-content").html("");
    $("#business-teamchat-chat-content").append(html);
    $('#business-teamchat-chat-content').animate({scrollTop: 9999});
}

// Send Message
$(document).on('click', '#business-teamchat-sendmessage', function() {
    var message = $("#business-teamchat-input").val();

    var image = messages.chat.addedimages

    var okay = CheckStringLength(message)

    if (okay == false) return

    sendData("business:teamchat:sendmessage",{
        message: message,
        image: image
    })
    $("#business-teamchat-input").val("")

    messages.ClearImages()
});

$(document).on('click', '#business-teamchat-selection-inputarea-gps', function() {

    sendData("business:teamchat:sendgps",{
 
    })
    BottomSlideDown('#business-teamchat-selection-inputarea', 500, -70);
});

$(document).on('click', '.business-message-gpscontainer-inner', function() {
    var x =$(this).data("x")
    var y = $(this).data("y")
    var z =  $(this).data("z")
    sendData("setgps",{
        x : x,
        y : y,
        z: z
    })

});

business.teamchat.AddMessage = function(html, me) {
    $("#business-teamchat-chat-content").append(html);
    if (me == "business-message-me") $('#business-teamchat-chat-content').animate({scrollTop: 9999});
}

business.teamchat.KickFromChat = function() {
    businessfooteropen("#business-dispatch-overview")
}


// Filter
function changememberfilter() {
    var offline = false
    if (document.getElementById('phone-business-filter-showoffline').checked) 
    {
        offline = true;
    } else {
        offline = false;
    }

    $(".phone-business-member-content").each(function(i) {
        var onlinestatus = $(this).data("online")
        if (onlinestatus == "0" && offline == false) {
            $(this).hide(0)
        } else {
            $(this).show(0)
        }
    });
}

function filterrank(rank_) {
    var show = false
    if (document.getElementById('phone-business-filter-rank-' +rank_).checked) 
    {
        show = true;
    } else {
        show = false;
    }
    
    $(".phone-business-member-content").each(function(i) {
        var rank = $(this).data("grade")
        if (rank == rank_ && show == false) {
            $(this).hide(0)
        } else {
            $(this).show(0)
        }
    });

    $(".phone-business-member-content-head").each(function(i) {
        var rank = $(this).data("grade")
        if (rank == rank_ && show == false) {
            $(this).hide(0)
        } else {
            $(this).show(0)
        }
    });
}

// Settings
$(document).on('click', '#business-settings-input-area-submit', function() {
    var message = $("#business-settings-input-area-input").val();
    var okay = CheckStringLength(message)

    if (okay == false) return

    sendData("business:settings:setmotd",{
        message: message
    })
    $("#business-settings-input-area-input").val("");
    BottomSlideDown('#business-settings-input-area', 500, -70);
});


$(document).on('click', '#business-settings-motd', function() {
    BottomSlideUp('#business-settings-input-area', 500, 5);
});

$(document).on('click', '#business-settings-input-area-cancel', function() {
    BottomSlideDown('#business-settings-input-area', 500, -70);
});

$(document).on('click', '#business-settings-mm', function() {
    businessfooteropen("#business-settings-moneymanagement")
});

function setjobnumber() {
    if (document.getElementById('business-settings-setjobnumber-switch').checked) {
        sendData("business:setjobnumber", { state: 1 });
    } else {
        sendData("business:setjobnumber", { state: 0 });
    };
};

// Management
$(document).on('click', '#business-member-managerank', function() {
    BottomSlideUp('#business-member-managerank-area', 500, 5);
});

$(document).on('click', '#business-member-managerank-area-cancel', function() {
    BottomSlideDown('#business-member-managerank-area', 500, -70);
});

// Disaptches
business.dispatch.Load = function(html) {
    // $("#business-teamchat-chat-content").detach();
    $("#business-dispatch-overview-container").html("");
    $("#business-dispatch-overview-container").append(html);

    var $wrapper = $('#business-dispatch-overview-container');

    $wrapper.find('.business-dispatches-overview-element').sort(function (a, b) {
        return -a.getAttribute('data-place') + +b.getAttribute('data-place');
    })
    .appendTo( $wrapper );
}

business.dispatch.ReLoad = function(html) {
    // $("#business-teamchat-chat-content").detach();
    $("#business-dispatch-overview-container").html("");

    $("#business-dispatch-overview-container").append(html);

    var $wrapper = $('#business-dispatch-overview-container');

    $wrapper.find('.business-dispatches-overview-element').sort(function (a, b) {
        return -a.getAttribute('data-place') + +b.getAttribute('data-place');
    })
    .appendTo( $wrapper );
    BottomSlideDown('#business-settings-input-area', 500, -70);
}

business.dispatch.Add = function(html) {
    // $("#business-teamchat-chat-content").detach();
    $("#business-dispatch-overview-container").prepend(html);
}

$(document).on('click', '#business-dispatch-sendmessage', function() {
    var message = $("#business-dispatch-input").val();
    
    var image = messages.chat.addedimages
    var okay = CheckStringLength(message)

    if (okay == false) return
    sendData("business:dispatch:sendmessage",{
        message: message,
        image: image
    })
    $("#business-dispatch-input").val("");
    messages.ClearImages()
});


// Dispatch
$(document).on('click', '#business-dispatch-return', function() {
    // $("#business-dispatch").animate({
    //     "margin-left": "-100%"
    // })
    BottomSlideDown('#business-dispatch-accept-area', 500, -70);

    businessfooteropen("#business-dispatch-overview")
});



business.dispatch.LoadDispatch = function(html, accepted) {
    // $("#business-dispatch").animate({
    //     "margin-left": "0%"
    // })
    businessfooteropen("#business-home-dispatch")
    BottomSlideDown('#business-settings-input-area', 500, -70);
    
    $(".business-team-content-chat > .business-message").css({
        "white-space": "nowrap",
        "overflow": "hidden"
    })
    $(".business-team-content-chat > .business-message-me").css({
        "white-space": "nowrap",
        "overflow": "hidden"
    })
    setTimeout(function(){
        $(".business-team-content-chat > .business-message").css({
            "white-space": "normal"
        })
        $(".business-team-content-chat > .business-message-me").css({
            "white-space": "normal"
        })
    }, 250)

    $("#business-dispatch-chat-content").html("");
    $("#business-dispatch-chat-content").append(html);
    $('#business-dispatch-chat-content').animate({scrollTop: 9999});

    if (accepted == 0) BottomSlideUp('#business-dispatch-accept-area', 500, 5);

}

business.dispatch.AddMessage = function(html, me) {
    $("#business-dispatch-chat-content").append(html);
    if (me == "business-message-me") $('#business-dispatch-chat-content').animate({scrollTop: 9999});
}

$(document).on('click', '.business-dispatches-overview-element', function() {
    // $("#business").fadeOut(1000)
    var number = $(this).data("number")

    sendData("business:loaddispatch", {
        number: number
    })
});

$(document).on('click', '#business-dispatch-selection-inputarea-gps', function() {

    sendData("business:dispatch:sendgps",{
 
    })
    BottomSlideDown('#business-dispatch-selection-inputarea', 500, -70);
});


$(document).on('click', '#business-dispatch-add', function() {
    BottomSlideUp('#messages-inputarea', 500, 5);
    $(".censorlayer").fadeIn(500)
    $("#business-chat-delete").show(0)
    Main.openapp = "business-dispatch"
});

$(document).on('click', '#business-dispatch-selection-cancel', function() {
    BottomSlideDown('#business-dispatch-selection-inputarea', 500, -70);
    $(".censorlayer").fadeOut(500)
});

$(document).on('click', '#business-dispatch-selection-inputarea-image', function() {
    BottomSlideUp('#business-dispatch-inputimageurl-area', 500, 5);
    $("#business-dispatch-selection-inputarea").fadeOut(500)
});

$(document).on('click', '#business-dispatch-urlinput-cancel', function() {
    BottomSlideDown('#business-dispatch-inputimageurl-area', 500, -70);
    $("#business-dispatch-selection-inputarea").fadeIn(0)
});


$(document).on('click', '#business-dispatch-urlinput-submit', function() {
    BottomSlideDown('#business-dispatch-inputimageurl-area', 500, -70);
    $(".censorlayer").fadeOut(500)
    // $("#business-teamchat-selection-inputarea").fadeIn(0
});

$(document).on('click', '#business-dispatch-accept', function() {
    // $("#business").fadeOut(1000)

    sendData("business:acceptdispatch", {

    })
    BottomSlideDown('#business-dispatch-accept-area', 500, -70)
});

$(document).on('click', '#business-dispatch-decline', function() {
    // $("#business").fadeOut(1000)

    sendData("business:deletedispatch", {

    })
    BottomSlideDown('#business-dispatch-accept-area', 500, -70)
    BottomSlideDown('#business-dispatch-selection-inputarea', 500, -70)
    businessfooteropen("#business-dispatch-overview")
});

// Money Management

$(document).on('click', '#business-mm-withdraw', function() {
   let amount = $("#business-mm-amount").val()

    sendData("business:mm:withdraw", {
        amount: amount
    })
    $("#business-mm-amount").val("")
});

$(document).on('click', '#business-mm-deposit', function() {
    let amount = $("#business-mm-amount").val()
 
     sendData("business:mm:deposit", {
         amount: amount
     })
     $("#business-mm-amount").val("")
 });

//  Member Overview 


// Home
$(document).on('click', '.phone-business-member-content', function() {
    var name = $(this).data("name")
    var number = $(this).data("number")
    var rank = $(this).data("rank")
    var source = $(this).data("source")

    $("#business-member-add").css({
        "display": "block",
        "z-index": "2"
    })
    $("#business-member-add").animate({
        "margin-left": "0vh",
    }, 400)

    $("#business-member-add-name").html(name)
    $("#business-member-add-number").html(number)
    $("#business-member-add-rank").html(rank)

    selectedid = source
    selectednumber = number
});

$(document).on('click', '#business-member-return', function() {

    $("#business-member-add").animate({
        "margin-left": "-30vh",
    }, 400)
    setTimeout(function() {
        $("#business-member-add").css({
            "display": "none",
        })
    }, 400)
});

$(document).on('click', '#business-member-add-addcontact', function() {
    currentpage = "#phone-app-contact-new"
    lastpage = "#business-member-add"

    var number = selectednumber

    $('#phone-app-contact-phonenumber').val(number)
    AppSlideIn(currentpage, lastpage)
});

$(document).on('click', '#business-member-managerank', function() {
    BottomSlideUp('#business-member-managerank-area', 500, 5);
});

$(document).on('click', '#business-member-managerank-area-submit', function() {
    var rank = $("#business-member-managerank-area-input").val();

    sendData("businessapp:updaterank", {
        id : selectedid,
        rank : rank,
    })

    BottomSlideDown('#business-member-managerank-area', 500, -70);
});

$(document).on('click', '#business-member-fire', function() {
    sendData("businessapp:fire", {
        id : selectedid
    })
});

function CheckStringLength(string) {
    if (string.length > 255) {
        Notify("stringtolong", "error")
        return false
    } else if (string.length === 0 && business.message.addedimage == null) {
        Notify("stringtoshort", "error")
        return false
    } else {
        return true
    }
}


$(document).on('click', '#business-home-member-add', function() {
    BottomSlideUp('#business-home-add-id', 500, 5);
});

$(document).on('click', '#business-home-add-id-cancel', function() {
    BottomSlideDown('#business-home-add-id', 500, -70);
});

$(document).on('click', '#business-home-add-id-submit', function() {
    let id = $("#business-home-add-id-input").val();
    if ( id == "") return

    business.recruit.id = id
    BottomSlideUp('#business-home-add-rank', 500, 5);
    BottomSlideDown('#business-home-add-id', 0, -70);
});

$(document).on('click', '#business-home-add-rank-submit', function() {
    let rank = $("#business-home-add-rank-input").val();
    if ( rank == "") return

    BottomSlideDown('#business-home-add-rank', 500, -70);

    sendData("businessapp:recruit", {
        id : business.recruit.id,
        rank : rank,
    })
    business.recruit.id = null
    $("#business-home-add-rank-input").val("");
    $("#business-home-add-id-input").val("");
});

$(document).on('click', '#business-home-add-rank-back', function() {
    BottomSlideUp('#business-home-add-id', 500, 5);
   BottomSlideDown('#business-home-add-rank', 0, -70);
});

$(document).on('click', '#business-home-add-rank-cancel', function() {
   BottomSlideDown('#business-home-add-rank', 500, -70);
   business.recruit.id = null
   $("#business-home-add-rank-input").val("");
   $("#business-home-add-id-input").val("");
});

business.teamchat.AddImageNew = function() {
    if ($("#business-teamchat-selection-inputarea-photo").hasClass("new")) {
        $("#business-teamchat-selection-inputarea-photo").removeClass("new")
    }

    if ($("#business-teamchat-selection-inputarea-image").hasClass("new") == false) {
        $("#business-teamchat-selection-inputarea-image").addClass("new")
    }
}

business.teamchat.RemoveImageNew = function() {
    if ($("#business-teamchat-selection-inputarea-image").hasClass("new")) {
        $("#business-teamchat-selection-inputarea-image").removeClass("new")
    }
}