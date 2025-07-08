var groupchat = {
    overview: {},
    new: {
        name: null,
        image: null
    },
    chat : {},
    settings : {
        open: null
    },
    isadmin : true,

    tabopen: "#groupchat-overview",
    lasttabopen: null,
    loaded: false,
    opencontact : {
        number : null
    },
}

$(document).keyup(function(data) {
    if (data.which == 13) {
        if (groupchat.tabopen == "#groupchat-chat" && Main.openapp == "groupchat") {
            messages.SendMessage()
        } 
    }
});

$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.app == "groupchat" && v.task == "opentab") {
            if (groupchat.opencontact.number != null) {
                $("#groupchat-member").animate({
                    "margin-left": "-30vh",
                }, 400)
                setTimeout(function() {
                    $("#groupchat-member").css({
                        "display": "none",
                        "z-index": "2",
                    })
                }, 400)
                groupchat.opencontact.number = null
            }

            groupchat.open(v.tab)
        }

        if (v.app == "groupchat" && v.task == "overview:load") {
            groupchat.overview.load(v.html)
        } else if (v.app == "groupchat" && v.task == "loadcontacts") {
            groupchat.loadcontacts(v.html)
        }

        if (v.app == "groupchat" && v.task == "setpermission") {
            groupchat.isadmin = v.state
        } 

    
        if (v.app == "groupchat" && v.task == "chat:load") {
            groupchat.chat.load(v.html, v.label, v.image)
        } else if (v.app == "groupchat" && v.task == "chat:add") {
            groupchat.chat.add(v.html)
        } 

        if (v.app == "groupchat" && v.task == "settings:loadparticipatans") {
            groupchat.settings.loadparticipatans(v.html)
        } else if (v.app == "groupchat" && v.task == "settings:change") {
            groupchat.settings.setimage(v.image)
            groupchat.settings.setlabel(v.label)
        } 
    })
});

// General
groupchat.show = function() {
    ShowHomebar()
    $("#groupchat").animate({
        "left": "0%"
    })
    Main.openapp = "groupchat"

    if (groupchat.loaded == false) {
        sendData("groupchat:loadoverview")
    }
    
}

groupchat.hide = function() {
    $("#phone-homebar").hide(500)
}

