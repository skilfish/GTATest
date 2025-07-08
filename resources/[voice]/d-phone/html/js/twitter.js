let lastopen = null
let tweetimage = null
let firsttime = false
let twitteraccount = null

$(function() {

    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.openTwitter == true) {

        } else if (v.RegisterAccount) {
            firsttime = true;
            $('.phone-twitter').fadeIn(500);
            $('.phone-tweet').hide();
            $('.phone-twitter-firsttime').show();
        } else if (v.Accountsuccess) {
            firsttime = false;
            $('.phone-twitter-firsttime').hide();
        } else if (v.loadtwitter) {
            twitteraccount = v.account;
            CloseAllTwitter();
            LoadTweets(v.html)
            LoadSettings(twitteraccount)
        } else if (v.refreshtwitter) {
            twitteraccount = v.account;
            RefreshTweets(v.html)
        } else if (v.updatelikes) {
            UpdateLikes(v.id, v.likes)
        } else if (v.showlikedicons) {
            ShowLikedIcons(v.likedtweets)
        }
    });
});



function CloseAllTwitter() {
    $(".phone-tweets").hide();
    $(".phone-twitter-settings").hide();
    $(".phone-twitter-newtweet").hide();
    $(".phone-twitter-newpb").hide();
    $(".phone-twitter-name").hide();
    $(".phone-twitter-image").hide();
};

function CloseLastTwitterTab() {
    if (lastopen == "addimage") {
        $(".phone-twitter-image").fadeOut(500);
    } else if (lastopen == "editpb") {
        $(".phone-twitter-newpb").fadeOut(500);
    } else if (lastopen == "editname") {
        $(".phone-twitter-name").fadeOut(500);
    } else if (lastopen == "editftname") {
        $(".phone-twitter-firsttimename").fadeOut(500);
    } else if (lastopen == "editftid") {
        $(".phone-twitter-firsttimeid").fadeOut(500);
    } else if (lastopen == "editftavatar") {
        $(".phone-twitter-ftavatar").fadeOut(500);
    }
}

// Exit 
$(document).on('click', '.ptw-exiticon', function() {
    CloseLastTwitterTab();
});

// Footer Home
$(document).on('click', '#ptf-home', function() {
    if (firsttime == false) {
        sendData("twitter:loadhome")
    }
});

// Footer Newtweet
$(document).on('click', '#ptf-newtweet', function() {
    if (firsttime == false) {
        CloseAllTwitter();
        $(".phone-twitter-newtweet").fadeIn(500);
    }
});

// Footer Settings
$(document).on('click', '#ptf-settings', function() {
    if (firsttime == false) {
        CloseAllTwitter();
        $(".phone-twitter-settings").fadeIn(500);
    }
});

// Add Image to Tweet
$(document).on('click', '.ptw-submitzone-icon', function() {
    $(".phone-twitter-image").fadeIn(500);
    lastopen = "addimage"
});

//  Edit Avatar
$(document).on('click', '.phone-twitter-settings-avataredit', function() {
    $(".phone-twitter-newpb").fadeIn(500);
    lastopen = "editpb"
});

$(document).on('click', '#ptw-pbsubmit', function() {
    let avatar = $('#ptw-pbinput').val();
    let message1 = $('#ptw-pbinput').val().toLowerCase();

    if (message1.indexOf('script') > -1 ||  message1.includes("<audio") == true || message1.includes("</audio") == true || message1.includes("html") == true || message1.includes("iframe") == true || message1.includes("src") == true || message1.includes("div") == true || message1.includes("div") == true || message1.includes("mp4") == true || message1.includes("<") == true || message1.includes(">") == true ) {
        sendData("notification", { text: 'Nice try d:^)', length: 5000 })
    } else {
        if (avatar.includes("png") == true || avatar.includes("jpeg") == true || avatar.includes("jpg") == true || avatar.includes("gif") == true) {
            sendData("twitter:changepb", { avatar: avatar })
            $('.phone-twitter-settings-avatar').css("background-image", "url(" + avatar + ")");
            $(".phone-twitter-newpb").fadeOut(500);
        } else {
            if (locale == "de") {
                $("#phone-constant-radio").html(localede.avatarerror);
            } else {
                $("#phone-constant-radio").html(locale.avatarerror);
            }
            
        }
    }


});

