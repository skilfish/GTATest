$('document').ready(function() {
    MythicProgBar = {};
									$("#Progressbar").hide();

    MythicProgBar.Progress = function(data) {

		
		   $("#Progressbar").show();
							var start = new Date();
							var maxTime = data.duration;
							var percentage = percentage;
							var timeoutVal = Math.floor(1000);
							animateUpdate();

							
							

							function updateProgress(percentage) {
							    $('.progress-bar-fill').css("width", percentage + "%");
								$('.text').text(percentage + "%");
							}


							function animateUpdate() {
								var now = new Date();
								var timeDiff = now.getTime() - start.getTime();
								var perc = Math.round((timeDiff/maxTime)*100);
								if (perc <= 100) {
									updateProgress(perc);
									setTimeout(animateUpdate, timeoutVal);
								} else {
									
									$("#Progressbar").hide();
																		    $('.progress-bar-fill').css("width", "0%");

									            $.post('https://skyline_progressbar/actionFinish', JSON.stringify({
                })
            );
								}
							}


    };

    MythicProgBar.ProgressCancel = function() {


        setTimeout(function () {
									$(".Progressbar").hide();



            $.post('https://skyline_progressbar/actionCancel', JSON.stringify({
                })
            );
        }, 1000);
    };

    MythicProgBar.CloseUI = function() {
        $('.main-container').css({"display":"none"});
        $(".character-box").removeClass('active-char');
        $(".character-box").attr("data-ischar", "false")
        $("#delete").css({"display":"none"});
    };
    
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case 'mythic_progress':
                MythicProgBar.Progress(event.data);
                break;
            case 'mythic_progress_cancel':
                MythicProgBar.ProgressCancel();
                break;
        }
    })
});
