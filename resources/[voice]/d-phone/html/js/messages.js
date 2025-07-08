var messages = {
    firsttime : false,
    openchat : null,
    loaded: false,
    overview: {
        firsttime : false,
    },
    chat: {
        firsttime : false,
        addedimage : null,
        addedimages : [],
    },
    tabopen : "#messages-overview",
    plusmenu: {
        openapp: "messages",
    }

}

$(document).keyup(function(data) {
    if (data.which == 13) {
        if (messages.tabopen == "#messages-chat" && Main.openapp == "messages") {
            messages.SendMessage()
        } 
    }
});

$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.app == "messages" && v.task == "overview:load") {
            messages.overview.Load(v.html)
        } 

        if (v.app == "messages" && v.task == "chat:load") {
            messages.chat.Load(v.html)
        } else if (v.app == "messages" && v.task == "chat:addmessage") {
            messages.chat.AddMessage(v.html, v.me)
        } else if (v.app == "messages" && v.task == "chat:kickfromchat") {
            messages.chat.KickFromChat()
        } else if (v.app == "messages" && v.task == "chat:takephoto") {
            // BottomSlideUp('#messages-inputarea', 500, 5);
            messages.AddImageNew(v.url)
        } 

        // Search bar
        if ( messages.loaded == true) {
            var messaveoverviewsearchBar = document.forms['messages-searchbar'].querySelector('input');
            messaveoverviewsearchBar.addEventListener('keyup', function(e) {
            const term = e.target.value.toLocaleLowerCase();
            var notAvailable = document.getElementById('notAvailable');
            //   $("#titleMain").toggle($('input').val().length == 0);
            var hasResults = false;
    
            $(".messages-overview-element").each(function() {
                    if ($(this).data("number").toString().toLowerCase().includes(term.toString()) || $(this).data("label").toString().toLowerCase().includes(term.toString())) {
                        $(this).show(0);
                    } else {
                        $(this).hide(0);
                    }
                })
            });
        }



    
    })



});



// General
messages.show = function() {
    ShowHomebar()
    $("#messages").css({
        "z-index": "2"
    })
    $("#messages").animate({
        "left": "0%"
    })

    Main.openapp = "messages"

    if (messages.loaded == false) {
        sendData("messages:load")
    }
    
}

messages.hide = function() {
    $("#phone-homebar").hide(500)
}

