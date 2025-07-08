var a = false 
function closeMain() {
    $('body').css('display', 'none')
}



var bb = 1;


window.addEventListener('message', function (event) {
    var e = event.data;

    if (e.message == 'tick') {
        $("#leben").attr("src" , "img/" + bb + ".png")
        bb++;
        
      
        if(bb == 9) {
            setTimeout(function(){
                bb = 1;
                $("#leben").attr("src" , "img/" + bb + ".png")
            }, 490);
        }
    };

});


window.addEventListener('message', function (event) {
    var e = event.data;
    if (e.message == 'showdeathscreen') {
        $('body').css('display', 'block')
    };

    if (e.message == 'updatetext') {
        document.getElementById('killer').innerHTML = e.killedby
    };
  
    if (e.message == 'hide') {
        a = false 
        closeMain()
    }
});
