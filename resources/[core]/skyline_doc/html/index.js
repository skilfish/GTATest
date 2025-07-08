$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
                $('.own-player-page').hide()
                $('.open-player-page').fadeIn(100)
            } else {
                display(false)
            }
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://skyline_doc/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('https://skyline_doc/exit', JSON.stringify({}));
        return;
    })

    $("#persoan").click(function(){
        $.post('https://skyline_doc/persoan', JSON.stringify({}));
        return
    })

    $("#persozei").click(function(){
        $.post('https://skyline_doc/persozei', JSON.stringify({}));
        return
    })

    $("#fur").click(function(){
        $.post('https://skyline_doc/fur', JSON.stringify({}));
        return
    })

    $("#ausweiszie").click(function(){
        $.post('https://skyline_doc/ausweiszie', JSON.stringify({}));
        return
    })

    $("#fure").click(function(){
        $.post('https://skyline_doc/fure', JSON.stringify({}));
        return
    })

    $("#waffenan").click(function(){
        $.post('https://skyline_doc/waffenan', JSON.stringify({}));
        return
    })

    $("#waffenze").click(function(){
        $.post('https://skyline_doc/waffenze', JSON.stringify({}));
        return
    })
})