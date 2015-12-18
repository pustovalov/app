// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap.min

function fadeFlash() {
  $(".alert-success").delay(5000).fadeOut("slow");
  $(".alert-danger").delay(5000).fadeOut("slow");
  $(".alert-warning").delay(5000).fadeOut("slow");
}

function showNotice(msg, type) {
  $("#flash-message")
    .html('<div class="alert fade in ' + type + '">' + msg + '</div>');
  fadeFlash();
}

$(document).ajaxComplete(function(event, data) {
    var msg   = data.responseJSON.notice.replace(/\n/g,"<br>"),
        type  = data.responseJSON.type;

    if (msg && type) {
      showNotice(msg, type);
    }
});