messages.open = function(newopen) {
    if (newopen == messages.tabopen) return
    
    setTimeout(function(){
        $(messages.tabopen).animate({
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
        messages.lasttabopen = messages.tabopen 
        messages.tabopen = newopen
    }, 10)

   
}

// Overview
messages.overview.Load = function(html) {
    // $("#messages-chat-content").detach();
    $("#messages-overview-container").html("");
    $("#messages-overview-container").append(html);
    messages.loaded = true
    var $wrapper = $('#messages-overview-container');

    $wrapper.find('.messages-overview-element').sort(function (a, b) {
        return -a.getAttribute('data-place') + +b.getAttribute('data-place');
    })
    .appendTo( $wrapper );

    var skr = ["messages-overview-searchbar"];
    DontWalk(skr)
}

$(document).on('click', '.messages-overview-element', function() {
    // $("#business").fadeOut(1000)
    var number = $(this).data("number")

    sendData("messages:loadchat", {
        number: number
    })
});

// Chat
$(document).on('click', '#message-chat-return', function() {
    // $("#business-dispatch").animate({
    //     "margin-left": "-100%"
    // })
    document.getElementById("messages").style.zIndex = "1"; 
    messages.open("#messages-overview")
    sendData("messages:resetopenchat")
});

$(document).on('click', '#messages-chat-sendmessage', function() {
    messages.SendMessage()
});

messages.SendMessage = function() {
    var message = $("#"+ Main.openapp +"-chat-input").val();    

    var okay = CheckStringLength(message)

    if (okay == false) return

    var image = messages.chat.addedimages

    sendData(Main.openapp + ":chat:sendmessage",{
        message: message,
        image: image
    })
    $("#"+ Main.openapp +"-chat-input").val("")

    messages.ClearImages()
}

$(document).on('click', '#messages-chat-sendgps', function() {

    if (Main.openapp == "business-teamchat") {
        sendData("business:teamchat:sendgps",{
 
        })
    } else  if (Main.openapp == "business-dispatch") {
        sendData("business:dispatch:sendgps",{
 
        })
    } else {
        sendData(Main.openapp + ":chat:sendgps")
    }
    
    BottomSlideDown('#messages-inputarea', 500, -70);
});

messages.chat.Load = function(html) {
    $("#messages-chat-content").html("");
    $("#messages-chat-content").append(html);
    $('#messages-chat-content').animate({scrollTop: 9999});
    messages.show()
    messages.open("#messages-chat")

    var $wrapper = $('#messages-chat-content');

    $wrapper.find('.messages-overview-element').sort(function (a, b) {
        return -a.getAttribute('data-place') + +b.getAttribute('data-place');
    })
    .appendTo( $wrapper );

    var skr = ["messages-chat-input", "messages-urlinput"];
    DontWalk(skr)
    Main.openapp = "messages"
}


messages.chat.AddMessage = function(html, me) {
    $("#messages-chat-content").append(html);
    if (me == "business-message-me") {
        $('#messages-chat-content').animate({scrollTop: 9999});
    } else {


    }
}

messages.chat.KickFromChat = function() {
    messages.open("#messages-overview")
}

// Menu
$(document).on('click', '#messages-chat-add', function() {
    BottomSlideUp('#messages-inputarea', 500, 5);
    $(".censorlayer").fadeIn(500)
    $("#business-chat-delete").show(0)
});

$(document).on('click', '#business-chat-delete', function() {
    BottomSlideDown('#messages-inputarea', 500, -70);
    $(".censorlayer").fadeOut(500)
    if (Main.openapp == "messages") {
        sendData("messages:deletechat")
    } else {
        sendData("business:deletedispatch", {

        })
        businessfooteropen("#business-dispatch-overview")
    }
});

$(document).on('click', '#messages-inputarea', function() {
    BottomSlideDown('#messages-inputarea', 500, -70);
    $(".censorlayer").fadeOut(500)
});

$(document).on('click', '#messages-inputarea-image', function() {
    BottomSlideUp('#messages-inputimageurl-area', 500, 5);
    $("#messages-inputarea").fadeOut(500)
});

$(document).on('click', '#messages-inputarea-photo', function() {
    // BottomSlideUp('#messages-inputimageurl-area', 500, 5);
    // $("#messages-inputarea").fadeOut(500)

    sendData("messages:chat:takephoto")
});

$(document).on('click', '#messages-urlinput-cancel', function() {
    messages.chat.addedimage = null
    messages.RemoveImageNew()
    messages.RemovePhotoNew()
    BottomSlideDown('#messages-inputimageurl-area', 500, -70);
    $("#messages-inputarea").fadeIn(0)
});

$(document).on('click', '#messages-urlinput-back', function() {
    BottomSlideDown('#messages-inputimageurl-area', 500, -70);
    $("#messages-inputarea").fadeIn(0)
});

$(document).on('click', '#messages-urlinput-submit', function() {
    var imageurl = $("#messages-urlinput").val()

    var okay = CheckStringLength(imageurl)

    if (okay == false) return

    var pngcheck = CheckIfPng(imageurl)

    if (pngcheck == false) return

    messages.AddImageNew(imageurl)
    // $("#messages-urlinput").val(" ")
    BottomSlideDown('#messages-inputimageurl-area', 500, -70);
    $(".censorlayer").fadeOut(500)
    // $("#business-teamchat-selection-inputarea").fadeIn(0
});

function CheckIfPng(url) {
    if (url.includes("png") == true || url.includes("jpeg") == true || url.includes("jpg") == true || url.includes("gif") == true) {
        return true
    } else {
        Notify("hastobepng", "error")
        return false
    }
}

messages.AddPhotoNew = function() {
    if ($("#messages-inputarea-image").hasClass("new")) {
        $("#messages-inputarea-image").removeClass("new")
    }
    if ($("#messages-inputarea-photo").hasClass("new") == false) {
        $("#messages-inputarea-photo").addClass("new")
    }
   
}

messages.RemovePhotoNew = function() {
    if ($("#messages-inputarea-photo").hasClass("new")) {
        $("#messages-inputarea-photo").removeClass("new")
    }
}


messages.AddImageNew = function(url) {
    // messages.chat.addedimage = url
    // print(Main.openapp)

    console.log(Main.openapp)
    var height = 44.5
    if (Main.openapp == "groupchat") height=40.5

    if (messages.chat.addedimages.length == 0) {
        height -= 7
        $("#" + Main.openapp +"-chat-content").animate({
            "height": height + "vh",
        })
        $("#" + Main.openapp +"-chat-imagearea").animate({
            "height": "7vh",
        })

        
    } else if (messages.chat.addedimages.length >= 2) {
        height -= 8
        $("#" + Main.openapp +"-chat-content").animate({
            "height": height + "vh",
        })
        $("#" + Main.openapp +"-chat-imagearea").animate({
            "height": "8vh",
        })
    }
    
    messages.chat.addedimages.push(url)
    console.log(messages.chat.addedimages)
    var String = '   <div class="message-chat-image-area-element" data-position="' +  (messages.chat.addedimages.length - 1) +'"><div class="delete-element" id="message-chat-image-area-element-delete"><i class="fa-solid fa-xmark"></i></div><img class="image" src="' + url + '"></div>'

    $("#" + Main.openapp +"-chat-imagearea").append(String)

    var position2 = 0
    $(".message-chat-image-area-element").each(function() {
        $(this).data("position", position2) 
        position2 += 1
    })
}

$(document).on('click', '#message-chat-image-area-element-delete', function() {
    var position = $(this).parent().data('position');

    messages.RemoveImageNew(position)
});

messages.RemoveImageNew = function(position) {
    messages.chat.addedimages.splice(position, 1)
    $(".message-chat-image-area-element").each(function() {
        if ($(this).data("position") == position) {
            $(this).fadeOut(500)
            setTimeout(function(){
                $(this).remove()
            }, 500)
        }
    })

    var position2 = 0
    $(".message-chat-image-area-element").each(function() {
        $(this).data("position", position2)
        position2 += 1
    })
    var height = 44.5
    if (Main.openapp == "groupchat") height=40.5

    if (messages.chat.addedimages.length == 0) {
        $("#" + Main.openapp +"-chat-content").animate({
            "height": height + "vh",
        })
        $("#" + Main.openapp +"-chat-imagearea").animate({
            "height": "0vh",
        })
  
    } else if (messages.chat.addedimages.length < 3 && messages.chat.addedimages.length > 0) {
        height -= 7
        $("#" + Main.openapp +"-chat-content").animate({
            "height": height + "vh",
        })
        $("#" + Main.openapp +"-chat-imagearea").animate({
            "height": "7vh",
        })
    }
}

messages.ClearImages = function() {
    messages.chat.addedimages = []
    $(".message-chat-image-area-element").each(function() {
        $(this).remove()
    })
    $("#" + Main.openapp +"-chat-imagearea").animate({
        "height": "0vh",
    })

    var height = 44.5
    if (Main.openapp == "groupchat") height=40.5

    $("#" + Main.openapp +"-chat-content").animate({
        "height": height + "vh",
    })

    $('#' + Main.openapp + '-chat-content').animate({scrollTop: 9999});
}

// Image
$(document).on('click', '.business-message-image', function() {
    var image = $(this).attr('src');
    $(".image-preview").fadeIn(500)

    document.getElementById("image-preview-image").src=image;

});

$(document).on('click', '#image-preview-close', function() {
    $(".image-preview").fadeOut(500)
});

DontWalk = function(skr) {
    skr.forEach(function(item, index, array) {
        var dontwalk = document.getElementById(item);

        dontwalk.addEventListener('mousedown', (event) => {
            sendData("SetNuiFocusKeepInputFalse")
        }, true);
        
        dontwalk.addEventListener('focus', (event) => {
            sendData("SetNuiFocusKeepInputFalse")
        }, true);
            
        dontwalk.addEventListener('blur', (event) => {
            sendData("SetNuiFocusKeepInputTrue")
            }, true);
        });
}