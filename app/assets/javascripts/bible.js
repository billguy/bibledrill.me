//= require bootstrap/tab
//= require jquery.sticky-kit
//= require jquery.clearsearch
//= require dragula

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

var Bible = {
    init: function(){
        $('.clearable').clearSearch({
            callback: function() {
                $("#q").blur();
                Bible.showBible();
            }
        });
        $('#search-form').on('submit', function(){
            $("#q").blur();
            $('#search-results').html('<i>Please wait...</i>');
            Bible.showSearch();
        });
    },
    showSearch: function(){
        $('.bible').addClass('hidden');
        $('#search-results').removeClass('hidden');
    },
    showBible: function(){
        $('.bible').removeClass('hidden');
        $('#search-results').addClass('hidden');
    }
};

Bible.init();

$('body').on('click', 'ol.chapter li span', function(){
//    if ($(this).hasClass('selected')){
//        $(this).removeClass('selected');
//        $(this).next('a.verse-link').addClass('hidden');
//    } else {
//        $(this).addClass('selected');
//        $(this).next('a.verse-link').removeClass('hidden');
//    }
    var verse_id = $(this).data('verse-id');
    var highlight_path = $(this).data('highlight-path');
    $.getScript({
      type: "POST",
      url: highlight_path,
      data: { _method:'PUT', id: verse_id },
      dataType: 'json',
      success: function(msg) {
        alert( "Data Saved: " + msg );
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