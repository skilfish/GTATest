$(document).ready(function(){
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.action == 'open') {
      var type        = event.data.type;
      var userData    = event.data.array['user'][0];
      var licenseData = event.data.array['licenses'];
      var sex         = userData.sex;

      if ( type == 'driver' || type == null) {
        $('img').show();
        $('#name').text(userData.firstname + ' ' + userData.lastname);
        $('#dob').text(userData.dateofbirth);

        if(userData.sex === "m") {
          $("#sex").text("Männlich")
        }else {
          $("#sex").text("Weiblich")
        }

        $('#height').text(userData.height + "cm");
  
        $('#signature').text(userData.firstname + ' ' + userData.lastname);

        if ( type == 'driver' ) {
          if ( licenseData != null ) {
          Object.keys(licenseData).forEach(function(key) {
            var type = licenseData[key].type;

            if ( type == 'drive_bike') {
              type = 'bike';
            } else if ( type == 'drive_truck' ) {
              type = 'truck';
            } else if ( type == 'drive' ) {
              type = 'car';
            }

            if ( type == 'bike' || type == 'truck' || type == 'car' ) {
              $('#licenses').append('<p>'+ type +'</p>');
            }
          });
        }

          $('#id-card').css('background', 'url(assets/images/license.png)');
        } else {
          $('#id-card').css('background', 'url(assets/images/idcard.png)');
        }
      } else if ( type == 'weapon' ) {
        $('img').hide();
        $('#name').text(userData.firstname + ' ' + userData.lastname);
        $('#dob').text(userData.dateofbirth);
        $('#signature').text(userData.firstname + ' ' + userData.lastname);

        $('#id-card').css('background', 'url(assets/images/firearm.png)');
      }

      $('#id-card').show();
    } else if (event.data.action == 'close') {
      $('#name').text('');
      $('#dob').text('');
      $('#height').text('');
      $('#signature').text('');
      $('#sex').text('');
      $('#id-card').hide();
      $('#licenses').html('');
    }
  });
});
