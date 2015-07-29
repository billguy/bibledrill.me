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
//= require jquery.cookie
//= require bootstrap/tab
//= require bootstrap/affix
//= require jquery.hammer
//= require noty

if (history && history.pushState){
  $(function(){
   $(document).on('click', 'a[data-remote="true"]', function(e){
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
    history.pushState(null, '', path);
});

$('#content').hammer()
    .on('swipeleft', function(ev) {
        var next_path = content.getAttribute('data-next-path');
        if (next_path) {
            $.getScript(next_path).success( function( data, textStatus, jqxhr ) {
                window.scrollTo(0, 0);
                history.pushState(null, '', next_path);
            });
        }
    })
    .on('swiperight', function(ev) {
        var prev_path = content.getAttribute('data-prev-path');
        if (prev_path) {
            $.getScript(prev_path).success( function( data, textStatus, jqxhr ) {
                window.scrollTo(0, 0);
                history.pushState(null, '', prev_path);
            });
        }
});

$('body').on('ajaxComplete', function(){
    $('ol.breadcrumb').affix({
      offset: {
        top: 0,
        bottom: function () {
          return (this.bottom = $('.footer').outerHeight(true))
        }
      }
    });
});

var verses = [];
$('body').on('click', 'ul.verses li:not(.read) a', function(e){
    e.stopImmediatePropagation();
    e.preventDefault();

    var $read_link = $(this).closest('ul').find('li.read a');
    var verse_number = $(this).data('number');

    if ($(this).hasClass('selected')){
        $(this).removeClass('selected');
        var index = $.inArray(verse_number, verses);
        verses.splice(index, 1);
        if (verses.length){
            verse_path = $read_link.data('verse-path');
            $read_link.attr('href', verse_path + '/' + verses.join(','));
        } else {
            var chapter_path = $read_link.data('chapter-path');
            $read_link.attr('href', chapter_path);
        }
    } else {
        $(this).addClass('selected');
        verses.push(verse_number);
        verse_path = $read_link.data('verse-path');
        $read_link.attr('href', verse_path + '/' + verses.join(','));
    }

    if ($(this).closest('ul').find('li a.selected').length) {
        $read_link.addClass('glow');
    } else {
        $read_link.removeClass('glow');
    }
});

$('body').on('click', 'ul.verses li.read a', function(e){
    verses = [];
});