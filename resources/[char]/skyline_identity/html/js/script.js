$(function() {
	window.addEventListener('message', function(event) {
		if (event.data.type == "enableui") {
			document.body.style.display = event.data.enable ? "block" : "none";
		}
	});

	document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
			$.post('https://skyline_identity/escape', JSON.stringify({}));
		}
	};
	
	$("#register").submit(function(event) {
		
		event.preventDefault(); // Prevent form from submitting
		
		// Verify date
		var date = $("#dateofbirth").val();
		var dateCheck = new Date($("#dateofbirth").val());

		if (dateCheck == "Invalid Date") {
			date == "invalid";
		}
		
		if($("input[type='radio'][name='sex']:checked").val() != undefined){
			$.post('https://skyline_identity/register', JSON.stringify({
				firstname: $("#firstname").val(),
				lastname: $("#lastname").val(),
				dateofbirth: date,
				sex: $("input[type='radio'][name='sex']:checked").val(),
				height: $("#height").val()
			}));
		}

	});
});
