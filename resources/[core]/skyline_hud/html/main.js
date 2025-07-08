﻿window.addEventListener("message", function (event) {
  switch (event.data.action) {
    case "hideH":
      $("body").hide();
    break;
    case "showH":
      $("body").show();
      break;
    case "show":
      $("body").fadeIn(400);
      break;
      case "hide":
        $("body").fadeOut(200);
        break;
      case "rescale":
          var a = event.data.val * 100 - 0.5;
          $(".main").css("left" , a + "%");
          break;
    case "hud":
      Progress(event.data.health, ".health");
      Progress(event.data.armor, ".armor");
      Progress(event.data.thirst, ".thirst");
      Progress(event.data.hunger, ".hunger");
      break;
    case "showui":
      $("body").fadeIn();
      break;
    case "hideui":
      $("body").fadeOut();
      break;
    case "voice-color":
      if (event.data.isTalking) {
        $("#voiceon").fadeIn();
      } else {
        $("#voiceon").fadeOut();
      }
      break;
    case "voice":
      if (event.data.prox === 0) {
        $("#voiceshout").fadeIn();
        $("#voicenormal").fadeIn();
        $("#voicewhisper").fadeIn();
        $("#box").fadeIn();
      } else if (event.data.prox === 1) {
        $("#voicenormal").fadeIn();
        $("#voiceshout").fadeOut();
        $("#voicewhisper").fadeIn();
        $("#box").fadeIn();
      } else if (event.data.prox === 2) {
        $("#voicewhisper").fadeIn();
        $("#voicenormal").fadeOut();
        $("#voiceshout").fadeOut();
        $("#box").fadeIn();
      }
      break;
    /* case "car":
      if (event.data.showhud == true) {
        $(".hudCar").fadeIn();
        setProgressSpeed(event.data.speed, ".progress-speed");
        setProgressFuel(event.data.fuel, ".progress-fuel");
      } else {
        $(".hudCar").fadeOut();
      }
      break;
    case "seatbelt":
      if (event.data.seatbelt) {
        $(".car-seatbelt-info img").attr("src", "./seatbelt-on.png");
      } else {
        $(".car-seatbelt-info img").attr("src", "./seatbelt.png");
      }
      break; */
  }
});

function Progress(percent, element) {
  var circle = document.querySelector(element);
  var radius = circle.r.baseVal.value;
  var circumference = radius * 2 * Math.PI;
  var html = $(element).parent().parent().find("span");

  circle.style.strokeDasharray = `${circumference} ${circumference}`;
  circle.style.strokeDashoffset = `${circumference}`;

  const offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
  circle.style.strokeDashoffset = -offset;

  html.text(Math.round(percent));
}

function setProgressSpeed(value, element) {
  var circle = document.querySelector(element);
  var radius = circle.r.baseVal.value;
  var circumference = radius * 2 * Math.PI;
  var html = $(element).parent().parent().find("span");
  var percent = (value * 100) / 220;

  circle.style.strokeDasharray = `${circumference} ${circumference}`;
  circle.style.strokeDashoffset = `${circumference}`;

  const offset = circumference - ((-percent * 73) / 100 / 100) * circumference;
  circle.style.strokeDashoffset = -offset;

  var speed = Math.floor(value * 1.8);
  if (speed == 81 || speed == 131) {
    speed = speed - 1;
  }

  html.text(speed);
}

function setProgressFuel(percent, element) {
  var circle = document.querySelector(element);
  var radius = circle.r.baseVal.value;
  var circumference = radius * 2 * Math.PI;
  var html = $(element).parent().parent().find("span");

  circle.style.strokeDasharray = `${circumference} ${circumference}`;
  circle.style.strokeDashoffset = `${circumference}`;

  const offset = circumference - ((-percent * 73) / 100 / 100) * circumference;
  circle.style.strokeDashoffset = -offset;

  html.text(Math.round(percent));
}
