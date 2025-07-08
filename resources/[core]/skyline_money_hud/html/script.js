var blackmoney = false;

$(document).ready(function() {
	window.addEventListener("message" , function(event) {
		var data = event.data; 

		if (data.action == "showH") {
			$("#HUDv2").show();
		};

		if (data.action == "hideH") {
			$("#HUDv2").hide();
		};

	});
});

$(document).ready(function () {
    window.addEventListener("message", function (event) {
        if (event.data.action == "setMoney") {

			setAnzahl(event.data.money);
		    $(".money").show();
  			$("money").show();
        	};
        if (event.data.action == "setBlackMoney") {
			blackmoney = true;
          setAnzahle(event.data.black);
  		$(".schwarzmoney").show();
  $("schwarzmoney").show();



        };
		        if (event.data.action == "show") {
					if(!blackmoney) {
  $(".funkeblack").hide();
						  $(".funkblack").hide();

  $(".funk").show();
  $(".funke").hide();
					} else {
						  $(".funkblack").show();
 						 $(".funkeblack").hide();
  
    $(".funk").hide();
  $(".funke").hide();
					}

        };
				        if (event.data.action == "hide") {
							
					if(!blackmoney) {
						  $(".funkblack").hide();
  $(".funkeblack").hide();
  $(".funk").hide();
  $(".funke").show();
					} else {
						  $(".funkblack").show();
  							$(".funkeblack").show();
  
   						 $(".funk").hide();
 						 $(".funke").show();
					}

        };
						        if (event.data.action == "weg") {
  $(".funk").hide();
  $(".funke").hide();
  $(".funkblack").hide();
  $(".funkeblack").hide();

        };
		

						
					if (event.data.action == "nomuted") {
						$("#microphone-solid_2").hide();
						$("#microphone-solid_1").show();
					};

						if (event.data.action == "muted") {
							$("#microphone-solid_1").hide();
							$("#microphone-solid_2").show();
					};


		        if (event.data.action == "setVoiceLevel") {
					  $(".voice1").hide();
					  $(".voice2").hide();
					  $(".voice3").hide();
					  $(".voice4").hide();

 					 $(".voice" + event.data.level).show();
     			   };


        if (event.data.action == "hideBlackMoney") {
  $(".schwarzmoney").hide();
  $("schwarzmoney").hide();
  blackmoney = false;
		
	};

    });
});

function setAnzahl(anzahl) {
    document.getElementById("content").innerHTML = new Intl.NumberFormat('de-DE').format(anzahl) + " $";

}
function setAnzahle(anzahl) {
    document.getElementById("content2").innerHTML = new Intl.NumberFormat('de-DE').format(anzahl) + " $";

}
