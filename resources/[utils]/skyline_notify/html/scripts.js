$(function () {
    var sound = new Audio('sound.mp3');
    sound.volume = 0.5;
    var sound2 = new Audio('police.mp3');
    sound2.volume = 0.5;
    window.addEventListener('message', function (event) {
        if (event.data.action == 'open') {
            var number = Math.floor((Math.random() * 1000) + 1);
            $('.notify').append(`
            <div class="wrapper-${number}">
                <div class="notification_main-${number}">
                    <div class="title-${number}"></div>
                    <div class="text-${number}">
                        ${event.data.message}
                    </div>
                </div>
            </div>`)
            $(`.wrapper-${number}`).css({
                "margin-bottom": "10px",
                "width": "275px",
                "margin": "0 0 8px -180px",
                "border-radius": "15px"
            })
            $('.notification_main-'+number).addClass('main')
            $('.text-'+number).css({
                "font-size": "12px"
            })

            if (event.data.type == 'success') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('success-icon')
                $(`.wrapper-${number}`).addClass('success')
                sound.play();
            } else if (event.data.type == 'info') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('info-icon')
                $(`.wrapper-${number}`).addClass('info')
                sound.play();
            } else if (event.data.type == 'police') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('police-icon')
                $(`.wrapper-${number}`).addClass('police')
                sound2.play();
            } else if (event.data.type == 'error') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('error-icon')
                $(`.wrapper-${number}`).addClass('error')
                sound.play();
            } else if (event.data.type == 'warning') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('warning-icon')
                $(`.wrapper-${number}`).addClass('warning')
                sound.play();
            } else if (event.data.type == 'sms') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('sms-icon')
                $(`.wrapper-${number}`).addClass('sms')
                sound.play();
            } else if (event.data.type == 'long') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('long-icon')
                $(`.wrapper-${number}`).addClass('long')
                sound.play();
            }
            anime({
                targets: `.wrapper-${number}`,
                translateX: -60,
                duration: 750,
                easing: 'spring(5, 100, 35, 10)',
            })
            setTimeout(function () {
                anime({
                    targets: `.wrapper-${number}`,
                    translateX: 500,
                    duration: 750,
                    easing: 'spring(5, 80, 5, 0)'
                })
                setTimeout(function () {
                    $(`.wrapper-${number}`).remove()
                }, 750)
            }, event.data.time)
        }
    })
})