//= require bootstrap/tab
//= require bootstrap/modal
//= require bootstrap/tooltip
//= require bootstrap/popover
//= require jquery.sticky-kit
//= require spin
//= require jquery.spin
//= require search

if (history && history.pushState){
  $(function(){
   $(document).on('click', 'a[data-remote="true"]', function(e){
        if (!$(this).hasClass('x'))
            history.pushState(null, '', this.href);
    });
    $(window).bind("popstate", function(){
        $.getScript(location.href);
    });
  });
}

$(".sticky").stick_in_parent();

$(document).on('ajaxComplete', function() {
    $(".sticky").stick_in_parent();
});

$('body').on('click', 'ol.verses li span.verse', function(){
    var verse_id = $(this).data('verse-id');
    var highlight_path = $(this).data('highlight-path');
    $.ajax({
      type: "POST",
      url: highlight_path,
      data: { _method:'PUT', id: verse_id }
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
        if (verses.length > 0){
            $read_link.addClass('glow');
            verse_path = $read_link.data('verse-path');
            $read_link.attr('href', verse_path + '/' + verses.join(','));
        } else {
            $read_link.removeClass('glow');
            var chapter_path = $read_link.data('chapter-path');
            $read_link.attr('href', chapter_path);
        }
    } else {
        $(this).addClass('selected');
        $read_link.addClass('glow');
        verses.push(verse_number);
        verse_path = $read_link.data('verse-path');
        $read_link.attr('href', verse_path + '/' + verses.join(','));
    }
});

$('body').on('click', 'ul.verses li.read a', function(e){
    verses = [];
});

$('body').on('click', 'a.x', function(){
    $(this).hide();
    var opts = { lines: 15, length: 10, width: 3, radius: 1, scale: 0.5, corners: 1, color: '#000', opacity: 0.25, rotate: 0, direction: 1, speed: 1, trail: 60, fps: 20, zIndex: 2e9, className: 'spinner', top: '50%', left: '50%', shadow: false, hwaccel: false, position: 'absolute'};
    $(this).next('span.s').spin(opts);
});


$('body').on('click', 'ol.breadcrumb a[data-quick-menu=true]', function(e){
    e.preventDefault();
    e.stopImmediatePropagation();
    var menu = $(this).data('menu');
    $(this).popover({
        placement: 'bottom',
        trigger: 'focus',
        html: true,
        content: function(){
            return $(menu).html();
        }
    }).popover("toggle");
});