groupchat.open = function(newopen) {
    if (newopen == groupchat.tabopen) return
    
    setTimeout(function(){
        $(groupchat.tabopen).animate({
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
        groupchat.lasttabopen = groupchat.tabopen 
        groupchat.tabopen = newopen
    }, 10)

   
}

// Overview
groupchat.overview.load = function(html) {
    $("#groupchat-overview-container").html("")
    $("#groupchat-overview-container").html(html)

    groupchat.loaded = true
    var $wrapper = $('#groupchat-overview-container');

    $wrapper.find('.groupchat-overview-element').sort(function (a, b) {
        return -a.getAttribute('data-place') + +b.getAttribute('data-place');
    })
    .appendTo( $wrapper );

    var skr = ["groupchat-new-name", "groupchat-new-imageinput", "groupchat-chat-input", "groupchat-settings-inputarea-urlinput"];
    DontWalk(skr)
}

$(document).on('click', '.groupchat-overview-element', function() {
    var group = $(this).data("group")

    sendData("groupchat:load", {
        group: group
    })
});

$(document).on('click', '.groupchat-overview-new', function() {
    groupchat.open("#groupchat-new")
});

// New
$(document).on('click', '#groupchat-new-next', function() {
    var groupname = $("#groupchat-new-name").val()
    var groupimage = $("#groupchat-new-imageinput").val()

    groupchat.new.name = groupname
    groupchat.new.image = groupimage

    if (groupname != "") {
        // groupchat.open("#groupchat-settings-contact")
        if (groupimage == "")  groupchat.new.image = "https://cdn-icons-png.flaticon.com/512/166/166258.png"
        sendData("groupchat:new:loadcontact")
    }
});

groupchat.loadcontacts = function(html) {
    $(".groupchat-settings-contact-elements").html("")
    $(".groupchat-settings-contact-elements").html(html)
    groupchat.open("#groupchat-settings-contact")
}

$(document).on('click', '#groupchat-new-testimage', function() {
    var url = $("#groupchat-new-imageinput").val()

    var okay = CheckStringLength(url)

    if (okay == false) return

    $("#groupchat-new-image").attr("src", url);
});

// Chat
groupchat.chat.load = function(html, label, image) {
    $("#groupchat-chat-content").html("")
    $("#groupchat-chat-content").html(html)
    $('#groupchat-chat-content').animate({scrollTop: 9999});
    var height = 44.5
    if (Main.openapp == "groupchat") height=40.5

    $("#" + Main.openapp +"-chat-content").css({
        "height": height + "vh",
    })

    groupchat.open("#groupchat-chat")

    groupchat.settings.setimage(image)
    groupchat.settings.setlabel(label)
}

groupchat.chat.add = function(html) {
    $("#groupchat-chat-content").append(html)

}

$(document).on('click', '.groupchat-chat-opensettings', function() {
    groupchat.open("#groupchat-settings")
});

$(document).on('click', '#groupchat-chat-add', function() {
    BottomSlideUp('#messages-inputarea', 500, 5);
    $(".censorlayer").fadeIn(500)
    messages.plusmenu.openapp = "groupapp"
    $("#business-chat-delete").hide(0)
});

$(document).on('click', '#groupchat-chat-add', function() {
    BottomSlideUp('#messages-inputarea', 500, 5);
    $(".censorlayer").fadeIn(500)
    messages.plusmenu.openapp = "groupapp"
});

$(document).on('click', '#groupchat-chat-sendmessage', function() {
    messages.SendMessage()
});

$(document).on('click', '#groupchat-chat-return', function() {
    groupchat.open("#groupchat-overview")
});

// Settings
$(document).on('click', '#groupchat-settings-return', function() {
    groupchat.open("#groupchat-chat")
    groupchat.settings.inputarea(0)
    groupchat.settings.selectionarea(0)
});

groupchat.settings.loadparticipatans = function(html) {
    $(".groupchat-settings-participants").html("")
    $(".groupchat-settings-participants").html(html)

    var $wrapper = $('.groupchat-settings-participants');

$('.groupchat-setting-element').sort(function(a, b) {
    if (a.textContent < b.textContent) {
        return -1;
    } else {
        return 1;
    }
    }).appendTo($wrapper);

    $wrapper.find('.groupchat-setting-element').sort(function (a, b) {
        return -a.getAttribute('data-contact') + +b.getAttribute('data-contact');
    })

    .appendTo( $wrapper );

    $wrapper.find('.groupchat-setting-element').sort(function (a, b) {
        return -a.getAttribute('data-admin') + +b.getAttribute('data-admin');
    })

    .appendTo( $wrapper );



    $wrapper.find('.groupchat-setting-element').sort(function (a, b) {
        return -a.getAttribute('data-me') + +b.getAttribute('data-me');
    })

    .appendTo( $wrapper );


}

groupchat.settings.setimage = function(imageurl) {
    $("#groupchat-settings-image").attr("src", imageurl);
    $("#groupchat-chat-image").attr("src", imageurl);
}

groupchat.settings.setlabel = function(label) {
    $("#groupchat-settings-name").html(label);
    $("#groupchat-chat-name").html(label);
}

$(document).on('click', '#groupchat-settings-group-photo', function() {
    groupchat.settings.selectionarea(1)
    groupchat.settings.open = "photo"
    $("#groupchat-settings-inputarea-headline").html(
        '<i class="fa-solid fa-image"></i> ENTER IMAGE URL'
    )
    $("#groupchat-settings-inputarea-back").show(0)
});


$(document).on('click', '#groupchat-settings-img-photo', function() {
    groupchat.settings.selectionarea(1)
    groupchat.settings.open = "photo"
    $("#groupchat-settings-inputarea-headline").html(
        '<i class="fa-solid fa-image"></i> ENTER IMAGE URL'
    )
    $("#groupchat-settings-inputarea-back").show(0)
});

$(document).on('click', '#groupchat-settings-group-name', function() {
    groupchat.settings.inputarea(1)
    groupchat.settings.open = "name"
    $("#groupchat-settings-inputarea-headline").html(
        '<i class="fa-solid fa-signature"></i>  ENTER NAME'
    )
    $("#groupchat-settings-inputarea-back").hide(0)
});

$(document).on('click', '#groupchat-settings-selectionarea-cancel', function() {
    groupchat.settings.selectionarea(0)
});

$(document).on('click', '#business-teamchat-selection-inputarea-image', function() {
    groupchat.settings.selectionarea(0)
    groupchat.settings.inputarea(1)
});

$(document).on('click', '#business-teamchat-selection-inputarea-image', function() {
    groupchat.settings.selectionarea(0)
    groupchat.settings.inputarea(1)
});

$(document).on('click', '#groupchat-settings-inputarea-back', function() {
    groupchat.settings.inputarea(0)
    groupchat.settings.selectionarea(1)
});

$(document).on('click', '#groupchat-settings-inputarea-cancel', function() {
    groupchat.settings.inputarea(0)
    $("#groupchat-settings-inputarea-urlinput").val("")
});

$(document).on('click', '#groupchat-settings-inputarea-submit', function() {
    groupchat.settings.inputarea(0)
    var input = $("#groupchat-settings-inputarea-urlinput").val()

    var okay = CheckStringLength(input)

    if (okay == false) return

    if (groupchat.settings.open == "photo") {
        groupchat.settings.setimage(input)
        sendData("groupchat:change", {
            name: input,
            type: "image"
        })

    } else if (groupchat.settings.open == "name") {
        groupchat.settings.setlabel(input)
        sendData("groupchat:change", {
            name: input,
            type: "label"
        })
    }


    $("#groupchat-settings-inputarea-urlinput").val("")
});

$(document).on('click', '#groupchat-settings-selectionarea-photo', function() {
    sendData("groupchat:takephoto:change")
    groupchat.settings.selectionarea(0)
});

groupchat.settings.selectionarea = function(type) {
    if (type == 1) {
        BottomSlideUp('#groupchat-settings-selectionarea', 500, 5);
    } else {
        BottomSlideDown('#groupchat-settings-selectionarea', 500, -70);
    }
}

groupchat.settings.inputarea = function(type) {
    if (type == 1) {
        BottomSlideUp('#groupchat-settings-inputarea', 500, 5);
    } else {
        BottomSlideDown('#groupchat-settings-inputarea', 500, -70);
    }
}

groupchat.settings.userselectionarea = function(type) {
    if (type == 1) {
        BottomSlideUp('#groupchat-settings-user-selectionarea', 500, 5);
    } else {
        BottomSlideDown('#groupchat-settings-user-selectionarea', 500, -70);
    }
}

$(document).on('click', '#groupchat-settings-group-addmember', function() {
    sendData("groupchat:new:addcontact")
    // groupchat.open("#groupchat-settings-contact")
});

$(document).on('click', '#groupchat-settings-conctact-return', function() {
    groupchat.open("#groupchat-overview")
});

$(document).on('click', '#groupchat-settings-contact-save', function() {
    var member = []
    $(".groupchat-settings-checkbox").each(function() {
        if ($(this).is(':checked')) {
            var number = $(this).parent().data("number")

            member.push({
                number:number.toString(),
                admin: 0,
            })
        }
        console.log(member)
    })

    if (groupchat.lasttabopen == "#groupchat-new") {
        sendData("groupchat:create", {
            name: groupchat.new.name,
            image: groupchat.new.image,
            member: member
        })
        groupchat.open("#groupchat-overview")
    } else {
        sendData("groupchat:save", {
            member: member
        })
        
    }
    
});

$(document).on('click', '#groupchat-settings-group-leave', function() {
    sendData("groupchat:leave")
});


$(document).on('click', '.groupchat-setting-element', function() {
    var name = $(this).data("name");
    var number = $(this).data("number");
    var admin = $(this).data("admin");
    var contact = $(this).data("contact");
    var me = $(this).data("me");


    selectednumber = number
    selectedname = name
    if (me == "1") return

    $("#groupchat-member").css({
        "display": "block",
        "z-index": "9",
    })
    $("#groupchat-member").animate({
        "margin-left": "0vh",
    }, 400)

    $("#groupchat-member-name").html(name)
    $("#groupchat-member-number").html(number)

    var rank = "Member"
    if (admin == "1") rank = "Admin"
    console.log(typeof(admin))
    if (groupchat.isadmin == true && admin == "0" ) {
        $("#groupchat-member-admin").show(0)
        $("#groupchat-member-unadmin").hide(0)
        $("#groupchat-member-kick").show(0)
    } else if (groupchat.isadmin == true && admin == "1" ) {
        $("#groupchat-member-admin").hide(0)
        $("#groupchat-member-unadmin").show(0)
        $("#groupchat-member-kick").show(0)
    } else {
        $("#groupchat-member-admin").hide(0)
        $("#groupchat-member-unadmin").hide(0)
        $("#groupchat-member-kick").hide(0)
    }
    
    $("#groupchat-member-rank").html(rank)

    if (contact == "1") {
        $(".groupchat-member-contact").hide(0)
        $(".groupchat-member-addcontact").addClass("redcolor")
    } else {
        $(".groupchat-member-contact").show(0)
        $(".groupchat-member-addcontact").removeClass("redcolor")
    }

    groupchat.opencontact.number = number
});

$(document).on('click', '#groupchat-member-return', function() {

    $("#groupchat-member").animate({
        "margin-left": "-30vh",
    }, 400)
    setTimeout(function() {
        $("#groupchat-member").css({
            "display": "none",
            "z-index": "2",
        })
    }, 400)
});

$(document).on('click', '#groupchat-member-add-addcontact', function() {
    currentpage = "#phone-app-contact-new"
    lastpage = "#groupchat-member"

    var number = selectednumber

    $('#phone-app-contact-phonenumber').val(number)
    AppSlideIn(currentpage, lastpage)
    $("#phone-app-contact-new").css({
        "z-index": "2",
    })
});

$(document).on('click', '#groupchat-member-admin', function() {
    sendData("groupchat:admin",{
        number: groupchat.opencontact.number
    })
});

$(document).on('click', '#groupchat-member-unadmin', function() {
    sendData("groupchat:unadmin",{
        number: groupchat.opencontact.number
    })
});

$(document).on('click', '#groupchat-member-kick', function() {
    sendData("groupchat:kick", {
        number: groupchat.opencontact.number
    })
});

$(document).on('click', '#groupchat-member-add-message', function() {
    $("#groupchat-member").animate({
        "margin-left": "-30vh",
    }, 400)
    $("#groupchat").animate({
        left: "-100%"
    }, 400)
    setTimeout(function() {
        $("#groupchat-member").css({
            "display": "none",
            "z-index": "2",
        })
    }, 400)

    sendData("loadmessage", {
        number: selectednumber,
        contact: selectedname
    });
    lastcontact = 'message'
});