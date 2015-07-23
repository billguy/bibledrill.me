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
//= require bootstrap/tab
//= require hammer

if (history && history.pushState){
  $(function(){
   $('body').on('click', 'a[data-remote="true"]', function(e){
      $.getScript(this.href);
      history.pushState(null, '', this.href);
    });
    $(window).bind("popstate", function(){
      $.getScript(location.href);
    });
  });
}

$('body').on('click', 'ol.chapter li', function(){
    var path = $(this).data('path');
    $.getScript(path);
});

var content = document.getElementById('content');
var hammertime = new Hammer(content);
hammertime.on('swipeleft', function(ev) {
    var next_path = content.getAttribute('data-next-path');
    console.log(next_path);
    if (next_path) {
        $.getScript(next_path);
    }
});

hammertime.on('swiperight', function(ev) {
    var prev_path = content.getAttribute('data-prev-path');
    console.log(prev_path);
    if (prev_path) {
        $.getScript(prev_path);
    }
});