// Edit Username
$(document).on('click', '.twitter-edit-username', function() {
    $(".phone-twitter-name").fadeIn(500);
    lastopen = "editname"
});

// Submit Username
$(document).on('click', '#ptw-usernamesubmit', function() {
    let username = $('#ptw-username').val();
    let message1 = $('#ptw-username').val().toLowerCase();

    if (message1.indexOf('script') > -1 ||  message1.indexOf('http') > -1 || message1.indexOf('www') > -1 || message1.includes("<audio") == true || message1.includes("</audio") == true || message1.includes("html") == true || message1.includes("iframe") == true || message1.includes("img") == true || message1.includes("src") == true || message1.includes("div") == true || message1.includes("image") == true  || message1.includes("div") == true || message1.includes("mp4") == true || message1.includes("<") == true || message1.includes(">") == true ) {
        sendData("notification", { text: 'Nice try d:^)', length: 5000 })
    } else {
        if (username.length < 16 && username.length > 3) {
            sendData("twitter:updateusername", { username: username })
            $("#twitter-username").html(username)
            $(".phone-twitter-name").fadeOut(500);
        } else {
            if (locale == "de") {
                $("#phone-constant-radio").html(localede.usernameerror);
            } else {
                $("#phone-constant-radio").html(locale.usernameerror);
            }
        }
    }

});

// First time avatar
$(document).on('click', '.phone-twitter-firsttime-avataredit', function() {
    $(".phone-twitter-ftavatar").fadeIn(500);
    lastopen = "editftavatar"
});

$(document).on('click', '#ptw-ftavatarsubmit', function() {
    let avatar = $('#ptw-ftavatarurl').val();
    let message1 = $('#ptw-ftavatarurl').val().toLowerCase();

    if (message1.indexOf('script') > -1 ||  message1.includes("<audio") == true || message1.includes("</audio") == true || message1.includes("html") == true || message1.includes("iframe") == true || message1.includes("src") == true || message1.includes("div") == true || message1.includes("div") == true || message1.includes("mp4") == true || message1.includes("<") == true || message1.includes(">") == true ) {
        sendData("notification", { text: 'Nice try d:^)', length: 5000 })
    } else {
        if (avatar.includes("png") == true || avatar.includes("jpeg") == true || avatar.includes("jpg") == true || avatar.includes("gif") == true) {
            $('.phone-twitter-firsttime-avatar').css("background-image", "url(" + avatar + ")");
            $('.phone-twitter-firsttime-avatar').data("url", avatar)
            $(".phone-twitter-ftavatar ").fadeOut(500);
        } else {
            if (locale == "de") {
                $("#phone-constant-radio").html(localede.avatarerror);
            } else {
                $("#phone-constant-radio").html(locale.avatarerror);
            }
        }
    }
});


// First time username
$(document).on('click', '.twitter-edit-ftusername', function() {
    $(".phone-twitter-firsttimename").fadeIn(500);
    lastopen = "editftname"
});

$(document).on('click', '#ptw-firsttimeusername', function() {
    let username = $('#ptw-ftusername').val();
    let message1 = $('#ptw-ftusername').val().toLowerCase();

    if (message1.indexOf('script') > -1 ||  message1.indexOf('http') > -1 || message1.indexOf('www') > -1 || message1.includes("<audio") == true || message1.includes("</audio") == true || message1.includes("html") == true || message1.includes("iframe") == true || message1.includes("img") == true || message1.includes("src") == true || message1.includes("div") == true || message1.includes("image") == true  || message1.includes("div") == true || message1.includes("mp4") == true || message1.includes("<") == true || message1.includes(">") == true ) {
        sendData("notification", { text: 'Nice try d:^)', length: 5000 })
    } else {
        if (username.length < 16 && username.length > 3) {
            $('#twitter-ftusername').html(username);
            $(".phone-twitter-firsttimename").fadeOut(500);
        } else {
            if (locale == "de") {
                $("#phone-constant-radio").html(localede.usernameerror);
            } else {
                $("#phone-constant-radio").html(locale.usernameerror);
            }
        }
    }

});

