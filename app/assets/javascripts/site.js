//= require wow_book
//= require nouislider
//= require jquery.timer.js

$(document).ready(function() {

    var max = $('#slider').data('slider-max');
    var slider = document.getElementById('slider');
    var randomVersePath = $('#refresh').data('path');
    var timer = $.timer(function(){}).stop();
    var incrementTime = 70;
    var currentTime = 0;

    noUiSlider.create(slider, {
        start: 0,
        orientation: 'vertical',
        step: 1,
        range: {
            'min': 0,
            'max': max + 1
        }
    });

    var bible = $('#bible').wowBook({
      height : 800,
      width  : 950,
      turnPageDuration: 10,
      hardcovers: true,
      flipSound: false,
      scaleToFit: "#jacket",
      updateBrowserURL: false,
      onShowPage: function(book, page, pageIndex) {
        var pageNumber = pageIndex - 1;
        slider.noUiSlider.set(pageNumber);

        loadPagesForPageNumber(pageNumber, book);

        if (pageNumber >= 0){
            if ($('#slider-container').hasClass('hidden'))
                $('#slider-container').fadeIn().removeClass('hidden');
        } else {
            $('#slider-container').fadeOut().addClass('hidden');
        }
      }
    });

    function loadPagesForPageNumber(pageNumber, book){
        pages = [pageNumber-3, pageNumber-2, pageNumber, pageNumber+2, pageNumber+3];
        for (index = 0; index < pages.length; ++index) {
            number = pages[index];
            p = book.pages[number];
            if (p && !p.attr('data-page')){
                p.attr('data-page', number);
                $.getScript('/pages/' + number);
            }
        }
    }

    slider.noUiSlider.on('change', function(values, handle) {
        page = Math.floor(values[handle]);
        bible.wowBook('gotoPage', page);
    });

    $('#bible').on('click', 'a.verse', function(){
        var random_verse_id = $('#random-verse').data('verse-id');
        var verse_id = $(this).data('verse-id');
        if (verse_id == random_verse_id){
            timer.stop();
            var timeTaken = $('#timer').html();
            alert("You found it in " + timeTaken);
        }
    });

    $('#refresh').on('click', function(e){
        e.stopImmediatePropagation();
        e.preventDefault();
        bible.wowBook('gotoPage', 0);
        loadRandomVerse();
    });

    $('#bible').fadeIn(function(){
        $('.loader').addClass('hidden');
        $.getScript(randomVersePath).success(function(){
            loadRandomVerse();
        });
    });

    function loadRandomVerse(){
        currentTime = 0;
        timer.stop().once();
        if ($('#timer-container').hasClass('hidden'))
            $('#timer-container').fadeIn().removeClass('hidden');
        $.getScript(randomVersePath).success(function(){
            timer = $.timer(updateTimer, incrementTime, true);
        });
    }

    function pad(number, length) {
        var str = '' + number;
        while (str.length < length) {str = '0' + str;}
        return str;
    }

    function formatTime(time) {
        time = time / 10;
        var min = parseInt(time / 6000),
            sec = parseInt(time / 100) - (min * 60),
            hundredths = pad(time - (sec * 100) - (min * 6000), 2);
        return (min > 0 ? pad(min, 2) : "00") + ":" + pad(sec, 2) + ":" + hundredths;
    }

    function updateTimer() {
        var timeString = formatTime(currentTime);
        $('#timer').html(timeString);
        currentTime += incrementTime;
    }

});