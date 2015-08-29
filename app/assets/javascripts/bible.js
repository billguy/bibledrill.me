//= require jquery.cookie
//= require bootstrap/tab
//= require jquery.sticky-kit
//= require jquery.hammer

delete Hammer.defaults.cssProps.userSelect;

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

function detectSpeechEnabled() {
    if ('speechSynthesis' in window) {
        $('.text-to-speech').removeClass('disabled');
        window.speechSynthesis.cancel();
    } else {
        $('.text-to-speech').addClass('enabled');
    }
}

detectSpeechEnabled();

$(document).on('ajaxComplete', function() {
    detectSpeechEnabled();
    $(".sticky").stick_in_parent();
});

$('body').on('click', '.text-to-speech a', function(e){
    e.preventDefault();
    if (window.speechSynthesis.speaking){
        window.speechSynthesis.cancel();
    } else {
        $('span.verse').each(function(index, verse) {
            var utterance = new SpeechSynthesisUtterance( $(verse).html() );
            utterance.rate = 1;
            window.speechSynthesis.speak(utterance);
        });
    }
});

$(".sticky").stick_in_parent();