// First time userid
$(document).on('click', '.twitter-edit-ftuserid', function() {
    $(".phone-twitter-firsttimeid").fadeIn(500);
    lastopen = "editftid"
});

$(document).on('click', '#ptw-firsttimerid', function() {
    let username = $('#ptw-ftid').val();


    let message1 = $('#ptw-ftid').val().toLowerCase();

    if (message1.indexOf('script') > -1 ||  message1.indexOf('http') > -1 || message1.indexOf('www') > -1 || message1.includes("<audio") == true || message1.includes("</audio") == true || message1.includes("html") == true || message1.includes("iframe") == true || message1.includes("img") == true || message1.includes("src") == true || message1.includes("div") == true || message1.includes("image") == true  || message1.includes("div") == true || message1.includes("mp4") == true || message1.includes("<") == true || message1.includes(">") == true ) {
        sendData("notification", { text: 'Nice try d:^)', length: 5000 })
    } else {
        if (username.length < 16 && username.length > 3) {
            if (username.includes("@") == true) {
                if (locale == "de") {
                    $("#phone-constant-radio").html(localede.usernameerror);
                } else {
                    $("#phone-constant-radio").html(locale.usernameerror);
                }
            } else {
                $('#twitter-ftuserid').html('@' + username.toLowerCase());
                $(".phone-twitter-firsttimeid").fadeOut(500);
            }
        } else {
            if (locale == "de") {
                $("#phone-constant-radio").html(localede.usernameerror);
            } else {
                $("#phone-constant-radio").html(locale.usernameerror);
            }
        }
    }


});

// First time submit
$(document).on('click', '#twitter-firsttimeregister', function() {
    let username = $('#twitter-ftusername').html();
    let userid = $('#twitter-ftuserid').html();
    let avatar = $('.phone-twitter-firsttime-avatar').data("url");

    let message1 = $('#twitter-ftusername').html().toLowerCase();
    let message2 = $('#twitter-ftuserid').html().toLowerCase();
    if (message1.indexOf('script') > -1 ||  message1.indexOf('http') > -1 || message1.indexOf('www') > -1 || message1.includes("<audio") == true || message1.includes("</audio") == true || message1.includes("html") == true || message1.includes("iframe") == true || message1.includes("img") == true || message1.includes("src") == true || message1.includes("div") == true || message1.includes("image") == true  || message1.includes("div") == true || message1.includes("mp4") == true || message1.includes("<") == true || message1.includes(">") == true ) {
        sendData("notification", { text: 'Nice try d:^)', length: 5000 })
    } else {
        if (message2.indexOf('script') > -1 || message2.indexOf('http') > -1 || message2.indexOf('www') > -1 || message2.includes("<audio") == true || message2.includes("</audio") == true) {
            sendData("notification", { text: 'Nice try d:^)', length: 5000 })
        } else {
            if (username != "Username" && userid != '@username' && username != " " && userid != " ") {
                sendData("twitter:register", { username: username, userid: userid, avatar: avatar })
            } else {
                if (locale == "de") {
                    $("#phone-constant-radio").html(localede.mustchange);
                } else {
                    $("#phone-constant-radio").html(locale.mustchange);
                }
            }
        }
    }

});

// Load Tweets
function LoadTweets(html) {
    $(".phone-tweets").children().detach();
    $(".phone-tweets").append(html);
    if (darkmode == true) {
        Darkmode();
    }
    $(".phone-twitter").fadeIn(500);
    $(".phone-tweets").fadeIn(500);

    $(".phone-tweets").scrollTop($(".phone-tweets")[0].scrollHeight);
}

function RefreshTweets(html) {
    $(".phone-tweets").children().detach();
    $(".phone-tweets").append(html);

    if (darkmode == true) {
        Darkmode();
    }
}

function LoadSettings(v) {
    $('.phone-twitter-settings-avatar').css("background-image", "url(" + v.avatar + ")");
    $('.phone-twitter-settings-avatar').data("url", v.avatar)
    $('#twitter-username').html(v.username);
}

