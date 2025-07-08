$(function () {
    function display(bool, item) {
        if (bool) {
            $("#exam-selector").hide()
            $("#questions").hide()
            $("#congrats").hide()
            $("#fail").hide()
            $("#signals").hide()
            $("#license-moto-price").text(item.priceA+"$")
            $("#license-car-price").text(item.priceB+"$")
            $("#license-truck-price").text(item.priceC+"$")
            $("#license-selector").show()
            document.getElementById("body").style.display="block";
        } else {
            document.getElementById("body").style.display="none";
        }
    }

    function licenses(item){
        if (item.theorical === true) {
            $("#exam-selector-check-theorical").show()
        } else {
            $("#exam-selector-check-theorical").hide()
        }
        if (item.practice === true) {
            $("#exam-selector-check-practice").show()
        } else {
            $("#exam-selector-check-practice").hide()
        }
        $("#exam-selector-type").text(item.selectedlicense)
        $("#license-selector").hide()
        $("#exam-selector").show()
        $("#signals").hide()
    }

    function updateQuestions(item){
        $("#exam-selector").hide()
        $("#question-text").text(item.actualquestion)
        $("#answer1-text").text(item.actualanswer1)
        $("#answer2-text").text(item.actualanswer2)
        $("#answer3-text").text(item.actualanswer3)
        $("#questions").show()
        $("#signals").hide()
    }

    function tts(item) {
        if (item.route === 1) {
            $("#signals-errors").text(item.errors+'/'+item.maxerrors)
            $("#signals-img").attr('src','./img/'+item.signal+'.png')
            $("#signals").show()
            $("#tts1").attr("src","./sounds/1"+item.ttslan+".mp3")
            var audio = document.getElementById("tts1");
            audio.play();
        }
        if (item.route === 2) {
            $("#tts2").attr("src","./sounds/2"+item.ttslan+".mp3")
            var audio = document.getElementById("tts2");
            audio.play();
        }
        if (item.route === 3) {
            console.log('./img/'+item.signal+'.png')
            $("#signals-img").attr('src','./img/'+item.signal+'.png')
            $("#tts3").attr("src","./sounds/3"+item.ttslan+".mp3")
            var audio = document.getElementById("tts3");
            audio.play();
        }
        if (item.route === 4) {
            console.log('./img/'+item.signal+'.png')
            $("#signals-img").attr('src','./img/'+item.signal+'.png')
            $("#tts4").attr("src","./sounds/4"+item.ttslan+".mp3")
            var audio = document.getElementById("tts4");
            audio.play();
        }
        if (item.route === 5) {
            $("#tts5").attr("src","./sounds/5"+item.ttslan+".mp3")
            var audio = document.getElementById("tts5");
            audio.play();
        }
        if (item.route === 6) {
            $("#tts6").attr("src","./sounds/6"+item.ttslan+".mp3")
            var audio = document.getElementById("tts6");
            audio.play();
        }
        if (item.route === 7) {
            $("#tts7").attr("src","./sounds/7"+item.ttslan+".mp3")
            var audio = document.getElementById("tts7");
            audio.play();
        }
        if (item.route === 8) {
            $("#tts8").attr("src","./sounds/8"+item.ttslan+".mp3")
            var audio = document.getElementById("tts8");
            audio.play();
        }
        if (item.route === 9) {
            $("#tts9").attr("src","./sounds/9"+item.ttslan+".mp3")
            var audio = document.getElementById("tts9");
            audio.play();
        }
        if (item.route === 10) {
            if (item.errors === false) {
                $("#signals").hide()
                $("#tts10").attr("src","./sounds/10"+item.ttslan+"ok.mp3")
                var audio = document.getElementById("tts10");
                audio.play();
            } else {
                $("#signals").hide()
                $("#tts10").attr("src","./sounds/10"+item.ttslan+"no.mp3")
                var audio = document.getElementById("tts10");
                audio.play();
            }
        }
        if (item.route === 'crash') {
            $("#signals-errors").text(item.errors+'/'+item.maxerrors)
            $("#crash").attr("src","./sounds/crash"+item.ttslan+".mp3")
            var audio = document.getElementById("crash");
            audio.play();
        }
        if (item.route === 'speed') {
            $("#signals-errors").text(item.errors+'/'+item.maxerrors)
            $("#speed").attr("src","./sounds/speed"+item.ttslan+".mp3")
            var audio = document.getElementById("speed");
            audio.play();
        }
        if (item.route === 'fails') {
            $("#fails").attr("src","./sounds/fails"+item.ttslan+".mp3")
            var audio = document.getElementById("fails");
            audio.play();
        }
    }

    function errors(item){
        $("#container").hide()
        $("#signals").attr('src','./img/'+item.signal+'.png')
        $("#signals").show()
    }
    
    function reset(item){
        $("#exam-selector").hide()
        $("#questions").hide()
        $("#congrats").hide()
        $("#fail").hide()
        $("#signals").hide()
        $("#container").show()
        $("#license-selector").show()
        document.getElementById("body").style.display="block";
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true, item)
            } else {
                display(false)
            }
        }
        if (item.type === "examok") {
            $("#questions").hide()
            $("#congrats").show()
        }
        if (item.type === "examno") {
            $("#questions").hide()
            $("#fail").show()
        }
        if (item.type === "licenses") {
            licenses(item)
        }
        if (item.type === "updateQuestions") {
            updateQuestions(item)
        }
        if (item.type === "tts") {
            tts(item)
        }
        if (item.type === "errors") {
            errors(item)
        }
        if (item.type === "reset") {
            reset(item)
        }
    })

    $("#license-moto").click(function () { 
        $.post('https://skyline_driverschool/license', JSON.stringify({
            text: 'A'
        }));
    })
    
    $("#license-car").click(function () { 
        $.post('https://skyline_driverschool/license', JSON.stringify({
            text: 'B'
        }));
    })
    
    $("#license-truck").click(function () { 
        $.post('https://skyline_driverschool/license', JSON.stringify({
            text: 'C'
        }));
    })

    $("#theorical").click(function () { 
        $.post('https://skyline_driverschool/theorical', JSON.stringify({}));
    })
    
    $("#practice").click(function () { 
        $.post('https://skyline_driverschool/practice', JSON.stringify({}));
    })
    
    $("#answer1").click(function () { 
        $.post('https://skyline_driverschool/answer', JSON.stringify({
            text: 1
        }));
    })

    $("#answer2").click(function () { 
        $.post('https://skyline_driverschool/answer', JSON.stringify({
            text: 2
        }));
    })

    $("#answer3").click(function () { 
        $.post('https://skyline_driverschool/answer', JSON.stringify({
            text: 3
        }));
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://skyline_driverschool/exit', JSON.stringify({}));
            return
        }
    };
        
})