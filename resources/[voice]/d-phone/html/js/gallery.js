let gallery = {
    footer : {
        state: true,
        select: {
            state: false,
            selected : [],
        }
    }
}


$(document).on('click', '#gallery-selectbutton', function() {
    console.log("test")
    if (gallery.footer.state) {
        gallery.footer.state = false
        gallery.footer.select.state = true
        $(this).html("Cancel");
    } else {
        gallery.footer.state = true
        gallery.footer.select.state = false
        $(this).html("Select");
    }

    gallery.footer.show(gallery.footer.state)
    gallery.footer.select.show(gallery.footer.select.state)

})

gallery.footer.select.show = function(state) {
    let height = 0;

    if (state == true) height = 100;

    $("#gallery-footer-select").animate({
        "height": `${height}%`
    }, 25)
}

gallery.footer.show = function(state) {
    let height = 0;

    if (state == true) height = 100;

    $("#gallery-footer").animate({
        "height": `${height}%`
    }, 25)
}

$(document).on('click', '.gallery-element', function() {
    console.log("gallerytest")
    if (gallery.footer.select.state) {
        let id = $(this).data("id")
        if ($(this).children('i.checked.fa-solid.fa-circle-check').is(":visible")) {
            $(this).children('i.checked.fa-solid.fa-circle-check').hide(500)
            let pos = gallery.footer.select.selected.indexOf(id)
            gallery.footer.select.selected.splice(pos, 1)
        } else {
            $(this).children('i.checked.fa-solid.fa-circle-check').show(500)
            gallery.footer.select.selected.push(id)
        }
        console.log(gallery.footer.select.selected)
    }
});

$(document).on('click', '#gallery-footer-select-delete', function() {
    gallery.delete(gallery.footer.select.selected)
});

gallery.delete = function (idarray) {
    var selected = gallery.footer.select.selected
    idarray.forEach(function(item, index, array) {
        $('.gallery-element').each(function (i, e) {
            if ($(this).data("id") == item) {
                $(this).hide(500)
              
                setTimeout(function () {
                    $(this).remove()
                    gallery.footer.select.selected.splice(index, 1)

                }, 500)
            }
        });
    });

    console.log(gallery.footer.select.selected)
}