//  Like Tweets
$(document).on('click', '.phone-tweet-footer-hearticon', function() {
    let id = $(this).data("id");

    sendData("twitter:liketweet", { id: id })
    if ($(this).attr("class") == "phone-tweet-footer-icons phone-tweet-footer-hearticon fas fa-heart liked") {
        $(this).removeClass("liked");
    } else {
        $(this).addClass("liked");
    }
});

function UpdateLikes(id, like) {
    $(".phone-tweet-footer-likes").each(function() {
        if ($(this).data("id") == id) {
            $(this).html(like);
        }
    })
}

function ShowLikedIcons(likedtweets) {
    for (x in likedtweets) {
        $(".phone-tweet-footer-hearticon").each(function() {
            if ($(this).data("id") == likedtweets[x].liked) {
                $(this).addClass("liked");
            }
        })
    };
}

//  Write Tweet
// $(document).on('click', '#ptw-tweetsubmit ', function() {
//     let message = $('#ptw-tweetinput').val();
//     let url = $('#ptw-addimage').data("url");

//     if (message.length > 0) {
//         sendData("twitter:writetweet", { message: message, url: url })
//     } else {
//         sendData("notification", { text: locale.notempty, length: 5000 })
//     }
// });

//  Write Tweet
$(document).on('click', '#ptw-tweetsubmit ', function() {
    let message = $('#ptw-tweetinput').val();
    let message1 = $('#ptw-tweetinput').val().toLowerCase();
    let url = $('#ptw-addimage').data("url");
    if (message1.indexOf('script') > -1 ||  message1.indexOf('http') > -1 || message1.indexOf('www') > -1 || message1.includes("<audio") == true || message1.includes("</audio") == true || message1.includes("html") == true || message1.includes("iframe") == true || message1.includes("img") == true || message1.includes("src") == true || message1.includes("div") == true || message1.includes("image") == true  || message1.includes("div") == true || message1.includes("mp4") == true || message1.includes("<") == true || message1.includes(">") == true ) {
        sendData("notification", { text: 'Nice try d:^)', length: 5000 })
    } else {
        if (message.length > 0) {
            sendData("twitter:writetweet", { message: message, url: url })
        } else {
            if (locale == "de") {
                $("#phone-constant-radio").html(localede.notempty);
            } else {
                $("#phone-constant-radio").html(locale.notempty);
            }
        }
    }
});

$(document).on('click', '#ptw-imagesubmit', function() {
    let avatar = $('#ptw-imageurl').val();
    let message1 = $('#ptw-imageurl').val().toLowerCase();

    if (message1.indexOf('script') > -1 ||  message1.includes("<audio") == true || message1.includes("</audio") == true || message1.includes("html") == true || message1.includes("iframe") == true || message1.includes("src") == true || message1.includes("div") == true || message1.includes("div") == true || message1.includes("mp4") == true || message1.includes("<") == true || message1.includes(">") == true ) {
        sendData("notification", { text: 'Nice try d:^)', length: 5000 })
    } else {
        if (avatar.includes("png") == true || avatar.includes("jpeg") == true || avatar.includes("jpg") == true || avatar.includes("gif") == true) {
            $('#ptw-addimage').addClass("activepicture");
            $('#ptw-addimage').data("url", avatar)
            $(".phone-twitter-image ").fadeOut(500);
        } else if (avatar == '') {
            $('#ptw-addimage').removeClass("activepicture");
            $('#ptw-addimage').data("url", '0');
            $(".phone-twitter-image ").fadeOut(500);
        } else {
            if (locale == "de") {
                $("#phone-constant-radio").html(localede.avatarerror);
            } else {
                $("#phone-constant-radio").html(locale.avatarerror);
            }
        }
    }

});

// Twitter notifcation settings
function twitternotification() {
    if (document.getElementById('twitternotification').checked) {
        sendData("twitter:updatenotification", { state: 1 });
    } else {
        sendData("twitter:updatenotification", { state: 0 });
    };
};


            